import 'package:homi/helper/helper.dart';
import 'package:homi/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homi/helper/helper.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        backgroundColor: themeAppBarColors(),

        title: Row(
          children: [
            displayImage("imagePath",width: 30,height: 30),
            SizedBox(width: 10,),
            sText("Category",color: themeAppColors(),weight: FontWeight.w700,size: 22,family: "ProximaBold"),
          ],
        ),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: (){

              }, icon: Icon(Icons.search,color: themeAppColors(),)),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: (){

              }, icon: Icon(Icons.person,color: themeAppColors(),))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 0,right: 0,bottom: 10,top: 10),
        child:  Column(
          children: [
            Expanded(
              child:  StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: listCategories.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              child: Image.asset("assets/images/${listCategories[index].categoryName}.png",),
                            ),
                            Container(
                              margin: topPadding(50),
                              width: 180,
                              child: Center(child: sText2("${listCategories[index].categoryName}",color: Colors.white,align: TextAlign.center,family: "ProximaBold",weight: FontWeight.w700,size: 14.46)),
                            )
                          ],
                        ),
                      ),
                    ),
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.fit(2),
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
