import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:homi/controller/user_account_controller.dart';
import 'package:homi/helper/hide.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homi/pages/create_playlist.dart';
import 'package:homi/pages/list_playlist.dart';
import 'package:homi/screens/profile/add_edit_profile.dart';
import 'package:homi/services/get_categories.dart';
import 'package:homi/services/get_categories_videos.dart';
import 'package:homi/services/get_history_movies.dart';
import 'package:homi/services/get_homepage_banner.dart';
import 'package:homi/services/get_playlist.dart';
import 'package:homi/services/get_screens.dart';
import 'package:homi/services/get_user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recase/recase.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDarkModeEnabledLocal = true;
bool viewedSlider = false;
String allowsVOIP = '';
String carrierName = '';
String isoCountryCode = '';
String countryCode = '';
String mobileCountryCode = '';
String mobileNetworkCode = '';
List<ResponseScreens> listResponseScreens = [];
List<DataCategories> listDataCategories = [];
List<ResponseScreens> responseScreenUser = [];
var userAccountController = UserAccountController();
List<ResponseData> responseUserData = [];
List<BannerResponse> listBannerData = [];
List<BannerResponse> listNewData = [];
List<BannerResponse> listHomeContent = [];
List<Main> listCategoryVideos = [];
List<MyPlaylist> myPlaylist = [];
var userToken = "";
var deviceId = "";
List<ResponseContinueData> listHistoryData = [];
List<BoxShadow> elevation({required Color color, required int elevation}) {
  return [
    BoxShadow(color: color.withOpacity(0.6), offset: Offset(0.0, 4.0), blurRadius: 3.0 * elevation, spreadRadius: -1.0 * elevation),
    BoxShadow(color: color.withOpacity(0.44), offset: Offset(0.0, 1.0), blurRadius: 2.2 * elevation, spreadRadius: 1.5),
    BoxShadow(color: color.withOpacity(0.12), offset: Offset(0.0, 1.0), blurRadius: 4.6 * elevation, spreadRadius: 0.0),
  ];
}

const Color sBlueGray = Color(0xFFb4bbc9);
const Color solonGray200 = Color(0xFFdadcdf);
const Color solonGray300 = Color(0xFFADB5BD);
const Color solonGray400 = Color(0xFF9ea6ad);
const Color solonGray500 = Color(0xFF757b81);
const Color solonGray600 = Color(0xFF5b5f64);
const Color solonGray700 = Color(0xFF495057);

const Color darkColor = Color(0xFF253341);

Color sDarkGray = dDarkText.withOpacity(0.8);
Color sGray = dDarkText.withOpacity(0.4);
const dDarkText = Color(0xFF1D1D1D);
const Color dTurquoise = Color(0xFF0CB8B6);
const Color dPurple = Color(0xFF9F5DE2);
const Color dMiddleBlue = Color(0xFF5C86CE);
const Color dPurpleGradientLeft = Color(0xFF7A08FA);
const Color dPurpleGradientRight = Color(0xFFAD3BFC);
const Color dRedGradientRight = Color(0xFFE5366A);
const Color dRedGradientLeft = Color(0xFFFE806F);

displayImage(imagePath, {double radius = 30.0, double? height,double? width}) {
  return CachedNetworkImage(
      imageUrl: imagePath,
      height: height,
      width: width,
      placeholder: (context, url) {
        return radius > 0 ? CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/images/none.png'),
          radius: radius,
        ) :
        const Image(
          image: AssetImage('assets/images/none.png'),
        );
      },
      errorWidget: (context, url, error) {
        return radius > 0 ? CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage('assets/images/none.png'),
          radius: radius,
        ) :
        const Image(
          image: AssetImage('assets/images/none.png'),
        );
      },
      imageBuilder: (context, image) {
        return radius > 0 ? CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: image,
          radius: radius,
        ) :
        Image(
          image: image,
          fit: BoxFit.cover,
        );
      }
  );
}

