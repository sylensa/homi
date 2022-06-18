import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/screens/movie/index.dart';
import 'package:homi/services/get_favourite_videos.dart';

class FavouriteMovies extends StatefulWidget {
  const FavouriteMovies({Key? key}) : super(key: key);

  @override
  _FavouriteMoviesState createState() => _FavouriteMoviesState();
}

class _FavouriteMoviesState extends State<FavouriteMovies> {
  bool progressCode = true;
  List<FavouriteData> listFavouriteData = [];
  getMyFavouriteVideos()async{
    // try{
   var js = await doGet('useractions/api/v2/favourite?page=1');
    print("res timeline: $js");
    if(!js["error"] && js["response"]["data"].isNotEmpty){
      for(int i = 0; i < js["response"]["data"].length; i++){
        FavouriteData favouriteData = FavouriteData.fromJson(js["response"]["data"][i]);
        listFavouriteData.add(favouriteData);
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
        title: sText("Favourites Videos",weight: FontWeight.bold),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 20),

        child:  Column(
          children: [
            listFavouriteData.isNotEmpty ?
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: appPadding(0),
                // shrinkWrap: true,
                crossAxisCount: 3,
                itemCount:listFavouriteData.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: (){
                        if(listFavouriteData[index].isWebseries == 1){
                          print("series");
                        }else{
                          goTo(context, MoviePage(
                            slug: listFavouriteData[index].slug,
                            title: listFavouriteData[index].title,));
                        }

                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              height: 150,
                              child: displayImage("${listFavouriteData[index].thumbnailImage}",radius: 0),
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
                                child: popUpMenu(movieId:listFavouriteData[index].slug,context: context )
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child:  GestureDetector(
                              onTap: () {
                                  setState(() {
                                    removeMovieFromFavourite(slug:listFavouriteData[index].slug);
                                    listFavouriteData.removeAt(index);
                                  });


                              },
                              child: Container(
                                child:Icon(Icons.favorite, color: dPurple,),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                staggeredTileBuilder: (int index) =>
                new StaggeredTile.fit(1),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
            )
                : progressCode ?
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
