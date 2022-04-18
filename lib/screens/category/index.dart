import 'dart:convert';

import 'package:homi/helper/helper.dart';
import 'package:homi/helper/hide.dart';
import 'package:homi/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/screens/category/category_page.dart';
import 'package:homi/services/get_categories.dart';
import 'package:http/http.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool progressCode = true;
  getCategories()async{
    // try{
    var url =  Uri.parse('${base}common/api/v2/menu-categories');
    print("url: $url");
    var js = await get(url);
   var decoded = jsonDecode(js.body);
    print("res timeline: $js");
    if(decoded["status"] == 'success'){
      for(int i = 0; i < decoded["response"]["data"].length; i++){
        DataCategories responseCategories = DataCategories.fromJson(decoded["response"]["data"][i]);
        listDataCategories.add(responseCategories);
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
    if(listDataCategories.isEmpty){
      getCategories();
    }

  }
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
        padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
        child:  Column(
          children: [
            listDataCategories.isNotEmpty ?
            Expanded(
              child:  GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: listDataCategories.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: (){
                        goTo(context, CategoryTypePage(dataCategories: listDataCategories[index],));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(listDataCategories[index].title),

                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(listDataCategories[index].imageUrl),
                              fit: BoxFit.fitWidth
                            )
                        ),


                      ),
                    );
                  }),
            ) : Expanded(child: Center(child: progress(),)),
          ],
        ),
      ),
    );
  }
}