Widget displaySQImage(imagePath, {double radius = 30.0, double height = 0, double width = 0}) {
  return CachedNetworkImage(
      imageUrl: imagePath,
      placeholder: (context, url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          clipBehavior: Clip.hardEdge,
          child: Container(
            color: solonGray200,
            width: width,
            height: height,
          ),
        );
      },
      errorWidget: (context, url, error) => ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            clipBehavior: Clip.hardEdge,
            child: Container(
              color: solonGray200,
              width: height,
              height: height,
            ),
          ),
      imageBuilder: (context, image) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image(
              image: image,
              fit: BoxFit.cover,
              height: height,
              width: width,
            ));
      });
}

Widget displayCircularImage(imagePath, {double radius = 30.0}) {
  return CachedNetworkImage(
      imageUrl: imagePath,
      placeholder: (context, url) {
        return CircleAvatar(
          backgroundColor: solonGray200,
          radius: radius,
        );
      },
      imageBuilder: (context, image) {
        return CircleAvatar(
          backgroundImage: image,
          radius: radius,
        );
      });
}

Widget displayLocalImage(String filePath, {double radius = 30.0, double? height, double? width}) {
  File file = new File(filePath);
  return radius > 20
      ? CircleAvatar(
          backgroundColor: solonGray200,
          backgroundImage: (filePath.isEmpty ? AssetImage('images/user_placeholder.png') : FileImage(file)) as ImageProvider<Object>?,
          radius: radius,
        )
      : Image(
          fit: BoxFit.fitWidth,
          height: height,
          width: width,
          image: (filePath.isEmpty ? AssetImage('images/user_placeholder.png') : FileImage(file)) as ImageProvider<Object>,
        );
}

Widget progress({double size = 30}) {
  return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(backgroundColor: solonGray200, valueColor: const AlwaysStoppedAnimation<Color>(dPurple)));
}



Widget sText(String? word,
    {double size = 15,
    FontWeight weight = FontWeight.w400,
    Color color = solonGray700,
    TextAlign align = TextAlign.left,
    int maxLines = 5,
    double? lHeight = 1.2,
    String family =  'ProximaRegular' ,
    int shadow = 0}) {
  return Text(
    word ?? '...',
    softWrap: true,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: align,
    style: TextStyle(
      height: lHeight,
      color: themeAppColors(),
      fontFamily: 'ProximaRegular',
      fontSize: size,
      fontWeight: weight,
      shadows: shadow > 0 ? elevation(color: Colors.black38, elevation: shadow) : [],
    ),
  );
}

Widget sText2(String? word,
    {double size = 15,
      FontWeight weight = FontWeight.w400,
      Color color = solonGray700,
      TextAlign align = TextAlign.left,
      int maxLines = 5,
      double? lHeight = 1.2,
      String family =  'ProximaRegular' ,
      int shadow = 0}) {
  return Text(
    word ?? '...',
    softWrap: true,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: align,
    style: TextStyle(
      height: lHeight,
      color: color,
      fontFamily: 'ProximaRegular',
      fontSize: size,
      fontWeight: weight,
      shadows: shadow > 0 ? elevation(color: Colors.black38, elevation: shadow) : [],
    ),
  );
}

Widget solonOutlineButton({
  required Widget content,
  required Function onPressed,
  textColor: Colors.white,
  double z: 16,
  double radius: 5,
  int shadowStrength: 1,
  double borderWidth: 1,
  double height: 60,
  EdgeInsetsGeometry? padding,
  Color outlineColor: const Color(0xFFf2f2f2),
  Color backgroundColor: Colors.white,
  String family =  'ProximaRegular' ,
}) {
  return Container(
    height: height,
    decoration: shadowStrength > 0
        ? BoxDecoration(boxShadow: elevation(color: solonGray200, elevation: shadowStrength), borderRadius: BorderRadius.circular(radius))
        : BoxDecoration(borderRadius: BorderRadius.circular(radius)),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        backgroundColor: backgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius), side: BorderSide(color: outlineColor, width: borderWidth)),
      ),
      onPressed: () => onPressed(),
      child: content,
    ),
  );
}

