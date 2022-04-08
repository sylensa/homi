import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:homi/helper/helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool assetOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeAppBarColors(),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
        title: sText("Settings",weight: FontWeight.bold,size: 20),
        centerTitle: false,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: appPadding(15),
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: solonGray200),
                      borderRadius: BorderRadius.only(
                        topLeft:  Radius.circular(10) ,
                        topRight:  Radius.circular(10),
                        bottomLeft:  Radius.circular(0),
                        bottomRight:  Radius.circular(0),
                      ),

                      // boxShadow: elevation(color: solonGray200, elevation: 1),
                    ),
                    child:
                    Row(children: [
                      Expanded(
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(child: sText("Autoplay Videos", weight: FontWeight.bold, size: 16)),
                            Container(child: sText("On/Off videos playing automatically", weight: FontWeight.normal, size: 14)),
                          ],
                        ),
                      ),
                      FlutterSwitch(
                        width: 50.0,
                        height: 30.0,
                        valueFontSize: 10.0,
                        toggleSize: 30.0,
                        value: assetOn,
                        borderRadius: 30.0,
                        padding: 5.0,
                        showOnOff: false,
                        activeColor: darkColor,
                        inactiveColor: Colors.white,
                        inactiveTextColor: Colors.red,
                        inactiveToggleColor: darkColor,
                        inactiveSwitchBorder: Border.all(
                            color: darkColor,
                            width: 2
                        ),
                        activeSwitchBorder: Border.all(
                            color: Colors.white,
                            width: 2
                        ),
                        onToggle: (val) {
                          setState(() {
                            assetOn = val;
                          });
                        },
                      ),
                    ]),
                  ),
                  Container(
                    padding: appPadding(15),
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: solonGray200),
                      borderRadius: BorderRadius.only(
                        topLeft:  Radius.circular(0) ,
                        topRight:  Radius.circular(0),
                        bottomLeft:  Radius.circular(0),
                        bottomRight:  Radius.circular(0),
                      ),

                      // boxShadow: elevation(color: solonGray200, elevation: 1),
                    ),
                    child:
                    Row(children: [
                      Expanded(
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(child: sText("Enable Dark mode", weight: FontWeight.bold, size: 16)),
                            Container(child: sText("Enabling dark mode change the appearance of the app", weight: FontWeight.normal, size: 14)),
                          ],
                        ),
                      ),
                      // FlutterSwitch(
                      //   width: 50.0,
                      //   height: 30.0,
                      //   valueFontSize: 10.0,
                      //   toggleSize: 30.0,
                      //   value: assetOn,
                      //   borderRadius: 30.0,
                      //   padding: 5.0,
                      //   showOnOff: false,
                      //   activeColor: darkColor,
                      //   inactiveColor: Colors.white,
                      //   inactiveTextColor: Colors.red,
                      //   inactiveToggleColor: darkColor,
                      //   inactiveSwitchBorder: Border.all(
                      //       color: darkColor,
                      //       width: 2
                      //   ),
                      //   activeSwitchBorder: Border.all(
                      //       color: Colors.white,
                      //       width: 2
                      //   ),
                      //   onToggle: (val) async{
                      //
                      //     setState(() {
                      //       assetOn = val;
                      //       // this.isDarkModeEnabled = isDarkModeEnabled;
                      //       bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
                      //       print(isDarkModeOn);
                      //       EasyDynamicTheme.of(context).changeTheme(dynamic: false,dark: !isDarkModeOn);
                      //       isDarkModeEnabledLocal = !isDarkModeOn;
                      //     });
                      //     await setPref("isDarkModeEnabled", isDarkModeEnabledLocal,type: 'bool');
                      //     isDarkModeEnabledLocal = await getPref("isDarkModeEnabled",type: 'bool');
                      //     setState(() {
                      //
                      //     });
                      //   },
                      // ),
                      DayNightSwitcher(
                        isDarkModeEnabled: isDarkModeEnabledLocal,
                        onStateChanged: (isDarkModeEnabled) async{
                          setState(() {
                            // this.isDarkModeEnabled = isDarkModeEnabled;
                            bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
                            print(isDarkModeOn);
                            EasyDynamicTheme.of(context).changeTheme(dynamic: false,dark: !isDarkModeOn);
                            isDarkModeEnabledLocal = !isDarkModeOn;
                          });
                          await setPref("isDarkModeEnabled", isDarkModeEnabled,type: 'bool');
                          isDarkModeEnabledLocal = await getPref("isDarkModeEnabled",type: 'bool');
                          setState(() {

                          });
                        },
                      )
                    ]),
                  ),
                  Container(
                    padding: appPadding(15),
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: solonGray200),
                      borderRadius: BorderRadius.only(
                        topLeft:  Radius.circular(0) ,
                        topRight:  Radius.circular(0),
                        bottomLeft:  Radius.circular(10),
                        bottomRight:  Radius.circular(10),
                      ),

                      // boxShadow: elevation(color: solonGray200, elevation: 1),
                    ),
                    child:
                    Row(children: [
                      Expanded(
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(child: sText("All Notifications", weight: FontWeight.bold, size: 16)),
                            Container(child: sText("On/Off message notification", weight: FontWeight.normal, size: 14)),
                          ],
                        ),
                      ),
                      FlutterSwitch(
                        width: 50.0,
                        height: 30.0,
                        valueFontSize: 10.0,
                        toggleSize: 30.0,
                        value: assetOn,
                        borderRadius: 30.0,
                        padding: 5.0,
                        showOnOff: false,
                        activeColor: darkColor,
                        inactiveColor: Colors.white,
                        inactiveTextColor: Colors.red,
                        inactiveToggleColor: darkColor,
                        inactiveSwitchBorder: Border.all(
                            color: darkColor,
                            width: 2
                        ),
                        activeSwitchBorder: Border.all(
                            color: Colors.white,
                            width: 2
                        ),
                        onToggle: (val) {
                          setState(() {
                            assetOn = val;
                          });
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
