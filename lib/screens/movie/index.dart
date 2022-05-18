import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/pages/list_playlist.dart';
import 'package:homi/services/get_homepage_banner.dart';
import 'package:homi/services/get_movie_details.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
  List<Responses> movie_details = [];
  List<CommentsDatum> listComments = [];
  List<PurpleDatum> listReplyComments = [];
  int secondsWatched = 0;
  bool isMore = false;
  bool isPlay = false;
  bool isTrailer = true;
  bool progressCode = false;
  bool loading = false;
  double progres = 0;
  bool isComment = false;
  bool isReplies = false;
  int commentIndex = 0;
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

  VideoController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  int? _playBackTime;

  //The values that are passed when changing quality
  Duration? newCurrentPosition;

  getMovieDetails()async{
    // try{
    var js = await doPost('medias/api/v2/videos/${widget.slug}',{"screen":responseScreenUser.isNotEmpty ? responseScreenUser[0].id : ""});
    print("res timeline: $js");
    if(js["status"] == 'success'){
      Responses responseScreens = Responses.fromJson(js["response"]);
      movie_details.add(responseScreens);
     await  initialPlayer(movie_details[0].videoInfo!.trailerHlsUrl != null ? movie_details[0].videoInfo!.trailerHlsUrl! : "");
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
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          await _requestPermission(Permission.accessMediaLocation);
          await _requestPermission(Permission.manageExternalStorage);
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/RPSApp";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        bool res =  await _requestPermission(Permission.storage);
        if (res) {
          directory = await getApplicationDocumentsDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + "/${fileName}");
        print("path:${saveFile.path}");
        await Dio().download(url, saveFile.path,

            onReceiveProgress: (value1, value2) {
          if(mounted)
              setState(() {
                progres = value1 / value2;
              });
            });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
          // String path =
          //     'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4';
          // GallerySaver.saveVideo(saveFile.path).then((bool? success) {
          //   setState(() {
          //     print('Video is saved');
          //   });
          // });
        }
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
  downloadFile() async {
    setState(() {
      loading = true;
      progres = 0;
    });
    // saveVideo will download and save file to Device and will return a boolean
    // for if the file is successfully or not
    bool downloaded = await saveVideo(
        "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
        "${widget.slug}.mp4");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }

    if(mounted)
    setState(() {
      loading = false;
    });
  }

  loadCommentReplies(){
    if(isReplies){
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black38,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: leftPadding(20),
                    child: sText("${movie_details[0].comments!.data![commentIndex].replyComment!.data!.length} REPLIES(S)",size: 16,weight: FontWeight.bold),
                  ),
                  Container(
                    child: IconButton(onPressed: (){
                      setState(() {
                        isReplies = false;
                      });
                    }, icon: Icon(Icons.clear)),
                  ),
                ],
              ),
            ),
            progressCode ? LinearProgressIndicator(color: dPurple,) : Container(),

            SizedBox(height: 10,),


            Expanded(
              child:  ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 2,
                  // physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int i){
                   if(i == 0){
                    return GestureDetector(
                       onTap: (){

                       },
                       child:   Stack(
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                 margin: EdgeInsets.only(top:0,left: 70),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Container(
                                       child: sText("${movie_details[0].comments!.data![commentIndex].customer!.name}",weight: FontWeight.bold),
                                     ),
                                     SizedBox(height: 5,),
                                     Container(
                                       child: sText("${movie_details[0].comments!.data![commentIndex].comment}",weight: FontWeight.normal,size: 12),
                                     ),

                                   ],
                                 ),
                               ),
                               SizedBox(height: 5,),
                               Divider(color: Colors.grey[400],),
                             ],
                           ),

                           Positioned(
                             left: 20,
                             top:0,
                             child: displayImage("${movie_details[0].comments!.data![commentIndex].customer!.profilePicture}",radius:20),
                           ),
                           Positioned(
                             right: 20,
                             top:0,
                             child: sText2("${movie_details[0].comments!.data![commentIndex].createdAt}",color: Colors.grey[400]!,size: 12,weight: FontWeight.bold),
                           ),
                         ],
                       ),
                     );
                   }else if(i == 1){
                     return  Column(
                         children: [
                           for(int index = 0; index < movie_details[0].comments!.data![commentIndex].replyComment!.data!.length; index++)
                           GestureDetector(
                           onTap: (){

                           },
                           child:   Stack(
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     margin: EdgeInsets.only(top:0,left: 100),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Container(
                                           child: sText("${movie_details[0].comments!.data![commentIndex].replyComment!.data![index].customer!.name}",weight: FontWeight.bold),
                                         ),
                                         SizedBox(height: 5,),
                                         Container(
                                           child: sText("${movie_details[0].comments!.data![commentIndex].replyComment!.data![index].comment}",weight: FontWeight.normal,size: 12),
                                         ),

                                       ],
                                     ),
                                   ),
                                   SizedBox(height: 5,),
                                   Divider(color: Colors.grey[400],),
                                 ],
                               ),

                               Positioned(
                                 left: 50,
                                 top:0,
                                 child: displayImage("${movie_details[0].comments!.data![commentIndex].replyComment!.data![index].customer!.profilePicture}",radius:20),
                               ),
                               Positioned(
                                 right: 20,
                                 top:0,
                                 child: sText2("${movie_details[0].comments!.data![commentIndex].replyComment!.data![index].createdAt}",color: Colors.grey[400]!,size: 12,weight: FontWeight.bold),
                               ),
                             ],
                           ),
                     ),
                         ],
                       );
                   }else{
                     return Container();
                   }
                  }),

            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              margin: bottomPadding(20),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    margin: leftPadding(10),
                    child: displayImage("",radius:30,width: 30,height: 30),
                  ),
                  Form(
                    key: _formKey,
                    child: Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: Theme(
                            data: Theme.of(context).copyWith(primaryColor: Colors.red),
                            child: TextFormField(
                              controller: replyCommentController,
                              autofocus: false,
                              style: appStyle(),
                              onFieldSubmitted: (String value){
                                print(value);
                                FocusScope.of(context).unfocus();

                              },
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration.collapsed(hintText: "Write a reply comment... ",hintStyle: appStyle()),
                            ),
                          ),
                        )
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.send,color: dPurple,),
                      iconSize: 25,
                      color: Colors.red,
                      onPressed: () async{
                        FocusScope.of(context).unfocus();
                        setState(() {
                          progressCode = true;
                        });
                        await replyComment();
                      }
                  )
                ],
              ),
            )
          ],
        ),
      );
    }else{
      return Expanded(
        child: Column(
          children: [
            Container(
              color: Colors.black38,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: leftPadding(20),
                    child: sText("${movie_details[0].comments!.data!.length
                    } COMMENT(S)",size: 16,weight: FontWeight.bold),
                  ),
                  Container(
                    child: IconButton(onPressed: (){
                      setState(() {
                        isComment = false;
                      });
                    }, icon: Icon(Icons.clear)),
                  ),
                ],
              ),
            ),
            progressCode ? LinearProgressIndicator(color: dPurple,) : Container(),

            Expanded(
              child:  ListView.builder(
                  itemCount: movie_details[0].comments!.data!.length,
                  // physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isReplies = true;
                          commentIndex = index;
                          print("commentIndex:$commentIndex");
                        });
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                            Container(
                              margin: EdgeInsets.only(top:5,left: 70),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: sText("${movie_details[0].comments!.data![index].customer!.name}",weight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    child: sText("${movie_details[0].comments!.data![index].comment}",weight: FontWeight.normal,size: 12),
                                  ),
                                  SizedBox(height: 5,),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isReplies = true;
                                        commentIndex = index;
                                        print("commentIndex:$commentIndex");
                                      });
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          movie_details[0].comments!.data![index].replyComment!.data!.isNotEmpty ?
                                          Container(
                                            margin: rightPadding(10),
                                            child: sText2("View ${movie_details[0].comments!.data![index].replyComment!.data!.length} Reply",color: dPurple,size: 14,weight: FontWeight.bold),
                                          ) : Container(),

                                          Container(
                                            child: sText2("Reply",color: dPurple,size: 14,weight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                              Positioned(
                                left: 20,
                                top:5,
                                child: displayImage("${movie_details[0].comments!.data![index].customer!.profilePicture}",radius:20),
                              ),
                              Positioned(
                                right: 20,
                                top:5,
                                child: sText2("${movie_details[0].comments!.data![index].createdAt!}",color: Colors.grey[400]!,size: 12,weight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey[400],)
                        ],
                      ),
                    );
                  }),

            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              margin: bottomPadding(20),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    margin: leftPadding(10),
                    child: displayImage("",radius:30,width: 30,height: 30),
                  ),
                  Form(
                    key: _formKey,
                    child: Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: Theme(
                            data: Theme.of(context).copyWith(primaryColor: Colors.red),
                            child: TextFormField(
                              controller: commentVideoController,
                              autofocus: false,
                              style: appStyle(),
                              onFieldSubmitted: (String value)async{
                                print(value);
                                FocusScope.of(context).unfocus();
                                await commentMovie();
                              },
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration.collapsed(hintText: "Add a comment... ",hintStyle: appStyle()),
                            ),
                          ),
                        )
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.send,color: dPurple,),
                      iconSize: 25,
                      color: Colors.red,
                      onPressed: () async{
                        FocusScope.of(context).unfocus();
                        setState(() {
                          progressCode = true;
                        });
                        await commentMovie();
                      }
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

  }

  commentMovie()async{
    // try{
    var js = await doPost('useractions/api/v2/videoComments',{"video_id":widget.slug,"comment" : commentVideoController.text,"parent_id":""});
    print("res comment: $js");
    if(js["status"] == 'success'){
      CommentsDatum commentResponse = CommentsDatum.fromJson(js["response"]["data"][0]);
      listComments.add(commentResponse);
      movie_details[0].comments!.data!.insertAll(0,listComments);
    }else{
      toast(js["message"]);
    }

    setState(() {
      progressCode = false;
    });

    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }

  }

  replyComment()async{
    // try{
    var js = await doPost('useractions/api/v2/videoComments',{"video_id":widget.slug,"comment" : replyCommentController.text,"parent_id":"${movie_details[0].comments!.data![commentIndex].id}"});
    print("res comment: $js");
    if(js["status"] == 'success'){
      PurpleDatum commentResponse = PurpleDatum.fromJson(js["response"]["data"][commentIndex]["reply_comment"]["data"][0]);
      listReplyComments.add(commentResponse);
      movie_details[0].comments!.data![commentIndex].replyComment!.data!.insertAll(0,listReplyComments);
    }else{
      toast(js["message"]);
    }

    setState(() {
      progressCode = false;
    });

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
        secondsWatched = _controller!.value.position.inSeconds;
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
        secondsWatched = _controller!.value.position.inSeconds;
      });
    setState(() {

    });
    _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
      _controller!.seekTo(newCurrentPosition!);
      _controller!.play();
    });
  }

  void _getValuesAndPlay(String videoPath) {

    if(!isTrailer){
      newCurrentPosition = _controller!.value.position;
    }
    _startPlay(videoPath);
    print(newCurrentPosition.toString());
  }

  Future<void> _startPlay(String videoPath) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
      isPlay = true;
      isTrailer = false;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoPath);
      });
    });
  }

  @override
  void dispose() {
    _initializeVideoPlayerFuture = null;
    _controller?.pause().then((_) {
      _controller!.dispose();
    });
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
   return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: themeAppBarColors(),
          body: Container(
            width: appWidth(context),
            child: movie_details.isNotEmpty ?
            Stack(
              children: [
                Column(
                  children: [
                snapshot.connectionState == ConnectionState.done ?
                    Stack(
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
                                      "${movie_details[0].videoInfo!.posterImage}",
                                      fit: BoxFit.fitWidth,)),
                                // cover: sText("${VideoController(source: VideoPlayerController.network(url),autoplay: true,initPosition: Duration(minutes: 9)).positionText}"),
                              )
                          ),
                        ),
                        Positioned(
                          top: 20,
                          child: IconButton(
                              onPressed: () {
                                print("secondsWatched:$secondsWatched");
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)),
                        )
                      ],
                    ) :
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
                              "${movie_details[0].videoInfo!.posterImage}",
                              fit: BoxFit.fitWidth,)),
                        // cover: sText("${VideoController(source: VideoPlayerController.network(url),autoplay: true,initPosition: Duration(minutes: 9)).positionText}"),
                      )
                  ),
                ),
                    !isComment ?
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: sText("${properCase(
                                    movie_details[0].videoInfo!.title!)}",
                                    weight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: sText2("${properCase(
                                    movie_details[0].videoInfo!
                                        .videoCategoryName!)} . ${properCase(
                                    movie_details[0].videoInfo!.genreName!)}",
                                    weight: FontWeight.w600, color: Colors.grey),
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
                                                ? movie_details[0].videoInfo!
                                                .description!.substring(1, 10)
                                                : movie_details[0].videoInfo!
                                                .description!)} ',
                                        children: <InlineSpan>[
                                          if(movie_details[0].videoInfo!
                                              .description!.length > 30)
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
                              Container(
                                padding: leftPadding(10),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: () {
                                            setState(() {
                                              if (movie_details[0].videoInfo!
                                                  .isLike! == 1) {
                                                final m_details = movie_details[0];
                                                m_details.videoInfo!.likeCount =
                                                    movie_details[0].videoInfo!
                                                        .likeCount! - 1;
                                                m_details.videoInfo!.isLike = 0;
                                                movie_details[0] = m_details;
                                              } else {
                                                final m_details = movie_details[0];
                                                m_details.videoInfo!.likeCount =
                                                    movie_details[0].videoInfo!
                                                        .likeCount! + 1;
                                                m_details.videoInfo!.isLike = 1;
                                                if (movie_details[0].videoInfo!
                                                    .isDislike! == 1) {
                                                  m_details.videoInfo!
                                                      .dislikeCount =
                                                      movie_details[0].videoInfo!
                                                          .dislikeCount! - 1;
                                                }
                                                m_details.videoInfo!.isDislike = 0;

                                                movie_details[0] = m_details;
                                              }
                                              likeMovie(
                                                  slug: movie_details[0].videoInfo!
                                                      .slug!);
                                            });
                                          },
                                              icon: Icon(Icons.thumb_up,
                                                color: movie_details[0].videoInfo!
                                                    .isLike! == 1 ? dPurple : Colors
                                                    .grey,)),
                                          sText2("${movie_details[0].videoInfo!
                                              .likeCount}", color: Colors.white,
                                              weight: FontWeight.bold)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: () {
                                            setState(() {
                                              if (movie_details[0].videoInfo!
                                                  .isDislike! == 1) {
                                                final m_details = movie_details[0];
                                                m_details.videoInfo!.isDislike = 0;
                                                m_details.videoInfo!.dislikeCount =
                                                    movie_details[0].videoInfo!
                                                        .dislikeCount! - 1;
                                                movie_details[0] = m_details;
                                              } else {
                                                final m_details = movie_details[0];
                                                if (movie_details[0].videoInfo!
                                                    .isLike! == 1) {
                                                  print("hey");
                                                  m_details.videoInfo!.likeCount =
                                                      movie_details[0].videoInfo!
                                                          .likeCount! - 1;
                                                }
                                                m_details.videoInfo!.isLike = 0;
                                                m_details.videoInfo!.isDislike = 1;
                                                m_details.videoInfo!.dislikeCount =
                                                    movie_details[0].videoInfo!
                                                        .dislikeCount! + 1;

                                                movie_details[0] = m_details;
                                              }
                                              disLikeMovie(
                                                  slug: movie_details[0].videoInfo!
                                                      .slug!);
                                            });
                                          },
                                              icon: Icon(Icons.thumb_down,
                                                color: movie_details[0].videoInfo!
                                                    .isDislike! == 1
                                                    ? dPurple
                                                    : Colors.grey,)),
                                          sText2("${movie_details[0].videoInfo!
                                              .dislikeCount}", color: Colors.white,
                                              weight: FontWeight.bold)
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    movie_details[0].videoInfo!.price! == 0 ?
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isPlay = true;
                                        });
                                        _getValuesAndPlay(
                                            movie_details[0].videoInfo!
                                                .hlsPlaylistUrl!);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 5, right: 10, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.play_arrow,
                                              color: Colors.white,),
                                            sText2(
                                                "Play movie", color: Colors.white,
                                                weight: FontWeight.bold),
                                            SizedBox(width: 5,),
                                            snapshot.connectionState == ConnectionState.done ? Container() : isPlay ? progress(size: 10) : Container()
                                          ],
                                        ),
                                      ),
                                    ) :
                                    Container(
                                      child: sText(
                                          "RENT \$${movie_details[0].videoInfo!
                                              .price}"),
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
                                          sText2("Release Date", color: Colors.grey,
                                              weight: FontWeight.bold),
                                          SizedBox(width: 10,),
                                          sText("${DateFormat.MMMEd().format(
                                              movie_details[0].videoInfo!
                                                  .publishedOn!)}",
                                              color: Colors.white,
                                              weight: FontWeight.bold)
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      child: Row(
                                        children: [
                                          sText2("Views", color: Colors.grey,
                                              weight: FontWeight.bold),
                                          SizedBox(width: 5,),
                                          sText("${movie_details[0].videoInfo!
                                              .viewCount}", color: Colors.white,
                                              weight: FontWeight.bold)
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
                                    sText("Starring", color: Colors.white,
                                        weight: FontWeight.bold),
                                    SizedBox(height: 5,),
                                    sText2(
                                        "${movie_details[0].videoInfo!.presenter ==
                                            null ? "" : movie_details[0].videoInfo!
                                            .presenter}", color: Colors.grey,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    movie_details[0].videoInfo!.isFavourite! == 1 ?
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          final m_details = movie_details[0];
                                          m_details.videoInfo!.isFavourite = 0;
                                          movie_details[0] = m_details;
                                        });
                                        removeMovieFromFavourite(
                                            slug: movie_details[0].videoInfo!
                                                .slug!);
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Icon(Icons.favorite, color: dPurple,),
                                            sText2("Favourite", color: Colors.grey)
                                          ],
                                        ),
                                      ),
                                    ) :
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          final m_details = movie_details[0];
                                          m_details.videoInfo!.isFavourite = 1;
                                          movie_details[0] = m_details;
                                        });
                                        addMovieToFavourite(
                                            slug: movie_details[0].videoInfo!
                                                .slug!);
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.favorite, color: Colors.grey,),
                                            sText2("Favourite", color: Colors.grey)
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _onShareData(context);
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Icon(Icons.share, color: Colors.grey,),
                                            sText2("Share", color: Colors.grey)
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        goTo(context, ListPlaylist(
                                          responseScreens: responseScreenUser[0],
                                          slug: movie_details[0].videoInfo!
                                              .slug!,));
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Icon(Icons.playlist_add,
                                              color: Colors.grey,),
                                            sText2("Playlist", color: Colors.grey)
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        downloadFile();
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.download,
                                                  color: Colors.grey,),
                                                loading
                                                    ? progress(size: 5)
                                                    : Container()
                                              ],
                                            ),
                                            sText2("Download", color: Colors.grey)
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isComment = true;
                                        });
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.comment, color: Colors.grey,),
                                            sText2("Comment", color: Colors.grey)
                                          ],
                                        ),
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
                                margin: leftPadding(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: leftPadding(10),
                                      child: sText("Related Videos",
                                          weight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                      height: 150,
                                      margin: leftPadding(5),
                                      child: ListView.builder(
                                          itemCount: movie_details[0].related!.data!
                                              .length,
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                _controller!.pause();
                                                goTo(context, MoviePage(
                                                  slug: movie_details[0].related!
                                                      .data![index].slug!,
                                                  title: movie_details[0].related!
                                                      .data![index].title!,));
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 5,),
                                                  Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .circular(5.0),
                                                        child: Container(
                                                          height: 150,
                                                          child: displayImage(
                                                              "${movie_details[0]
                                                                  .related!
                                                                  .data![index]
                                                                  .thumbnailImage}",
                                                              width: 100,
                                                              radius: 0),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        right: 0,
                                                        child: Container(
                                                            padding: EdgeInsets
                                                                .only(left: 5,
                                                                top: 3,
                                                                bottom: 5,
                                                                right: 0),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black26,
                                                                borderRadius: BorderRadius
                                                                    .only(
                                                                    bottomLeft: Radius
                                                                        .circular(
                                                                        30))
                                                            ),
                                                            child: popUpMenu(
                                                                movieId: movie_details[0]
                                                                    .related!
                                                                    .data![index]
                                                                    .slug!,
                                                                context: context)
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
                          )
                        ],
                      ),
                    )
                        :
                    loadCommentReplies()
                  ],
                ),
                Positioned(
                  top: 20,
                  child: IconButton(
                      onPressed: () {
                        print("secondsWatched:$secondsWatched");
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
    );
    // return Scaffold(
    //   backgroundColor: themeAppBarColors(),
    //   appBar: AppBar(
    //     backgroundColor: themeAppBarColors(),
    //
    //     title:sText("${properCase(widget.title)}",color: themeAppColors(),weight: FontWeight.w700,family: "ProximaBold"),
    //     elevation: 0,
    //     centerTitle: false,
    //     leading: IconButton(onPressed: (){
    //       print("secondsWatched:$secondsWatched");
    //       Navigator.pop(context);
    //     }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
    //     actions: [
    //       Container(
    //         margin: rightPadding(5),
    //         child: Icon(Icons.search,color: themeAppColors(),),
    //       ),
    //       responseScreenUser.isNotEmpty ?
    //       Row(
    //         children: [
    //           Container(
    //             margin: rightPadding(10),
    //             child: Icon(Icons.notifications_outlined,color: themeAppColors(),),
    //           ),
    //           Container(
    //             margin: rightPadding(20),
    //             child: displayImage("${responseScreenUser[0].profileImage}",width: 30,height: 30),
    //           )
    //         ],
    //       ) :
    //       Container(
    //         margin: rightPadding(10),
    //         child: Icon(Icons.person,color: themeAppColors(),),
    //       ),
    //     ],
    //   ),
    //   body: Container(
    //     width: appWidth(context),
    //     child:   movie_details.isNotEmpty ?
    //     Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(top: 12.0),
    //           child: AspectRatio(
    //               aspectRatio: 16 / 9,
    //               child: VideoBox(
    //                 customLoadingWidget: Container(),
    //                 // customLoadingWidget: Center(child: progress()),
    //                 controller: _controller!,
    //                 background: Container(
    //                     width: appWidth(context),
    //                     child: Image.network("${movie_details[0].videoInfo!.posterImage}",fit: BoxFit.fitWidth,)),
    //                 // cover: sText("${VideoController(source: VideoPlayerController.network(url),autoplay: true,initPosition: Duration(minutes: 9)).positionText}"),
    //               )
    //           ),
    //         ),
    //         !isComment ?
    //        Expanded(
    //          child: ListView(
    //              children: [
    //                Column(
    //                  crossAxisAlignment: CrossAxisAlignment.start,
    //                  children: [
    //                    Container(
    //                      padding: EdgeInsets.only(left: 20,right: 20,top: 10),
    //                      child: sText("${properCase(movie_details[0].videoInfo!.title!)}",weight: FontWeight.bold),
    //                    ),
    //                    Container(
    //                      padding: EdgeInsets.only(left: 20,right: 20,top: 10),
    //                      child: sText2("${properCase(movie_details[0].videoInfo!.videoCategoryName!)} . ${properCase(movie_details[0].videoInfo!.genreName!)}",weight: FontWeight.w600,color: Colors.grey),
    //                    ),
    //                    GestureDetector(
    //                      onTap: (){
    //                        setState(() {
    //                          if(isMore){
    //                            isMore = false;
    //                          }else{
    //                            isMore = true;
    //                          }
    //
    //                        });
    //                      },
    //                      child: Container(
    //                        width: appWidth(context),
    //                        padding: EdgeInsets.only(left: 20,right: 20,top: 10),
    //                        child:   Text.rich(
    //                          TextSpan(
    //                              text: '${properCase(isMore ? movie_details[0].videoInfo!.description!.substring(1,10) : movie_details[0].videoInfo!.description!)} ',
    //                              children: <InlineSpan>[
    //                                if(movie_details[0].videoInfo!.description!.length > 30)
    //                                  TextSpan(
    //                                    text: isMore ? 'Read more' : 'Read less',
    //                                    style: appStyle(col: dPurple),
    //
    //                                  )
    //                              ]
    //                          ),
    //                          maxLines: isMore ? 4 : 10,
    //
    //
    //                        ),
    //                      ),
    //                    ),
    //                    Container(
    //                      padding: leftPadding(10),
    //                      child: Row(
    //                        children: [
    //                          Container(
    //                            child: Row(
    //                              children: [
    //                                IconButton(onPressed: (){
    //                                  setState(() {
    //                                    if(movie_details[0].videoInfo!.isLike! == 1){
    //                                      final m_details = movie_details[0];
    //                                      m_details.videoInfo!.likeCount = movie_details[0].videoInfo!.likeCount! - 1;
    //                                      m_details.videoInfo!.isLike = 0;
    //                                      movie_details[0] = m_details;
    //                                    }else{
    //                                      final m_details = movie_details[0];
    //                                      m_details.videoInfo!.likeCount = movie_details[0].videoInfo!.likeCount! + 1;
    //                                      m_details.videoInfo!.isLike = 1;
    //                                      if(movie_details[0].videoInfo!.isDislike! == 1){
    //                                        m_details.videoInfo!.dislikeCount = movie_details[0].videoInfo!.dislikeCount! - 1;
    //                                      }
    //                                      m_details.videoInfo!.isDislike = 0;
    //
    //                                      movie_details[0] = m_details;
    //                                    }
    //                                    likeMovie(slug: movie_details[0].videoInfo!.slug!);
    //
    //
    //                                  });
    //                                }, icon: Icon(Icons.thumb_up,color: movie_details[0].videoInfo!.isLike! == 1 ? dPurple : Colors.grey,)),
    //                                sText2("${movie_details[0].videoInfo!.likeCount}",color: Colors.white,weight: FontWeight.bold)
    //                              ],
    //                            ),
    //                          ),
    //                          Container(
    //                            child: Row(
    //                              children: [
    //                                IconButton(onPressed: (){
    //                                  setState(() {
    //                                    if(movie_details[0].videoInfo!.isDislike! == 1){
    //                                      final m_details = movie_details[0];
    //                                      m_details.videoInfo!.isDislike = 0;
    //                                      m_details.videoInfo!.dislikeCount = movie_details[0].videoInfo!.dislikeCount! - 1;
    //                                      movie_details[0] = m_details;
    //                                    }else{
    //                                      final m_details = movie_details[0];
    //                                      if(movie_details[0].videoInfo!.isLike! == 1){
    //                                        print("hey");
    //                                        m_details.videoInfo!.likeCount = movie_details[0].videoInfo!.likeCount! - 1;
    //                                      }
    //                                      m_details.videoInfo!.isLike = 0;
    //                                      m_details.videoInfo!.isDislike = 1;
    //                                      m_details.videoInfo!.dislikeCount = movie_details[0].videoInfo!.dislikeCount! + 1;
    //
    //                                      movie_details[0] = m_details;
    //                                    }
    //                                    disLikeMovie(slug: movie_details[0].videoInfo!.slug!);
    //
    //                                  });
    //                                }, icon: Icon(Icons.thumb_down,color: movie_details[0].videoInfo!.isDislike! == 1 ? dPurple : Colors.grey,)),
    //                                sText2("${movie_details[0].videoInfo!.dislikeCount}",color: Colors.white,weight: FontWeight.bold)
    //                              ],
    //                            ),
    //                          ),
    //                          SizedBox(width: 10,),
    //                          movie_details[0].videoInfo!.price! == 0 ?
    //                          GestureDetector(
    //                            onTap: ()async{
    //                              _getValuesAndPlay(movie_details[0].videoInfo!.hlsPlaylistUrl!);
    //                            },
    //                            child: Container(
    //                              padding: EdgeInsets.only(left: 5,right: 10,top: 5,bottom: 5),
    //                              decoration: BoxDecoration(
    //                                  color: Colors.grey,
    //                                  borderRadius: BorderRadius.circular(5)
    //                              ),
    //                              child: Row(
    //                                children: [
    //                                  Icon(Icons.play_arrow,color: Colors.white,),
    //                                  sText2("Play movie",color: Colors.white,weight: FontWeight.bold)
    //                                ],
    //                              ),
    //                            ),
    //                          ) :
    //                          Container(
    //                            child: sText("RENT \$${movie_details[0].videoInfo!.price}"),
    //                            padding: appPadding(5),
    //                            decoration: BoxDecoration(
    //                                border: Border.all(color: dPurple),
    //                                borderRadius: BorderRadius.circular(5)
    //                            ),
    //                          )
    //                          ,
    //                        ],
    //                      ),
    //                    ),
    //                    Container(
    //                      padding: leftPadding(20),
    //                      child: Row(
    //                        children: [
    //                          Container(
    //                            child: Row(
    //                              children: [
    //                                sText2("Release Date",color: Colors.grey,weight: FontWeight.bold),
    //                                SizedBox(width: 10,),
    //                                sText("${DateFormat.MMMEd().format(movie_details[0].videoInfo!.publishedOn!)}",color: Colors.white,weight: FontWeight.bold)
    //                              ],
    //                            ),
    //                          ),
    //                          SizedBox(width: 20,),
    //                          Container(
    //                            child: Row(
    //                              children: [
    //                                sText2("Views",color: Colors.grey,weight: FontWeight.bold),
    //                                SizedBox(width: 5,),
    //                                sText("${movie_details[0].videoInfo!.viewCount}",color: Colors.white,weight: FontWeight.bold)
    //                              ],
    //                            ),
    //                          ),
    //                        ],
    //                      ),
    //                    ),
    //                    SizedBox(height: 10,),
    //                    Container(
    //                      padding: leftPadding(20),
    //                      child: Column(
    //                        crossAxisAlignment: CrossAxisAlignment.start,
    //                        children: [
    //                          sText("Starring",color: Colors.white,weight: FontWeight.bold),
    //                          SizedBox(height: 5,),
    //                          sText2("${movie_details[0].videoInfo!.presenter == null ? "" : movie_details[0].videoInfo!.presenter}",color: Colors.grey,weight: FontWeight.bold),
    //
    //                        ],
    //                      ),
    //                    ),
    //                    Container(
    //                      padding: EdgeInsets.only(left: 20,right: 20),
    //                      child: Divider(color: Colors.grey[200],),
    //                    ),
    //                    Container(
    //                      padding: EdgeInsets.only(left: 20,right: 20),
    //                      child: Row(
    //                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                        children: [
    //                          movie_details[0].videoInfo!.isFavourite! == 1 ?
    //                          GestureDetector(
    //                            onTap: (){
    //                              setState(() {
    //                                final m_details = movie_details[0];
    //                                m_details.videoInfo!.isFavourite = 0;
    //                                movie_details[0] = m_details;
    //
    //                              });
    //                              removeMovieFromFavourite(slug: movie_details[0].videoInfo!.slug!);
    //                            },
    //                            child: Container(
    //                              child: Column(
    //                                children: [
    //                                  Icon(Icons.favorite,color: dPurple,),
    //                                  sText2("Favourite",color: Colors.grey)
    //                                ],
    //                              ),
    //                            ),
    //                          ) :
    //                          GestureDetector(
    //                            onTap: (){
    //                              setState(() {
    //                                final m_details = movie_details[0];
    //                                m_details.videoInfo!.isFavourite = 1;
    //                                movie_details[0] = m_details;
    //                              });
    //                              addMovieToFavourite(slug: movie_details[0].videoInfo!.slug!);
    //                            },
    //                            child: Container(
    //                              child: Column(
    //                                children: [
    //                                  Icon(Icons.favorite,color: Colors.grey,),
    //                                  sText2("Favourite",color: Colors.grey)
    //                                ],
    //                              ),
    //                            ),
    //                          ),
    //                          GestureDetector(
    //                            onTap: (){
    //                              _onShareData(context);
    //                            },
    //                            child: Container(
    //                              child: Column(
    //                                children: [
    //                                  Icon(Icons.share,color: Colors.grey,),
    //                                  sText2("Share",color: Colors.grey)
    //                                ],
    //                              ),
    //                            ),
    //                          ),
    //                          GestureDetector(
    //                            onTap: (){
    //                              goTo(context, ListPlaylist(responseScreens: responseScreenUser[0],slug: movie_details[0].videoInfo!.slug!,));
    //                            },
    //                            child: Container(
    //                              child: Column(
    //                                children: [
    //                                  Icon(Icons.playlist_add,color: Colors.grey,),
    //                                  sText2("Playlist",color: Colors.grey)
    //                                ],
    //                              ),
    //                            ),
    //                          ),
    //                          GestureDetector(
    //                            onTap: (){
    //                              downloadFile();
    //                            },
    //                            child: Container(
    //                              child: Column(
    //                                children: [
    //                                  Row(
    //                                    children: [
    //                                      Icon(Icons.download,color: Colors.grey,),
    //                                      loading ? progress(size: 5) : Container()
    //                                    ],
    //                                  ),
    //                                  sText2("Download",color: Colors.grey)
    //                                ],
    //                              ),
    //                            ),
    //                          ),
    //                          GestureDetector(
    //                            onTap: (){
    //                              setState(() {
    //                                isComment = true;
    //                              });
    //                            },
    //                            child: Container(
    //                              child: Column(
    //                                children: [
    //                                  Icon(Icons.comment,color: Colors.grey,),
    //                                  sText2("Comment",color: Colors.grey)
    //                                ],
    //                              ),
    //                            ),
    //                          ),
    //                        ],
    //                      ),
    //                    ),
    //
    //                    Container(
    //                      padding: EdgeInsets.only(left: 20,right: 20),
    //                      child: Divider(color: Colors.grey[200],),
    //                    ),
    //                    SizedBox(height: 5,),
    //                    Container(
    //                      margin: leftPadding(10),
    //                      child: Column(
    //                        crossAxisAlignment: CrossAxisAlignment.start,
    //                        children: [
    //                          Container(
    //                            margin: leftPadding(10),
    //                            child: sText("Related Videos",weight: FontWeight.bold),
    //                          ),
    //                          SizedBox(height: 15,),
    //                          Container(
    //                            height: 150,
    //                            margin: leftPadding(5),
    //                            child: ListView.builder(
    //                                itemCount: movie_details[0].related!.data!.length,
    //                                shrinkWrap: true,
    //                                physics: ClampingScrollPhysics(),
    //                                scrollDirection: Axis.horizontal,
    //                                itemBuilder: (BuildContext context, int index){
    //                                  return  GestureDetector(
    //                                    onTap: (){
    //                                      vcs!.pause();
    //                                      goTo(context, MoviePage(slug: movie_details[0].related!.data![index].slug!,title: movie_details[0].related!.data![index].title!,));
    //
    //                                    },
    //                                    child: Row(
    //                                      children: [
    //                                        SizedBox(width: 5,),
    //                                        Stack(
    //                                          children: [
    //                                            ClipRRect(
    //                                              borderRadius: BorderRadius.circular(5.0),
    //                                              child: Container(
    //                                                height: 150,
    //                                                child: displayImage("${movie_details[0].related!.data![index].thumbnailImage}",width: 100,radius: 0),
    //                                              ),
    //                                            ),
    //                                            Positioned(
    //                                              right: 0,
    //                                              child: Container(
    //                                                  padding: EdgeInsets.only(left: 5,top: 3,bottom: 5,right: 0),
    //                                                  decoration: BoxDecoration(
    //                                                      color: Colors.black26,
    //                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
    //                                                  ),
    //                                                  child: popUpMenu(movieId: movie_details[0].related!.data![index].slug!,context: context)
    //                                              ),
    //                                            )
    //                                          ],
    //                                        ),
    //                                      ],
    //                                    ),
    //                                  );
    //                                }),
    //                          ),
    //                        ],
    //                      ),
    //                    )
    //                  ],
    //                )
    //              ],
    //          ),
    //        )
    //             :
    //         loadCommentReplies()
    //       ],
    //     ) :  Column(
    //       children: [
    //         Expanded(child: Center(child: progress(),)),
    //       ],
    //     ),
    //   ),
    // );
  }
}


