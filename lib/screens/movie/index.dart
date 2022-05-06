import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/pages/list_playlist.dart';
import 'package:homi/services/get_homepage_banner.dart';
import 'package:homi/services/get_movie_details.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_box/video_box.dart';

class MoviePage extends StatefulWidget {
  String slug;
  String title;
   MoviePage({this.slug = '',this.title = ''});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Widget> slides = [];
  List<Response> movie_details = [];
  int secondsWatched = 0;
  bool isMore = false;
  List<T> map<T>(int listLength, Function handler) {
    List list = [];
    for (var i = 0; i < listLength; i++) {
      list.add(i);
    }
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  _onShareData(BuildContext context) async {

    await Share.share("ds", subject: "TopFives",);
  }

  VideoController? vcs ;

  getMovieDetails()async{
    // try{
    var js = await doPost('medias/api/v2/videos/${widget.slug}',{"screen":"${responseUserData.isNotEmpty ? responseUserData[0].id : ""}"});
    print("res timeline: $js");
    if(js["status"] == 'success'){
      Response responseScreens = Response.fromJson(js["response"]);
      movie_details.add(responseScreens);
      vcs = (VideoController(source: VideoPlayerController.network(movie_details[0].videoInfo!.hlsPlaylistUrl!),autoplay: true,)
        ..initialize())
        ..addListener(() {
          if(vcs!.value.position.inSeconds == 30){
            print("pSeconds value:${vcs!.value.position.inSeconds}");
          }
          secondsWatched = vcs!.value.position.inSeconds;
        });
      setState(() {
        print("len:${movie_details[0].videoInfo!.description!.length}");
        if(movie_details[0].videoInfo!.description!.length > 30){
          isMore = true;
        }else{
          isMore = false;
        }
      });
    }else{
      toast(js["message"]);
    }


    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }

  }