Widget dPurpleGradientButton(
    {required Widget content,
    required Function onPressed,
    double radius: 5,
    double height: 50,
    EdgeInsetsGeometry? padding,
    List<Color> colors: const [dPurpleGradientLeft, dPurpleGradientRight],
    gradientDirection: 'left_right'}) {
  return SizedBox(
    height: height,
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: gradientDirection == 'left_right' ? Alignment.centerLeft : Alignment.topCenter,
            end: gradientDirection == 'left_right' ? Alignment.centerRight : Alignment.bottomCenter,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(radius)),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//          backgroundColor: col,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        onPressed: () => onPressed(),
        child: content,
      ),
    ),
  );
}

Future goTo(BuildContext context, Widget target,
    {bool replace = false, PageTransitionType anim = PageTransitionType.size, int millis = 200, bool opaque = true}) {
  if (!opaque) {
    if (!replace) {
      return Navigator.of(context).push(PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (BuildContext context, animation, secondaryAnimation) => target,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          }));
    } else {
      return Navigator.of(context).pushReplacement(PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (BuildContext context, animation, secondaryAnimation) => target,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          }));
    }
  }
  if (!replace) {
    return Navigator.push(
        context, PageTransition(type: anim, duration: Duration(milliseconds: millis), alignment: Alignment.bottomCenter, child: target));
  } else
    return Navigator.pushReplacement(
        context, PageTransition(type: anim, duration: Duration(milliseconds: millis), alignment: Alignment.bottomCenter, child: target));
}

TextStyle appStyle({double size = 16, Color? col = dDarkText, FontWeight weight = FontWeight.w400,String family = "ProximaRegular"}) {
  return TextStyle(fontFamily: family, fontWeight: weight, fontSize: size, color: col);
}

EdgeInsets noPadding() {
  return EdgeInsets.zero;
}

EdgeInsets appPadding(double size) {
  return EdgeInsets.all(size);
}

InputDecoration textDecor(
    {String hint = '',
    Widget? icon,
    String prefix = '',
    Widget? suffix,
      Widget? suffixIcon,
    bool enabled = true,
    Color? hintColor = solonGray500,
    double hintSize = 16,
    bool showBorder = true,
    double radius = 4,
    String label = '',
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0)}) {
  return new InputDecoration(
    prefixIcon: icon,
    prefixText: prefix,
    suffix: suffix,
    suffixIcon: suffixIcon,
    hintText: hint,
    floatingLabelBehavior: (label.isNotEmpty && hint.isNotEmpty) ? FloatingLabelBehavior.never : FloatingLabelBehavior.auto,
    hintStyle: appStyle(size: hintSize, col: themeAppColors()),
//    border: UnderlineInputBorder(
//      borderSide: BorderSide(color: theColor),
//    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    labelText: label,
    labelStyle: appStyle(size: hintSize, col: themeAppColors()),
//    filled: true,
//    fillColor: Colors.white,
    contentPadding: padding,
  );
}

InputDecoration textDecorNoBorder(
    {String? hint,
    String prefix = '',
    Widget? suffix,
    Widget? prefixIcon,
    bool enabled = true,
    double hintSize = 16,
    Color? hintColor,
    String family = "ProximaRegular" ,
    FontWeight hintWeight: FontWeight.normal,
    Color? fill,
      double radius = 4,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0)}) {
  return new InputDecoration(
    prefixText: prefix,
    suffix: suffix,
    prefixIcon: prefixIcon,
    hintText: hint,
    hintStyle: appStyle(size: hintSize, col: hintColor, weight: hintWeight,family:family ),
    alignLabelWithHint: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: themeAppColors(), width: 1),
     borderRadius: BorderRadius.circular(radius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: themeAppColors(), width: 1),
     borderRadius: BorderRadius.circular(radius),
    ),
    focusColor: dPurple,
    enabled: enabled,
    labelStyle: appStyle(size: hintSize),
    filled: true,
    fillColor: themeAppBarColors(),
    contentPadding: padding,
  );
}

