
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:homi/helper/custom_theme_data.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:homi/pages/introduction.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //Ensure plugin services are initialized
  runApp(EasyDynamicThemeWidget(child: MyApp()));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme:  isDarkModeEnabledLocal ? darkThemeData : lightThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      onGenerateRoute: (settings){
          return MaterialPageRoute(builder: (_) => IntroductionPage() ); // Pass it to BarPage.
      },
      // routes: {
      //   '/': (_) => IntroductionPage()
      // },
    );
  }
}
