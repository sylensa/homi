import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/screens/movie/index.dart';

class OfflineMovies extends StatefulWidget {
  const OfflineMovies({Key? key}) : super(key: key);

  @override
  _OfflineMoviesState createState() => _OfflineMoviesState();
}

class _OfflineMoviesState extends State<OfflineMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: themeAppBarColors(),
        title: sText("Offline Videos",weight: FontWeight.bold),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 20),

        child:  Column(
          children: [
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: appPadding(0),
                // shrinkWrap: true,
                crossAxisCount: 3,
                itemCount:12,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: (){
                        goTo(context, MoviePage());
                      },
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),

                                child: Container(
                                  height: 150,
                                  child: Image.asset("assets/images/pabi at ledge.jpg",width: 110,fit: BoxFit.fitHeight,),
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
                    ),
                staggeredTileBuilder: (int index) =>
                new StaggeredTile.fit(1),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