showDialogOk({String? message,BuildContext? context,Widget? target,bool? status,bool replace = false}) {
  // flutter defined function
  showDialog(
    context: context!,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Alert"),
        content: new Text(message!),
        actions: <Widget>[
          new MaterialButton(
            child: new Text("Ok"),
            onPressed: () {
              if(status!){
                Navigator.pop(context);
                goTo(context, target!,replace: replace);
              }else{
                Navigator.pop(context);
              }

            },
          ),
        ],
      );
    },
  );
}

showSuccessfulDialog({String? message,BuildContext? context,Widget? target,bool? status}) {
  // flutter defined function
  showDialog(
    context: context!,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Alert"),
        content: new Text(message!),
        actions: <Widget>[
          new MaterialButton(
            child: new Text("Ok"),
            onPressed: () {
              if(status!){
                Navigator.pop(context);
                goTo(context, target!,replace: false);
              }else{
                Navigator.pop(context);
              }

            },
          ),
        ],
      );
    },
  );
}

showDialogYesNo(String message,String alert,BuildContext context,Widget target) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(alert),
        content: new Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new MaterialButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          new MaterialButton(
            child: new Text("Yes"),
            onPressed: () {
              goTo(context, target);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}



appWidth(con) {
  return MediaQuery.of(con).size.width;
}
appHeight(con) {
  return MediaQuery.of(con).size.height;
}



List<BoxShadow> appShadow(Color col, double offset, double blur, double spread) {
  return [
    BoxShadow(
        blurRadius: blur,
        color: col,
        offset: Offset(0, 2.0),
        spreadRadius: spread
    ),
  ];
}

Future<bool> clearPrefs() async {
  var sp = await SharedPreferences.getInstance();
  sp.clear();
  return true;
}
Future<bool> setPref(key, value, {type = 'string'}) async {
  var sp = await SharedPreferences.getInstance();
  print("Setting $type pref $key to $value...");
  switch (type) {
    case 'string':
      sp.setString(key, value);
      break;
    case 'bool':
      sp.setBool(key, value);
      break;
    case 'int':
      sp.setInt(key, value);
      break;
    case 'list':
      List<String> ls = value;
      sp.setStringList(key, ls);
      break;

  }
  return true;
}
Future<dynamic> getPref(key, {type = 'string'}) async {
  var sp = await SharedPreferences.getInstance();
  switch (type) {
    case 'string':
      return sp.getString(key);
      break;
    case 'bool':
      return sp.getBool(key);
      break;
    case 'list':
      List<String> aList = [];
      List<String>? data = sp.getStringList(key);
      if (data != null) {
        aList = data;
        return aList;
      } else {
        return aList;
      }
      break;
  }
}

EdgeInsets topPadding(double size) {
  return EdgeInsets.only(top: size);
}

EdgeInsets bottomPadding(double size) {
  return EdgeInsets.only(bottom: size);
}
EdgeInsets leftPadding(double size) {
  return EdgeInsets.only(left: size);
}
EdgeInsets rightPadding(double size) {
  return EdgeInsets.only(right: size);
}
EdgeInsets horizontalPadding(double size) {
  return EdgeInsets.symmetric(horizontal: size);
}

EdgeInsets verticalPadding(double size) {
  return EdgeInsets.symmetric(vertical: size);
}
properCase(String txt) {
  return txt.titleCase;
}
capCase(String txt) {
  return txt.toUpperCase();
}
sentenceCase(String txt) {
  if (txt.isEmpty) return txt;
  return txt.sentenceCase;
}



toast(String text, {bool long = false}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      backgroundColor: dDarkText,
      textColor: Colors.white
  );
}

