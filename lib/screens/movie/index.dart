import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_box/video_box.dart';

class MoviePage extends StatefulWidget {
  String url;
   MoviePage({this.url = ''});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Widget> slides = [];
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


  VideoController? vcs ;


  @override
  void dispose() {
    vcs!.dispose();//dispose the VideoPlayer
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vcs = (VideoController(source: VideoPlayerController.network(widget.url),autoplay: true,)
      ..initialize())
    ..addListener(() {
      // ignore: avoid_print
     //   print("pSeconds value:${vcs!.value.position.inSeconds}");
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        backgroundColor: themeAppBarColors(),

        title:sText("Movie Name",color: themeAppColors(),weight: FontWeight.w700,size: 22,family: "ProximaBold"),
        elevation: 0,
        centerTitle: false,
        actions: [
          Icon(Icons.search,color: themeAppColors(),),
          Container(
            margin: rightPadding(15),
            child: Icon(Icons.person,color: themeAppColors(),),
          )
        ],
      ),
      body: Container(
        width: appWidth(context),
        child: Column(
          children: [
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
                            child: Image.network("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",fit: BoxFit.fitWidth,)),
                        // cover: sText("${VideoController(source: VideoPlayerController.network(url),autoplay: true,initPosition: Duration(minutes: 9)).positionText}"),
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                    child: sText("Vivre Riche",weight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                    child: sText2("2021 Movies . Drama",weight: FontWeight.w600,color: Colors.grey),
                  ),
                  Container(
                    width: appWidth(context),
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                    child: LinkifyText(
                      "Scam business among African youth in abidjan and Lagos. A perceived reversal of the theft by Western nations in West ...Read More...",
                      linkStyle: TextStyle(color: Colors.blue),
                      onTap: (link) {

                      },
                    )
                  ),

                  Container(
                    padding: leftPadding(10),
                    child: Row(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              IconButton(onPressed: (){

                              }, icon: Icon(Icons.thumb_up,color: Colors.grey,)),
                              sText2("6",color: Colors.white,weight: FontWeight.bold)
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(onPressed: (){

                              }, icon: Icon(Icons.thumb_down,color: Colors.grey,)),
                              sText2("6",color: Colors.white,weight: FontWeight.bold)
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          padding: EdgeInsets.only(left: 5,right: 10,top: 5,bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.play_arrow,color: Colors.white,),
                              sText2("Play",color: Colors.white,weight: FontWeight.bold)
                            ],
                          ),
                        ),
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
                              sText("Sep 09, 2021",color: Colors.white,weight: FontWeight.bold)
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          child: Row(
                            children: [
                              sText2("Views",color: Colors.grey,weight: FontWeight.bold),
                              SizedBox(width: 5,),
                              sText("29",color: Colors.white,weight: FontWeight.bold)
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
                        sText2("Katoumba, Richie, Akalou & Mampou",color: Colors.grey,weight: FontWeight.bold),

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
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.favorite,color: Colors.grey,),
                              sText2("Favourite",color: Colors.grey)
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.share,color: Colors.grey,),
                              sText2("Share",color: Colors.grey)
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.playlist_add,color: Colors.grey,),
                              sText2("Playlist",color: Colors.grey)
                            ],
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
                          child: sText("Related Videos Name",weight: FontWeight.bold),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 150,
                          child: ListView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index){
                                return  GestureDetector(
                                  onTap: (){
                                    goTo(context, MoviePage(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",));
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10,),
                                      Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            child: Image.asset("assets/images/pabi at ledge.jpg",width: 100,fit: BoxFit.fitHeight,),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                                padding: EdgeInsets.only(left: 5,top: 3,bottom: 5,right: 0),
                                                decoration: BoxDecoration(
                                                    color: Colors.black26,
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
                                                ),
                                                child: Icon(Icons.more_vert,color: dPurple,)
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
            )
          ],
        ),
      ),
    );
  }
}

