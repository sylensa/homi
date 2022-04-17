import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/screens/contact/index.dart';
import 'package:homi/screens/favourite/index.dart';
import 'package:homi/screens/history/index.dart';
import 'package:homi/screens/login/index.dart';
import 'package:homi/screens/offline/index.dart';
import 'package:homi/screens/playlist/index.dart';
import 'package:homi/screens/profile/index.dart';
import 'package:homi/screens/rent/index.dart';
import 'package:homi/screens/settings/index.dart';

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

  Widget signedIn(){
    return Container(
      padding: topPadding(10),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: (){
                    goTo(context, ManageProfile());
                  },
                  child: Container(
                    padding: leftPadding(10),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.person,color: themeAppColors(),)),
                        SizedBox(width: 10,),
                        Container(
                          child: sText("Manage Profiles",weight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[200],),
                GestureDetector(
                  onTap: (){
                    goTo(context, FavouriteMovies());
                  },
                  child: Container(
                    padding: leftPadding(10),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.slow_motion_video_sharp,color: themeAppColors(),)),
                        SizedBox(width: 10,),
                        Container(
                          child: sText("My Favourites",weight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[200],),
                GestureDetector(
                  onTap: (){
                    goTo(context, MyPlaylistMovies());
                  },
                  child: Container(
                    padding: leftPadding(10),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.playlist_add,color: themeAppColors(),)),
                        SizedBox(width: 10,),
                        Container(
                          child: sText("My Playlist",weight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[200],),
                GestureDetector(
                  onTap: (){
                    goTo(context, OfflineMovies());
                  },
                  child: Container(
                    padding: leftPadding(10),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.save_alt_outlined,color: themeAppColors(),)),
                        SizedBox(width: 10,),
                        Container(
                          child: sText("Offline Videos",weight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[200],),
                GestureDetector(
                  onTap: (){
                    goTo(context, WatchHistoryMovies());
                  },
                  child: Container(
                    padding: leftPadding(10),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.lock_clock,color: themeAppColors(),)),
                        SizedBox(width: 10,),
                        Container(
                          child: sText("Watch History",weight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[200],),
                Container(
                  padding: leftPadding(10),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){

                      }, icon: Icon(Icons.save_alt_outlined,color: themeAppColors(),)),
                      SizedBox(width: 10,),
                      Container(
                        child: sText("My Transactions",weight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200],),
                GestureDetector(
                  onTap: (){
                    goTo(context, RentedMovies());
                  },
                  child: Container(
                    padding: leftPadding(10),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.play_circle,color: themeAppColors(),)),
                        SizedBox(width: 10,),
                        Container(
                          child: sText("My Rented Videos",weight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[200],),
                GestureDetector(
                  onTap: (){
                    goTo(context, SettingsPage());
                  },
                  child: Container(
                    padding: leftPadding(10),
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
                ),
                Divider(color: Colors.grey[200],),
                GestureDetector(
                  onTap: (){
                    goTo(context, ContactUsPage());
                  },
                  child: Container(
                    padding: leftPadding(10),
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
                ),
                Divider(color: Colors.grey[200],),
                Container(
                  padding: leftPadding(10),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){

                      }, icon: Icon(Icons.logout,color: themeAppColors(),)),
                      SizedBox(width: 10,),
                      Container(
                        child: sText("Sign Out",weight: FontWeight.bold),
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

  Widget signedInTitle(){
    return Row(
      children: [
        displayImage("${responseUserData[0].profilePicture}",width: 50,height: 50),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sText("${properCase(responseUserData[0].name)}",color: themeAppColors(),weight: FontWeight.w700,size: 16,family: "ProximaBold"),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
              decoration: BoxDecoration(
                  color: dPurple,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: sText2("Go Premium",color: Colors.white),
            )
          ],
        ),
      ],
    );
  }

  Widget notSignedInTitle(){
    return Row(
      children: [
        displayImage("imagePath",width: 40,height: 40),
        SizedBox(width: 10,),
        sText("Welcome To Homi",color: themeAppColors(),weight: FontWeight.w700,size: 16,family: "ProximaBold"),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        backgroundColor: themeAppBarColors(),
        title: responseUserData.isNotEmpty ? signedInTitle() : notSignedInTitle(),
        elevation: 0,
        centerTitle: false,

      ),
      body:responseUserData.isNotEmpty ? signedIn() : notSignedIn(),

    );
  }
}
