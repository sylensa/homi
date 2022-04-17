import 'dart:convert';
import 'package:carrier_info/carrier_info.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/pages/index.dart';
import 'package:homi/screens/login/index.dart';
import 'package:homi/services/get_user.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  checkUserExist()async{
    // await userAccountController.dropUserData();
    List<Map<String, dynamic>> timelineResponse = await userAccountController.fetchUserData();
    print("response:${timelineResponse}");
    if(timelineResponse.isNotEmpty){
      Map<String, dynamic> res = json.decode(timelineResponse[0]["response"]);
      ResponseData dataData = ResponseData.fromJson(res);
      responseUserData.clear();
      responseUserData.add(dataData);
      goTo(context, Index(initialIndex: 0,),replace: true);
    }else{
      goTo(context, LoginPage());
    }
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
