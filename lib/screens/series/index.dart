import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/pages/list_playlist.dart';
import 'package:homi/screens/login/index.dart';
import 'package:homi/screens/premium/index.dart';
import 'package:homi/screens/series/get_episode.dart';
import 'package:homi/services/get_homepage_banner.dart';
import 'package:homi/services/get_movie_details.dart';
import 'package:homi/services/get_series.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_box/video_box.dart';

class SeriesPage extends StatefulWidget {
  String slug;
  String title;
  SeriesPage({this.slug = '',this.title = ''});

  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  List<Widget> slides = [];
  List<ResponseSeries> movie_details = [];

  bool isMore = false;
  bool isPlay = false;
  bool progressCode = false;
  VideoController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  int? _playBackTime;

  int seasonID = 0;
  int numberEpisodes = 0;
  String seasonName = '';

  final TextEditingController commentVideoController = TextEditingController();
  final TextEditingController replyCommentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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



  checkIfLogin(){
    if(responseScreenUser.isNotEmpty){
      if(responseUserData[0].isSubscribed == 1){
        setState(() {
          isPlay = true;
        });
        return true;
      }else{
        goTo(context, PremiumPage());
      }
    }else{
      showDialogOk(message: "You've to login to access this feature",context: context,target: LoginPage(),replace: false,status: true);
    }

    return false;
  }

  //The values that are passed when changing quality
  Duration? newCurrentPosition;

