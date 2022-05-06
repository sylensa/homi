import 'dart:convert';
import 'package:carrier_info/carrier_info.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/pages/index.dart';
import 'package:homi/screens/login/index.dart';
import 'package:homi/screens/profile/index.dart';
import 'package:homi/services/get_homepage_banner.dart';
import 'package:homi/services/get_screens.dart';
import 'package:homi/services/get_user.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  checkUserExist()async{
    // await userAccountController.dropUserData("user_account");
    // await userAccountController.dropUserData("user_screen");
    List<Map<String, dynamic>> timelineResponse = await userAccountController.fetchUserData("user_account");
    print("response:${timelineResponse}");
    if(timelineResponse.isNotEmpty){
      Map<String, dynamic> res = json.decode(timelineResponse[0]["response"]);
      ResponseData dataData = ResponseData.fromJson(res);
      responseUserData.clear();
      responseUserData.add(dataData);
      userToken = responseUserData[0].accessToken;
      await getScreens();
    }else{
      await getHomePageBanner();

    }
  }
  getScreens()async{
    List<Map<String, dynamic>> timelineResponse = await userAccountController.fetchUserData("user_screen");
    if(timelineResponse.isNotEmpty){
      print("user_screen:${timelineResponse[0]["response"]}");
      Map<String, dynamic> res = json.decode(timelineResponse[0]["response"]);
      ResponseScreens dataData = ResponseScreens.fromJson(res);
      responseScreenUser.clear();
      responseScreenUser.add(dataData);
      await getHomePageBanner();
    }else{
      goTo(context, ManageProfile(),replace: true);
    }

  }
  getHomePageBanner()async{
    // try{
    var js = await doGet('medias/api/v2/home_page_banner');
    print("res timeline: $js");
    if(js["status"] == 'success'){
      BannerResponse responseScreens = BannerResponse.fromJson(js["response"]["banner"]);
      listBannerData.add(responseScreens);
      BannerResponse _responseScreens = BannerResponse.fromJson(js["response"]["new"]);
      listNewData.add(_responseScreens);
      await getHomePageContent();
    }else if(js["message"] == "You have already logged in  with other device.  Please login again to continue."){
      showDialogOk(message: js["message"] ,context: context,status: true,target: LoginPage(),replace: true);
    }else{
      showDialogOk(message: js["message"] ,context: context,status: false,);

    }


    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }

  }
  getHomePageContent()async{
    // try{
    var js = await doGet('medias/api/v2/home_page');
    print("res timeline: $js");
    if(js["status"] == 'success'){
      for(int i = 0; i < js["response"]["home_content"].length; i++){
        BannerResponse responseScreens = BannerResponse.fromJson(js["response"]["home_content"][i]);
        listHomeContent.add(responseScreens);
        goTo(context, Index(initialIndex: 0,),replace: true);
      }

    }else{
      showDialogOk(message: "failed",context: context,status: false);
    }


    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }

  }
  getSimInfo() async {
    try{
      String? carrierNames =   await CarrierInfo.carrierName;
      String? isoCountryCodes =  await CarrierInfo.isoCountryCode;
      String? mobileCountryCodes = await CarrierInfo.mobileCountryCode;
      String? mobileNetworkCodes = await CarrierInfo.mobileNetworkCode;
      Country? country = await getCountryByCountryCode(context, isoCountryCodes.toString().toUpperCase());

      setState(() {
        carrierName = carrierNames!;
        isoCountryCode = isoCountryCodes!;
        mobileCountryCode = mobileCountryCodes!;
        mobileNetworkCode = mobileNetworkCodes!;
        print("carrierName: $carrierName");
        if(carrierName.isNotEmpty){
          countryCode = country!.callingCode;
          print("isoCountryCode: $isoCountryCode");
          print("isoCountryCode: $isoCountryCode");
          print("mobileCountryCode: $mobileCountryCode");
          print("mobileNetworkCode: $mobileNetworkCode");
        }
        checkUserExist();

      });
    }catch(e){
      // print(e);
      checkUserExist();
    }

  }



  @override
  void initState()  {
    // TODO: implement initState
    getSimInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: dPurple,
      child: Center(
        child: Image.asset("assets/images/Homi-logo-white.png",width: 200,),
      ),
    );
  }
}
