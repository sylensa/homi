import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/screens/movie/index.dart';
import 'package:homi/services/get_history_movies.dart';

class WatchHistoryMovies extends StatefulWidget {
  const WatchHistoryMovies({Key? key}) : super(key: key);

  @override
  _WatchHistoryMoviesState createState() => _WatchHistoryMoviesState();
}

class _WatchHistoryMoviesState extends State<WatchHistoryMovies> {
  bool progressCode = true;

  getMyFavouriteVideos()async{
    // try{
    var js = await doGet('medias/api/v2/continue_watching');
    print("res recent: $js");
    if(!js["error"] && js["response"].isNotEmpty){
      for(int i = 0; i < js["response"].length; i++){
        ResponseContinueData historyData = ResponseContinueData.fromJson(js["response"][i]);
        listHistoryData.add(historyData);
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
    listHistoryData.clear();
    getMyFavouriteVideos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: themeAppBarColors(),
        title: sText("Watch History",weight: FontWeight.bold),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 20),

        child:  Column(
          children: [
            listHistoryData.isNotEmpty ?
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: appPadding(0),
                // shrinkWrap: true,
                crossAxisCount: 3,
                itemCount:listHistoryData.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: (){
                        goTo(context, MoviePage(slug: listHistoryData[index].video!.slug!, title: listHistoryData[index].video!.title!,secendsWatch: listHistoryData[index].seconds.toInt(),));

                      },
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),

                                child: Container(
                                  height: 150,
                                  child: displayImage("${listHistoryData[index].video!.thumbnailImage}",width: 110,radius: 0),
                                ),
                              ),
                              // Positioned(
                              //
                              //   right: 0,
                              //   child: Container(
                              //       padding: EdgeInsets.only(left: 5,top: 3,bottom: 5,right: 0),
                              //       decoration: BoxDecoration(
                              //           color: Colors.black12,
                              //           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
                              //       ),
                              //       child: Icon(Icons.more_vert,color: dPurple,)
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                staggeredTileBuilder: (int index) =>
                new StaggeredTile.fit(1),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
            )     : progressCode ?
            Expanded(
                child: Center(
                  child: progress(),
                ))
                : Expanded(
                child: Center(
                  child: Container(
                      child: sText("Sorry No videos are available",weight: FontWeight.bold)
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
