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

         title: Image.asset("assets/images/Homi-logo-white.png",width: 100,),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: rightPadding(5),
            child: Icon(Icons.search,color: themeAppColors(),),
          ),
          responseUserData.isNotEmpty ?
          Row(
            children: [
              Container(
                margin: rightPadding(10),
                child: Icon(Icons.notifications_outlined,color: themeAppColors(),),
              ),
              Container(
                margin: rightPadding(20),
                child: displayImage("${responseUserData[0].profilePicture}",width: 30,height: 30),
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
        padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
        child:  Column(
          children: [
            Expanded(
              child:  GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: listCategories.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(listCategories[index].categoryName),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15)),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
