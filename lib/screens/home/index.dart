import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/helper/video_feed_player.dart';
import 'package:homi/screens/movie/index.dart';
import 'package:video_box/video.controller.dart';
import 'package:video_box/video_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentSlide = 0;
  List<Widget> slides = [];
  List<VideoController> vcs = [];
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



  Widget? videoView(){
    for (var vc in vcs){
      return  Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoBox(
            customLoadingWidget: Container(),
            controller:vc,
            background: Container(
                width: appWidth(context),
                child: Image.network("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",fit: BoxFit.fitWidth,)),
            // cover: sText("${VideoController(source: VideoPlayerController.network(url),autoplay: true,initPosition: Duration(minutes: 9)).positionText}"),
          ),
        ),
      );
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < listBannerData[0].data.length; i++) {
      if(listBannerData[0].data[i].trailerHlsUrl.isNotEmpty){
        vcs.add(VideoController(source: VideoPlayerController.network("${listBannerData[0].data[i].trailerHlsUrl}"),autoplay: true,volume: 0,)
          ..initialize());
      }else{
        vcs.add(VideoController(source: VideoPlayerController.network("${listBannerData[0].data[i].trailerHlsUrl}"),autoplay: true,volume: 0,)
          ..initialize());
      }

    }
  }
  @override
  void dispose() {
    for (var vc in vcs) {
      vc.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        backgroundColor: themeAppBarColors(),

        title: Container(
          child: Image.asset("assets/images/Homi-logo-white.png",width: 100,),
        ),
        elevation: 0,
        centerTitle: false,
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
          Expanded(
            child: ListView(
              children: [
                CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 225,
                      autoPlay: false,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      enlargeCenterPage: true,
                      viewportFraction: 2.7,
                      aspectRatio: 2.0,
                      pageSnapping: true,


                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentSlide = index;
                        });
                      },
                    ),
                    itemCount: vcs.length,
                    itemBuilder: (BuildContext context, int index, int index2) {
                      return Container(
                        width: appWidth(context),
                        padding: const EdgeInsets.only(top: 12.0),
                        child: VideoBox(
                          customLoadingWidget: Container(),
                          controller:vcs[index],

                          background: Container(
                              width: appWidth(context),
                              child: Stack(
                                children: [
                                  displayImage(listBannerData[0].data[index].posterImage,radius: 0,height: 300,width: appWidth(context)),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Container(
                                      child: Icon(Icons.play_arrow,color: Colors.white,),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black26,
                                          border: Border.all(color: Colors.white)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: topPadding(150),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: map<Widget>(vcs.length, (index, url) {
                                          return Container(
                                            width: 25,
                                            height: 3,
                                            margin: EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(color: _currentSlide == index ? Colors.white : dPurple),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    right: 20,
                                    child: Container(
                                      child: Icon(Icons.volume_mute,color: Colors.white,),
                                    )
                                  ),
                                ],
                              )
                          ),
                          // cover: sText("${VideoController(source: VideoPlayerController.network(url),autoplay: true,initPosition: Duration(minutes: 9)).positionText}"),
                        ),
                      );
                    }),

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     SizedBox(height: 10,),
                //     Container(
                //       margin: leftPadding(10),
                //       child: sText("Continue Watching",weight: FontWeight.bold),
                //     ),
                //     SizedBox(height: 10,),
                //     Container(
                //       height: 150,
                //       child: ListView.builder(
                //           itemCount: 10,
                //           shrinkWrap: true,
                //           physics: ClampingScrollPhysics(),
                //           scrollDirection: Axis.horizontal,
                //           itemBuilder: (BuildContext context, int index){
                //             return  GestureDetector(
                //               onTap: (){
                //                 goTo(context, MoviePage(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",));
                //               },
                //               child: Row(
                //                 children: [
                //                   SizedBox(width: 10,),
                //                   Stack(
                //                     children: [
                //                       ClipRRect(
                //                         borderRadius: BorderRadius.circular(5.0),
                //                         child: Container(
                //                           height: 150,
                //                           child: Image.asset("assets/images/pabi at ledge.jpg",width: 200,fit: BoxFit.fitHeight,),
                //                         ),
                //                       ),
                //                       Positioned(
                //                         bottom: 0,
                //                         child: Container(
                //                             width: 200,
                //                             height: 5,
                //                             decoration: BoxDecoration(
                //                                 color: Colors.red,
                //                             ),
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             );
                //           }),
                //     ),
                //   ],
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      margin: leftPadding(10),
                      child: sText("${listNewData[0].categoryName}",weight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: listNewData[0].data.length,
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
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Container(
                                          height: 150,
                                          child: displayImage("${listNewData[0].data[index].thumbnailImage}",width: 100,radius: 0),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                            padding: EdgeInsets.only(left: 5,top: 3,bottom: 5,right: 0),
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
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
                for(int i =0; i < listHomeContent.length; i++)
                  if(listHomeContent[i].data.isNotEmpty)
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        margin: leftPadding(10),
                        child: sText("${listHomeContent[i].categoryName}",weight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: listHomeContent[i].data.length,
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
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Container(
                                          height: 150,
                                          child: displayImage("${listHomeContent[i].data[index].thumbnailImage}",width: 100,radius: 0),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                            padding: EdgeInsets.only(left: 5,top: 3,bottom: 5,right: 0),
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
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