Map replaceNulls(Map m) {
  for (var i in m.keys) {
    if (m[i] is String) {
      if (m[i] == "null") {
        m[i] = '';
      }
    } else if (m[i] == Null) {
      m[i] = '';
    } else {
      m[i] = jsonEncode(m[i]);
    }
  }
  return m;
}

bool appIsEmpty(value) {
  return value.toString() == '' || value == null || value == 'null';
}
Map stripNulls(dynamic v) {
  Map m = v.toMap();
  Map<String, String> finalMap = v.toMap();
  for (var i in m.keys) {
      if (m[i] == "null") {
      finalMap.remove(i);
    }
  }
  return finalMap;
}
doDelete(String urlAfterBase) async {
  var url = Uri.parse('$base$urlAfterBase');
  print("url: $url");
  var js = await http.delete(url,headers: {"authorization": "Bearer " + userToken});
  var decoded;
  try {
    decoded = jsonDecode(js.body);
  } catch(e) {
    print("decoded: ${js.body}");
    print(e);
  }
  return decoded;
}

doPost(String urlAfterBase, Map body) async {
  var headers = {"authorization": "Bearer " + userToken,"X-SCREEN-ID":responseScreenUser.isNotEmpty ? responseScreenUser[0].id : "","X-DEVICE-ID": deviceId};
  print('Calling $base$urlAfterBase...');
  print('body $body...');
  print('body $headers...');
  var url = Uri.parse('$base$urlAfterBase');
  var decoded;
  var js;
  if(userToken.isNotEmpty){
     js = await http.post(url, body: replaceNulls(body),headers: headers);
  }else{
     js = await http.post(url, body: replaceNulls(body));
  }
  print("body: ${js.body}");
  try{
    decoded = jsonDecode(js.body);
  }catch(e){
    print("post: $e");
  }
  return decoded;
}

doGet(String urlAfterBase) async {
  var headers = {"authorization": "Bearer " + userToken,"X-SCREEN-ID":responseScreenUser.isNotEmpty ? responseScreenUser[0].id : "","X-DEVICE-ID": deviceId};
  var url = Uri.parse('$base$urlAfterBase');
  print("url: $url");
  print("userToken: $userToken");
  print("userScreenId: ${responseScreenUser.isNotEmpty ? responseScreenUser[0].id : ""}");
  print("headers: $headers");
  var js;
  if(userToken.isNotEmpty){
    js =await http.get(url, headers: headers );
  }else{
     js = await http.get(url );
  }
  var decoded;
  print("decoded: ${js.body}");
  try {
    decoded = jsonDecode(js.body);
  } catch(e) {

    print(e);
  }
  return decoded;
}




navigateTo(BuildContext context, Widget target, {bool replace = false, PageTransitionType anim = PageTransitionType.fade, int millis = 300, bool opaque = false}) {
  if (!replace) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: opaque,
        pageBuilder: (BuildContext context, animation, secondaryAnimation) => target,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        }));
  } else
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.size,
            duration: Duration(milliseconds: 300),
            alignment: Alignment.bottomCenter,
            child: target
        )
    );
}





themeAppColors(){
  return isDarkModeEnabledLocal ?  Colors.white  : darkColor;
}

themeAppBarColors(){
  return isDarkModeEnabledLocal ? darkColor : Colors.white;
}

