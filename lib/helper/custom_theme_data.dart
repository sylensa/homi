import 'package:flutter/material.dart';

var lightThemeData =  ThemeData(
    primaryColor: Colors.blue,
    toggleableActiveColor: Colors.blue,
    textTheme:  TextTheme(button: TextStyle(color: Colors.black),),
    brightness: Brightness.light,
    accentColor: Colors.blue,


);

var darkThemeData = ThemeData(
    primaryColor: Colors.blue,
    toggleableActiveColor: Colors.black,
    textTheme:  TextTheme(button: TextStyle(color: Colors.white)),
    brightness: Brightness.dark,
    accentColor: Colors.blue);