  @override
  void dispose() {
    vcs!.dispose();//dispose the VideoPlayer
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieDetails();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        backgroundColor: themeAppBarColors(),

        title:sText("${properCase(widget.title)}",color: themeAppColors(),weight: FontWeight.w700,family: "ProximaBold"),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(onPressed: (){
          print("secondsWatched:$secondsWatched");
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
        actions: [
          Container(
            margin: rightPadding(5),
            child: Icon(Icons.search,color: themeAppColors(),),
          ),
          responseScreenUser.isNotEmpty ?
          Row(
            children: [
              Container(
                margin: rightPadding(10),
                child: Icon(Icons.notifications_outlined,color: themeAppColors(),),
              ),
              Container(
                margin: rightPadding(20),
                child: displayImage("${responseScreenUser[0].profileImage}",width: 30,height: 30),
              )
            ],
          ) :
          Container(
            margin: rightPadding(10),
            child: Icon(Icons.person,color: themeAppColors(),),
          ),
        ],
      ),
      body: Container(
        width: appWidth(context),
        child: Column(
          children: [
            movie_details.isNotEmpty ?
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoBox(
                        customLoadingWidget: Container(),
                        controller: vcs!,
                        background: Container(
                            width: appWidth(context),
                            child: Image.network("${movie_details[0].videoInfo!.posterImage}",fit: BoxFit.fitWidth,)),
                        // cover: sText("${VideoController(source: VideoPlayerController.network(url),autoplay: true,initPosition: Duration(minutes: 9)).positionText}"),
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                    child: sText("${properCase(movie_details[0].videoInfo!.title!)}",weight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                    child: sText2("${properCase(movie_details[0].videoInfo!.videoCategoryName!)} . ${properCase(movie_details[0].videoInfo!.genreName!)}",weight: FontWeight.w600,color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        if(isMore){
                          isMore = false;
                        }else{
                          isMore = true;
                        }

                      });
                    },
                    child: Container(
                      width: appWidth(context),
                      padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                      child:   Text.rich(
                         TextSpan(
                              text: '${properCase(isMore ? movie_details[0].videoInfo!.description!.substring(1,50) : movie_details[0].videoInfo!.description!)} ',
                              children: <InlineSpan>[
                                if(movie_details[0].videoInfo!.description!.length > 30)
                                TextSpan(
                                  text: isMore ? 'Read more' : 'Read less',
                                  style: appStyle(col: dPurple),

                                )
                              ]
                          ),
                        maxLines: isMore ? 4 : 10,


                      ),
                    ),
                  ),

                  Container(
                    padding: leftPadding(10),
                    child: Row(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                setState(() {
                                  if(movie_details[0].videoInfo!.isLike! == 1){
                                    final m_details = movie_details[0];
                                    m_details.videoInfo!.likeCount = movie_details[0].videoInfo!.likeCount! - 1;
                                    m_details.videoInfo!.isLike = 0;
                                    movie_details[0] = m_details;
                                  }else{
                                    final m_details = movie_details[0];
                                    m_details.videoInfo!.likeCount = movie_details[0].videoInfo!.likeCount! + 1;
                                    m_details.videoInfo!.isLike = 1;
                                    m_details.videoInfo!.isDislike = 0;
                                    m_details.videoInfo!.dislikeCount = movie_details[0].videoInfo!.dislikeCount! != 0 ? movie_details[0].videoInfo!.dislikeCount! - 1 : 0;
                                    movie_details[0] = m_details;
                                  }

                                });
                              }, icon: Icon(Icons.thumb_up,color: movie_details[0].videoInfo!.isLike! == 1 ? dPurple : Colors.grey,)),
                              sText2("${movie_details[0].videoInfo!.likeCount}",color: Colors.white,weight: FontWeight.bold)
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                setState(() {
                                  if(movie_details[0].videoInfo!.isDislike! == 1){
                                    final m_details = movie_details[0];
                                    m_details.videoInfo!.isDislike = 0;
                                    m_details.videoInfo!.dislikeCount = movie_details[0].videoInfo!.dislikeCount! - 1;
                                    movie_details[0] = m_details;
                                  }else{
                                    final m_details = movie_details[0];
                                    m_details.videoInfo!.likeCount = movie_details[0].videoInfo!.likeCount! != 0 ? movie_details[0].videoInfo!.likeCount! - 1 : 0;
                                    m_details.videoInfo!.isLike = 0;
                                    m_details.videoInfo!.isDislike = 1;
                                    m_details.videoInfo!.dislikeCount = movie_details[0].videoInfo!.dislikeCount! + 1;
                                    movie_details[0] = m_details;
                                  }

                                });
                              }, icon: Icon(Icons.thumb_down,color: movie_details[0].videoInfo!.isDislike! == 1 ? dPurple : Colors.grey,)),
                              sText2("${movie_details[0].videoInfo!.dislikeCount}",color: Colors.white,weight: FontWeight.bold)
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        movie_details[0].videoInfo!.price! == 0 ?
                        Container(
                          padding: EdgeInsets.only(left: 5,right: 10,top: 5,bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.play_arrow,color: Colors.white,),
                              sText2("Play movie",color: Colors.white,weight: FontWeight.bold)
                            ],
                          ),
                        ) :
                            Container(
                              child: sText("RENT \$${movie_details[0].videoInfo!.price}"),
                              padding: appPadding(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: dPurple),
                                borderRadius: BorderRadius.circular(5)
                              ),
                            )
                        ,
                      ],
                    ),
                  ),

                  Container(
                    padding: leftPadding(20),
                    child: Row(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              sText2("Release Date",color: Colors.grey,weight: FontWeight.bold),
                              SizedBox(width: 10,),
                              sText("${DateFormat.MMMEd().format(movie_details[0].videoInfo!.publishedOn!)}",color: Colors.white,weight: FontWeight.bold)
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          child: Row(
                            children: [
                              sText2("Views",color: Colors.grey,weight: FontWeight.bold),
                              SizedBox(width: 5,),
                              sText("${movie_details[0].videoInfo!.viewCount}",color: Colors.white,weight: FontWeight.bold)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: leftPadding(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sText("Starring",color: Colors.white,weight: FontWeight.bold),
                        SizedBox(height: 5,),
                        sText2("${movie_details[0].videoInfo!.presenter}",color: Colors.grey,weight: FontWeight.bold),

                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                      child: Divider(color: Colors.grey[200],),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        movie_details[0].videoInfo!.isFavourite! == 1 ?
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              final m_details = movie_details[0];
                              m_details.videoInfo!.isFavourite = 0;
                              movie_details[0] = m_details;
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(Icons.favorite,color: dPurple,),
                                sText2("Favourite",color: Colors.grey)
                              ],
                            ),
                          ),
                        ) :
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              final m_details = movie_details[0];
                              m_details.videoInfo!.isFavourite = 1;
                              movie_details[0] = m_details;
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(Icons.favorite,color: Colors.grey,),
                                sText2("Favourite",color: Colors.grey)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _onShareData(context);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(Icons.share,color: Colors.grey,),
                                sText2("Share",color: Colors.grey)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            goTo(context, ListPlaylist(responseScreens: responseScreenUser[0],));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(Icons.playlist_add,color: Colors.grey,),
                                sText2("Playlist",color: Colors.grey)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.download,color: Colors.grey,),
                              sText2("Download",color: Colors.grey)
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.comment,color: Colors.grey,),
                              sText2("Comment",color: Colors.grey)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Divider(color: Colors.grey[200],),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    margin: leftPadding(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: leftPadding(10),
                          child: sText("Related Videos",weight: FontWeight.bold),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 150,
                          margin: leftPadding(5),
                          child: ListView.builder(
                              itemCount: movie_details[0].related!.data!.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index){
                                return  GestureDetector(
                                  onTap: (){
                                    goTo(context, MoviePage(slug: movie_details[0].related!.data![index].slug!,title: movie_details[0].related!.data![index].title!,));

                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5,),
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: Container(
                                              height: 150,
                                              child: displayImage("${movie_details[0].related!.data![index].thumbnailImage}",width: 100,radius: 0),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                                padding: EdgeInsets.only(left: 5,top: 3,bottom: 5,right: 0),
                                                decoration: BoxDecoration(
                                                    color: Colors.black26,
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
                                                ),
                                                child: popUpMenu(movieId: movie_details[0].related!.data![index].slug!,context: context)
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ) : Expanded(child: Center(child: progress(),))
          ],
        ),
      ),
    );
  }
}