popUpMenu({String movieId = "",BuildContext? context}){
  return  PopupMenuButton(onSelected: (result) {
    if(result == "playlist"){
      if(responseScreenUser.isNotEmpty){
        goTo(context!, ListPlaylist(responseScreens: responseScreenUser[0],slug: movieId,));
      }else{
        toast("Kindly login first");
      }
    }
  },
    padding: bottomPadding(0),
    child: Container(
      child: Icon(Icons.more_vert,color: Colors.white),
    ),
    // add this line
    itemBuilder: (_) => <PopupMenuItem<String>>[
      PopupMenuItem<String>(
        child: Container(
          // height: 30,
          child: sText("Add To Playlist",size: 18),
        )
        , value: 'playlist',
        onTap: (){

        },
      ),
      PopupMenuItem<String>(
        child: Container(
          // height: 30,
            child: sText("Share",size: 18)
        )
        , value: 'share',
        onTap: (){
          _onShareData(context!);
        },
      ),
    ],
  );
}
_onShareData(BuildContext context) async {

  await Share.share("ds", subject: "Homi",);
}
addMovieToFavourite({String slug = '',})async{
  // try{
  var js = await doPost('useractions/api/v2/favourite',{"video_slug":slug,"screen": responseScreenUser.isNotEmpty ? responseScreenUser[0].id : ""});
  print("res timeline: $js");
  if(js["status"] == 'success'){
    toast(js["message"]);
  }else{
    toast(js["message"]);
  }
  // }catch(e){
  //   print("error timeline: $e");
  //   toast("$e, try again");
  // }

}
removeMovieFromFavourite({String slug = '',})async{
  // try{
  var js = await doDelete("useractions/api/v2/favourite?video_slug=$slug");
  print("res timeline: $js");
  if(js["status"] == 'success'){
    toast(js["message"]);
  }else{
    toast(js["message"]);
  }
  // }catch(e){
  //   print("error timeline: $e");
  //   toast("$e, try again");
  // }

}

likeMovie({String slug = '',})async{
  // try{
  var js = await doPost('useractions/api/v2/like',{"video_id":slug,"status": 1});
  print("res timeline: $js");
  if(js["status"] == 'success'){
    toast(js["message"]);
  }else{
    toast(js["message"]);
  }
  // }catch(e){
  //   print("error timeline: $e");
  //   toast("$e, try again");
  // }

}

disLikeMovie({String slug = '',})async{
  // try{
  var js = await doPost('useractions/api/v2/dislike',{"video_id":slug,"status": 1});
  print("res timeline: $js");
  if(js["status"] == 'success'){
    toast(js["message"]);
  }else{
    toast(js["message"]);
  }
  // }catch(e){
  //   print("error timeline: $e");
  //   toast("$e, try again");
  // }

}

extension StringExtension on String {
  static String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;
    if(diffInHours < 0){
      diffInHours = diffInHours * -1;
      if (diffInHours < 1) {
        final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
        timeValue = diffInMinutes;
        timeUnit = 'm';
      } else if (diffInHours < 24) {
        timeValue = diffInHours;
        timeUnit = 'h';
      } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
        timeValue = (diffInHours / 24).floor();
        timeUnit = 'd';
      } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
        timeValue = (diffInHours / (24 * 7)).floor();
        timeUnit = 'w';
      } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
        timeValue = (diffInHours / (24 * 30)).floor();
        timeUnit = 'm';
      } else {
        timeValue = (diffInHours / (24 * 365)).floor();
        timeUnit = 'y';
      }
      timeAgo = timeValue.toString() + ' ' + timeUnit;
      timeAgo += timeValue > 1 ? '' : '';

      return 'in ' + timeAgo;
    }else{
      if (diffInHours < 1) {
        final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
        timeValue = diffInMinutes;
        timeUnit = 'm';
      } else if (diffInHours < 24) {
        timeValue = diffInHours;
        timeUnit = 'h';
      } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
        timeValue = (diffInHours / 24).floor();
        timeUnit = 'd';
      } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
        timeValue = (diffInHours / (24 * 7)).floor();
        timeUnit = 'wk';
      } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
        timeValue = (diffInHours / (24 * 30)).floor();
        timeUnit = 'mt';
      } else {
        timeValue = (diffInHours / (24 * 365)).floor();
        timeUnit = 'yr';
      }
      timeAgo = timeValue.toString() + timeUnit;
      timeAgo += timeValue > 1 ? '' : '';

      return timeAgo;
    }



  }
}
