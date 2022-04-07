import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/screens/login/index.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Widget notSignedIn(){
    return Container(
      padding: topPadding(10),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: (){
                    goTo(context, LoginPage());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.login,color: themeAppColors(),)),
                        SizedBox(width: 10,),
                        Container(
                          child: sText("Sign In",weight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[200],),
                Container(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){

                      }, icon: Icon(Icons.subscript,color: themeAppColors(),)),
                      SizedBox(width: 10,),
                      Container(
                        child: sText("Go Premium",weight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200],),
                Container(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){

                      }, icon: Icon(Icons.settings_outlined,color: themeAppColors(),)),
                      SizedBox(width: 10,),
                      Container(
                        child: sText("Settings",weight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200],),
                Container(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){

                      }, icon: Icon(Icons.contact_support_outlined,color: themeAppColors(),)),
                      SizedBox(width: 10,),
                      Container(
                        child: sText("Contact Us",weight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200],),
              ],
            ),
          )
        ],
      ),
    );
  }
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
            sText("Welcome To Homi",color: themeAppColors(),weight: FontWeight.w700,size: 22,family: "ProximaBold"),
          ],
        ),
        elevation: 1,
        centerTitle: false,

      ),
      body: notSignedIn(),

    );
  }
}