// class VideoPlayerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Player Demo',
//       home: Container(
//           padding: EdgeInsets.all(100),
//           color: Colors.black,
//           child: VideoPlayerScreen()),
//     );
//   }
// }
//
// class VideoPlayerScreen extends StatefulWidget {
//   VideoPlayerScreen({Key key}) : super(key: key);
//
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   VideoPlayerController _controller;
//   Future<void> _initializeVideoPlayerFuture;
//   int _playBackTime;
//
//   //The values that are passed when changing quality
//   Duration newCurrentPosition;
//
//   String defaultStream =
//       'https://archive.org/download/Damas_BB_28F8B535_D_406/DaMaS.mp4';
//   String stream2 = 'https://archive.org/download/cCloud_20151126/cCloud.mp4';
//   String stream3 = 'https://archive.org/download/mblbhs/mblbhs.mp4';
//
//   @override
//   void initState() {
//     _controller = VideoPlayerController.network(defaultStream);
//     _controller.addListener(() {
//       setState(() {
//         _playBackTime = _controller.value.position.inSeconds;
//       });
//     });
//     _initializeVideoPlayerFuture = _controller.initialize();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _initializeVideoPlayerFuture = null;
//     _controller?.pause()?.then((_) {
//       _controller.dispose();
//     });
//     super.dispose();
//   }
//
//   Future<bool> _clearPrevious() async {
//     await _controller?.pause();
//     return true;
//   }
//
//   Future<void> _initializePlay(String videoPath) async {
//     _controller = VideoPlayerController.network(videoPath);
//     _controller.addListener(() {
//       setState(() {
//         _playBackTime = _controller.value.position.inSeconds;
//       });
//     });
//     _initializeVideoPlayerFuture = _controller.initialize().then((_) {
//       _controller.seekTo(newCurrentPosition);
//       _controller.play();
//     });
//   }
//
//   void _getValuesAndPlay(String videoPath) {
//     newCurrentPosition = _controller.value.position;
//     _startPlay(videoPath);
//     print(newCurrentPosition.toString());
//   }
//
//   Future<void> _startPlay(String videoPath) async {
//     setState(() {
//       _initializeVideoPlayerFuture = null;
//     });
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _clearPrevious().then((_) {
//         _initializePlay(videoPath);
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initializeVideoPlayerFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Container(
//             width: appWidth(context),
//             child:   movie_details.isNotEmpty ?
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12.0),
//                   child: AspectRatio(
//                       aspectRatio: 16 / 9,
//                       child: VideoBox(
//                         customLoadingWidget: Container(),
//                         // customLoadingWidget: Center(child: progress()),
//                         controller: _controller!,
//                         background: Container(
//                             width: appWidth(context),
//                             child: Image.network("${movie_details[0].videoInfo!.posterImage}",fit: BoxFit.fitWidth,)),
//                         // cover: sText("${VideoController(source: VideoPlayerController.network(url),autoplay: true,initPosition: Duration(minutes: 9)).positionText}"),
//                       )
//                   ),
//                 ),
//                 !isComment ?
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.only(left: 20,right: 20,top: 10),
//                             child: sText("${properCase(movie_details[0].videoInfo!.title!)}",weight: FontWeight.bold),
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(left: 20,right: 20,top: 10),
//                             child: sText2("${properCase(movie_details[0].videoInfo!.videoCategoryName!)} . ${properCase(movie_details[0].videoInfo!.genreName!)}",weight: FontWeight.w600,color: Colors.grey),
//                           ),
//                           GestureDetector(
//                             onTap: (){
//                               setState(() {
//                                 if(isMore){
//                                   isMore = false;
//                                 }else{
//                                   isMore = true;
//                                 }
//
//                               });
//                             },
//                             child: Container(
//                               width: appWidth(context),
//                               padding: EdgeInsets.only(left: 20,right: 20,top: 10),
//                               child:   Text.rich(
//                                 TextSpan(
//                                     text: '${properCase(isMore ? movie_details[0].videoInfo!.description!.substring(1,10) : movie_details[0].videoInfo!.description!)} ',
//                                     children: <InlineSpan>[
//                                       if(movie_details[0].videoInfo!.description!.length > 30)
//                                         TextSpan(
//                                           text: isMore ? 'Read more' : 'Read less',
//                                           style: appStyle(col: dPurple),
//
//                                         )
//                                     ]
//                                 ),
//                                 maxLines: isMore ? 4 : 10,
//
//
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: leftPadding(10),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       IconButton(onPressed: (){
//                                         setState(() {
//                                           if(movie_details[0].videoInfo!.isLike! == 1){
//                                             final m_details = movie_details[0];
//                                             m_details.videoInfo!.likeCount = movie_details[0].videoInfo!.likeCount! - 1;
//                                             m_details.videoInfo!.isLike = 0;
//                                             movie_details[0] = m_details;
//                                           }else{
//                                             final m_details = movie_details[0];
//                                             m_details.videoInfo!.likeCount = movie_details[0].videoInfo!.likeCount! + 1;
//                                             m_details.videoInfo!.isLike = 1;
//                                             if(movie_details[0].videoInfo!.isDislike! == 1){
//                                               m_details.videoInfo!.dislikeCount = movie_details[0].videoInfo!.dislikeCount! - 1;
//                                             }
//                                             m_details.videoInfo!.isDislike = 0;
//
//                                             movie_details[0] = m_details;
//                                           }
//                                           likeMovie(slug: movie_details[0].videoInfo!.slug!);
//
//
//                                         });
//                                       }, icon: Icon(Icons.thumb_up,color: movie_details[0].videoInfo!.isLike! == 1 ? dPurple : Colors.grey,)),
//                                       sText2("${movie_details[0].videoInfo!.likeCount}",color: Colors.white,weight: FontWeight.bold)
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       IconButton(onPressed: (){
//                                         setState(() {
//                                           if(movie_details[0].videoInfo!.isDislike! == 1){
//                                             final m_details = movie_details[0];
//                                             m_details.videoInfo!.isDislike = 0;
//                                             m_details.videoInfo!.dislikeCount = movie_details[0].videoInfo!.dislikeCount! - 1;
//                                             movie_details[0] = m_details;
//                                           }else{
//                                             final m_details = movie_details[0];
//                                             if(movie_details[0].videoInfo!.isLike! == 1){
//                                               print("hey");
//                                               m_details.videoInfo!.likeCount = movie_details[0].videoInfo!.likeCount! - 1;
//                                             }
//                                             m_details.videoInfo!.isLike = 0;
//                                             m_details.videoInfo!.isDislike = 1;
//                                             m_details.videoInfo!.dislikeCount = movie_details[0].videoInfo!.dislikeCount! + 1;
//
//                                             movie_details[0] = m_details;
//                                           }
//                                           disLikeMovie(slug: movie_details[0].videoInfo!.slug!);
//
//                                         });
//                                       }, icon: Icon(Icons.thumb_down,color: movie_details[0].videoInfo!.isDislike! == 1 ? dPurple : Colors.grey,)),
//                                       sText2("${movie_details[0].videoInfo!.dislikeCount}",color: Colors.white,weight: FontWeight.bold)
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: 10,),
//                                 movie_details[0].videoInfo!.price! == 0 ?
//                                 GestureDetector(
//                                   onTap: ()async{
//                                     _getValuesAndPlay(movie_details[0].videoInfo!.hlsPlaylistUrl!);
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.only(left: 5,right: 10,top: 5,bottom: 5),
//                                     decoration: BoxDecoration(
//                                         color: Colors.grey,
//                                         borderRadius: BorderRadius.circular(5)
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Icon(Icons.play_arrow,color: Colors.white,),
//                                         sText2("Play movie",color: Colors.white,weight: FontWeight.bold)
//                                       ],
//                                     ),
//                                   ),
//                                 ) :
//                                 Container(
//                                   child: sText("RENT \$${movie_details[0].videoInfo!.price}"),
//                                   padding: appPadding(5),
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: dPurple),
//                                       borderRadius: BorderRadius.circular(5)
//                                   ),
//                                 )
//                                 ,
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: leftPadding(20),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       sText2("Release Date",color: Colors.grey,weight: FontWeight.bold),
//                                       SizedBox(width: 10,),
//                                       sText("${DateFormat.MMMEd().format(movie_details[0].videoInfo!.publishedOn!)}",color: Colors.white,weight: FontWeight.bold)
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: 20,),
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       sText2("Views",color: Colors.grey,weight: FontWeight.bold),
//                                       SizedBox(width: 5,),
//                                       sText("${movie_details[0].videoInfo!.viewCount}",color: Colors.white,weight: FontWeight.bold)
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           Container(
//                             padding: leftPadding(20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 sText("Starring",color: Colors.white,weight: FontWeight.bold),
//                                 SizedBox(height: 5,),
//                                 sText2("${movie_details[0].videoInfo!.presenter == null ? "" : movie_details[0].videoInfo!.presenter}",color: Colors.grey,weight: FontWeight.bold),
//
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(left: 20,right: 20),
//                             child: Divider(color: Colors.grey[200],),
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(left: 20,right: 20),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 movie_details[0].videoInfo!.isFavourite! == 1 ?
//                                 GestureDetector(
//                                   onTap: (){
//                                     setState(() {
//                                       final m_details = movie_details[0];
//                                       m_details.videoInfo!.isFavourite = 0;
//                                       movie_details[0] = m_details;
//
//                                     });
//                                     removeMovieFromFavourite(slug: movie_details[0].videoInfo!.slug!);
//                                   },
//                                   child: Container(
//                                     child: Column(
//                                       children: [
//                                         Icon(Icons.favorite,color: dPurple,),
//                                         sText2("Favourite",color: Colors.grey)
//                                       ],
//                                     ),
//                                   ),
//                                 ) :
//                                 GestureDetector(
//                                   onTap: (){
//                                     setState(() {
//                                       final m_details = movie_details[0];
//                                       m_details.videoInfo!.isFavourite = 1;
//                                       movie_details[0] = m_details;
//                                     });
//                                     addMovieToFavourite(slug: movie_details[0].videoInfo!.slug!);
//                                   },
//                                   child: Container(
//                                     child: Column(
//                                       children: [
//                                         Icon(Icons.favorite,color: Colors.grey,),
//                                         sText2("Favourite",color: Colors.grey)
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: (){
//                                     _onShareData(context);
//                                   },
//                                   child: Container(
//                                     child: Column(
//                                       children: [
//                                         Icon(Icons.share,color: Colors.grey,),
//                                         sText2("Share",color: Colors.grey)
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: (){
//                                     goTo(context, ListPlaylist(responseScreens: responseScreenUser[0],slug: movie_details[0].videoInfo!.slug!,));
//                                   },
//                                   child: Container(
//                                     child: Column(
//                                       children: [
//                                         Icon(Icons.playlist_add,color: Colors.grey,),
//                                         sText2("Playlist",color: Colors.grey)
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: (){
//                                     downloadFile();
//                                   },
//                                   child: Container(
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(Icons.download,color: Colors.grey,),
//                                             loading ? progress(size: 5) : Container()
//                                           ],
//                                         ),
//                                         sText2("Download",color: Colors.grey)
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: (){
//                                     setState(() {
//                                       isComment = true;
//                                     });
//                                   },
//                                   child: Container(
//                                     child: Column(
//                                       children: [
//                                         Icon(Icons.comment,color: Colors.grey,),
//                                         sText2("Comment",color: Colors.grey)
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           Container(
//                             padding: EdgeInsets.only(left: 20,right: 20),
//                             child: Divider(color: Colors.grey[200],),
//                           ),
//                           SizedBox(height: 5,),
//                           Container(
//                             margin: leftPadding(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   margin: leftPadding(10),
//                                   child: sText("Related Videos",weight: FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 15,),
//                                 Container(
//                                   height: 150,
//                                   margin: leftPadding(5),
//                                   child: ListView.builder(
//                                       itemCount: movie_details[0].related!.data!.length,
//                                       shrinkWrap: true,
//                                       physics: ClampingScrollPhysics(),
//                                       scrollDirection: Axis.horizontal,
//                                       itemBuilder: (BuildContext context, int index){
//                                         return  GestureDetector(
//                                           onTap: (){
//                                             vcs!.pause();
//                                             goTo(context, MoviePage(slug: movie_details[0].related!.data![index].slug!,title: movie_details[0].related!.data![index].title!,));
//
//                                           },
//                                           child: Row(
//                                             children: [
//                                               SizedBox(width: 5,),
//                                               Stack(
//                                                 children: [
//                                                   ClipRRect(
//                                                     borderRadius: BorderRadius.circular(5.0),
//                                                     child: Container(
//                                                       height: 150,
//                                                       child: displayImage("${movie_details[0].related!.data![index].thumbnailImage}",width: 100,radius: 0),
//                                                     ),
//                                                   ),
//                                                   Positioned(
//                                                     right: 0,
//                                                     child: Container(
//                                                         padding: EdgeInsets.only(left: 5,top: 3,bottom: 5,right: 0),
//                                                         decoration: BoxDecoration(
//                                                             color: Colors.black26,
//                                                             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
//                                                         ),
//                                                         child: popUpMenu(movieId: movie_details[0].related!.data![index].slug!,context: context)
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 )
//                     :
//                 loadCommentReplies()
//               ],
//             ) :  Column(
//               children: [
//                 Expanded(child: Center(child: progress(),)),
//               ],
//             ),
//           );
//         } else {
//           // If the VideoPlayerController is still initializing, show a
//           // loading spinner.
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }


