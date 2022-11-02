import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:homi/controller/main_controller.dart';
import 'package:homi/helper/custom_theme_data.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/model/download_update.dart';
import 'package:homi/screens/category/index.dart';
import 'package:homi/screens/home/index.dart';
import 'package:homi/screens/menu/index.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';




class Index extends StatefulWidget {
  int initialIndex = 0;
  Index({this.initialIndex = 0});
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late MainController mainController;
  @override
  void initState() {
    mainController = MainController(
      context,
      context.read<DownloadUpdate>(),
    );
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (context.read<DownloadUpdate>().isDownloading) {
        Wakelock.enable();
      }
    }
    if (state == AppLifecycleState.paused) {
      Wakelock.disable();
    }
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: isDarkModeEnabledLocal ? darkThemeData : lightThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: DefaultTabController(
        initialIndex: widget.initialIndex,
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: themeAppBarColors(),
            child: TabBar(
              labelColor:  dPurple ,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.transparent,
              labelPadding: appPadding(0),
              padding: bottomPadding(20),
              tabs: [
                Tab(
                  icon:Icon(Iconsax.home_1),
                  text: "Home",

                ),
                Tab(
                  icon:Icon(Iconsax.category_25),
                  text: "Categories",
                ),

                Tab(
                  icon:Icon(Iconsax.menu_1),
                  text: "Menu",
                ),
              ],
            ),
          ),
          body:  TabBarView(
            children: [
              HomePage(controller: mainController,),
              CategoryPage(),
              MenuPage(),
            ],
          ),


        ),
      ),
    );
  }
}