  getMovieDetails()async{
    // try{
      var js = await doGet('medias/api/v2/webseries/${widget.slug}');
      print("res timeline: $js");
      if(js["status"] == 'success'){
        ResponseSeries responseScreens = ResponseSeries.fromJson(js["response"]);
        movie_details.add(responseScreens);
        await  initialPlayer(movie_details[0].webseriesInfo!.webseriesDetail!.posterImage != null ? movie_details[0].webseriesInfo!.webseriesDetail!.posterImage! : "");

        setState(() {
          if(movie_details[0].seasons!.isNotEmpty){
            seasonID = movie_details[0].seasons![0].id!;
            seasonName = movie_details[0].seasons![0].title!;
          }
          for(int t = 0; t < movie_details[0].related!.data!.length; t++){
            setState(() {
              if(movie_details[0].related!.data![t].seasonId == seasonID){
                numberEpisodes++;
              }

            });
          }

          print("len:${movie_details[0].webseriesInfo!.webseriesDetail!.description!.length}");
          if(movie_details[0].webseriesInfo!.webseriesDetail!.description!.length > 30){
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

  initialPlayer(String url)async{
    _controller =(VideoController(source: VideoPlayerController.network(url),autoplay: true,)
      ..initialize())
      ..addListener(() {
        if(_controller!.value.position.inSeconds == 30){
          print("pSeconds value:${_controller!.value.position.inSeconds}");
        }
      });
    setState(() {

    });
    // _initializeVideoPlayerFuture = _controller!.initialize();
  }

  Future<bool> _clearPrevious() async {
    await _controller?.pause();
    return true;
  }

  Future<void> _initializePlay(String videoPath) async {
    _controller = (VideoController(source: VideoPlayerController.network(videoPath),autoplay: true,))
      ..addListener(() {
        if(_controller!.value.position.inSeconds == 30){
          print("pSeconds value:${_controller!.value.position.inSeconds}");
        }
      });
    setState(() {

    });
    _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
      _controller!.seekTo(newCurrentPosition!);
      _controller!.play();
    });
  }

  void _getValuesAndPlay(String videoPath) {
     newCurrentPosition = _controller!.value.position;
    _startPlay(videoPath);
    print(newCurrentPosition.toString());
  }

  Future<void> _startPlay(String videoPath) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
      isPlay = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoPath);
      });
    });
  }

  popUpSeasonMenu({BuildContext? context}){
    return  PopupMenuButton(onSelected: (result) {
    },
      padding: bottomPadding(0),
      child: Container(
        width: 100,
        margin: EdgeInsets.only(left: 20,top: 10),
        padding: EdgeInsets.only(left: 5,bottom: 0,top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sText("$seasonName",color: dPurple,weight: FontWeight.bold,align: TextAlign.center),
            Icon(Icons.arrow_drop_down_sharp,color: dPurple,)
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: dPurple,width: 2)
        ),
      ),
      // add this line
      itemBuilder: (_) => <PopupMenuItem<String>>[
        for(int i =0; i < movie_details[0].seasons!.length; i++)
        PopupMenuItem<String>(
          child: Container(
            // height: 30,
            child: sText("${movie_details[0].seasons![i].title}",size: 18),
          )
          , value: '${movie_details[0].seasons![i].title}',
          onTap: (){
            setState(() {
              seasonID = movie_details[0].seasons![i].id!;
              seasonName = movie_details[0].seasons![i].title!;
              numberEpisodes = 0;
              for(int t = 0; t < movie_details[0].related!.data!.length; t++){
                setState(() {
                  if(movie_details[0].related!.data![t].seasonId == seasonID){
                    numberEpisodes++;
                  }

                });
              }
            });
          },
        ),

      ],
    );
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

      body: Container(
        width: appWidth(context),
        child: movie_details.isNotEmpty ?
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoBox(
                        customLoadingWidget: Container(),
                        // customLoadingWidget: Center(child: progress()),
                        controller: _controller!,
                        background: Container(
                            width: appWidth(context),
                            child: Image.network(
                              "${movie_details[0].webseriesInfo!.webseriesDetail!.posterImage}",
                              fit: BoxFit.fitWidth,)),
                        // cover: sText("${VideoController(source: VideoPlayerController.network(url),autoplay: true,initPosition: Duration(minutes: 9)).positionText}"),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 10),
                  child: sText("${properCase(
                      movie_details[0].webseriesInfo!.title!)}",
                      weight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 10),
                  child: sText2("${properCase(
                      movie_details[0].webseriesInfo!.webseriesDetail!.genre!.name!)}",
                      weight: FontWeight.w600, color: Colors.grey),
                ),
                Container(
                  child: popUpSeasonMenu(context: context),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isMore) {
                        isMore = false;
                      } else {
                        isMore = true;
                      }
                    });
                  },
                  child: Container(
                    width: appWidth(context),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10),
                    child: Text.rich(
                      TextSpan(
                          text: '${properCase(
                              isMore
                                  ? movie_details[0].webseriesInfo!
                                  .webseriesDetail!.description!.substring(0, 10)
                                  : movie_details[0].webseriesInfo!
                                  .webseriesDetail!.description!)} ',
                          children: <InlineSpan>[
                            if(movie_details[0].webseriesInfo!
                                .webseriesDetail!.description!.length > 30)
                              TextSpan(
                                text: isMore
                                    ? 'Read more'
                                    : 'Read less',
                                style: appStyle(col: dPurple),

                              )
                          ]
                      ),
                      maxLines: isMore ? 4 : 10,


                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  padding: leftPadding(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sText("Starring", color: Colors.white,
                          weight: FontWeight.bold),
                      SizedBox(height: 5,),
                      sText2(
                          "${movie_details[0].webseriesInfo!.webseriesDetail!.starring ==
                              null ? "" : movie_details[0].webseriesInfo!.webseriesDetail!.starring}", color: Colors.grey,
                          weight: FontWeight.bold),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(color: Colors.grey[200],),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _onShareData(context);
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.share, color: Colors.grey,),
                              sText2("Share", color: Colors.grey)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        child: Row(
                          children: [
                            sText2("Release Date", color: Colors.grey,
                                weight: FontWeight.bold),
                            SizedBox(width: 10,),
                            sText("${DateFormat.MMMEd().format(
                                movie_details[0].webseriesInfo!.webseriesDetail!
                                    .createdAt!)}",
                                color: Colors.white,
                                weight: FontWeight.bold)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(color: Colors.grey[200],),
                ),
                SizedBox(height: 5,),
                Container(
                  margin: leftPadding(20),
                  child: sText("Episodes($numberEpisodes)",
                      weight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: movie_details[0].related!.data!.length,
                      itemBuilder: (BuildContext context, int index){
                        if(seasonID == movie_details[0].related!.data![index].seasonId){
                          return   GestureDetector(
                            onTap: () {
                              goTo(context, EpisodePage(slug: movie_details[0].related!.data![index].slug!,title: movie_details[0].related!.data![index].title!,));
                            },
                            child: Container(
                              padding: appPadding(10),
                              margin: EdgeInsets.only(right: 20,left: 20,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: appPadding(10),
                                    child: Icon(Icons.play_arrow,color: dPurple,),
                                    decoration: BoxDecoration(
                                        color: Colors.purple[200],
                                        shape: BoxShape.circle
                                    ),
                                  ),

                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: sText("${movie_details[0].related!.data![index].title}",weight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          width: 200,
                                          child: sText("${movie_details[0].related!.data![index].description}",maxLines: 1,size: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  popUpMenu(
                                      movieId: "",
                                      context: context)
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          );
                        }
                        return Container();
                      }),
                )
              ],
            ),
            Positioned(
              top: 20,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
            )
          ],
        )
            :
        Column(
          children: [
            Expanded(child: Center(child: progress(),)),
          ],
        ),
      ),
    );

  }
}





