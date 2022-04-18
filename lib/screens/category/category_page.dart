import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/screens/movie/index.dart';
import 'package:homi/services/get_categories.dart';
import 'package:homi/services/get_categories_videos.dart';
import 'package:homi/services/get_homepage_banner.dart';

class CategoryTypePage extends StatefulWidget {
  DataCategories? dataCategories;
   CategoryTypePage({this.dataCategories}) ;

  @override
  _CategoryTypePageState createState() => _CategoryTypePageState();
}

class _CategoryTypePageState extends State<CategoryTypePage> {
  int total = 0;
  bool progressCode = true;
  getHomePageContent()async{
    // try{
    var js = await doGet('medias/api/v2/home_category_videos?is_web_series=0&category=${widget.dataCategories!.slug}');
    print("res timeline: $js");
    if(js["status"] == 'success'){
      for(int i = 0; i < js["response"]["main"].length; i++){
        Main responseScreens = Main.fromJson(js["response"]["main"][i]);
        listCategoryVideos.add(responseScreens);
        total += responseScreens.videoList.total;
      }

    }
    if(mounted){
      setState(() {
        progressCode = false;
      });
    }



    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listCategoryVideos.clear();
    getHomePageContent();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
        backgroundColor: themeAppBarColors(),
        title:sText("${widget.dataCategories!.title}",weight: FontWeight.bold) ,
        centerTitle: false,
      ),
      body: Container(
        width: appWidth(context),
        padding: leftPadding(5),
        child: Column(
          children: [
            total != 0  && !progressCode ?
            Expanded(
              child: ListView(
                children: [
                  for(int i =0; i < listCategoryVideos.length; i++)
                    if(listCategoryVideos[i].videoList.data.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Container(
                            margin: leftPadding(10),
                            child: sText("${listCategoryVideos[i].title}",weight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 150,
                            child: ListView.builder(
                                itemCount: listCategoryVideos[i].videoList.data.length,
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
                                                child: displayImage("${listCategoryVideos[i].videoList.data[index].thumbnailImage}",width: 100,radius: 0),
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
            ) : progressCode ?
            Expanded(
                child: Center(
                  child: progress(),
                ))
                : Expanded(
                child: Center(
                  child: Container(
                  child: sText("Sorry No videos are available",weight: FontWeight.bold)
            ),
                ))
          ],
        ),
      ),
    );
  }
}
