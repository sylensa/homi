import 'package:carrier_info/carrier_info.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/screens/signup/index.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
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

      });
    }catch(e){
      // print(e);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSimInfo();
  }
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
        title: sText("Contact Us",weight: FontWeight.bold,size: 20),
        centerTitle: false,
      ),

      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              child: ListView(
                children: [
                  Container(
                    child: Center(child: sText2("Lets Talk",color: dPurple,weight: FontWeight.bold)),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Center(child: sText("Questions? Comments? We'd love to hear from please don't hesitate to get in touch ",weight: FontWeight.bold)),
                  ),
                  SizedBox(height: 20,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: leftPadding(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: emailController,
                                  autofocus: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please check that you\'ve entered your email correctly';
                                    }
                                    return null;
                                  },
                                  decoration: textDecor(

                                    label: 'Enter Your Name',
                                    hint: "Enter Your Name",
                                    hintColor: dPurple,
                                    padding: noPadding(),
                                    icon: Container(
                                      margin: rightPadding(20),
                                      child: Icon(Icons.person, color: dPurple),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          margin: leftPadding(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: passwordController,
                                  autofocus: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please check that you\'ve entered your password correctly';
                                    }
                                    return null;
                                  },
                                  decoration: textDecor(
                                    label: 'Enter Your Email',
                                    hint: "Enter Your Email",
                                    hintColor: dPurple,
                                    padding: noPadding(),
                                    icon: Container(
                                      margin: rightPadding(20),
                                      child: Icon(Icons.lock_outline, color: dPurple),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Container(
                              margin: leftPadding(10),
                              decoration:  BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey,
                                          width: 1
                                      )
                                  )
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.phone_android, color: dPurple),
                                  CountryCodePicker(
                                    padding: EdgeInsets.zero,
                                    onChanged: (e){
                                      print(e.code);
                                      print(e.name);
                                      print(e.dialCode);
                                      print(e.toLongString());
                                    },
                                    initialSelection: '${isoCountryCode.toUpperCase()}',
                                    showCountryOnly: false,
                                    showFlag: false,
                                    showFlagDialog: true,
                                    showOnlyCountryWhenClosed: false,
                                    backgroundColor: Colors.white54,
                                    dialogTextStyle: const TextStyle(
                                        fontFamily: "Brand-Bold",
                                        color: Colors.white
                                    ),
                                    searchStyle: const TextStyle(
                                        fontFamily: "Brand-Bold",
                                        color: Colors.black
                                    ),
                                    dialogBackgroundColor: darkColor,
                                    showDropDownButton: true,
                                    textStyle: const TextStyle(
                                        fontFamily: "Brand-Bold",
                                        color:dPurple
                                    ),
                                    dialogSize: Size(350, 350),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Theme(
                                  data: Theme.of(context).copyWith(primaryColor: Colors.red),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: mobileController,
                                    decoration:  textDecor(
                                      label: 'Mobile',
                                      hintColor: dPurple,
                                      padding: noPadding(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: bioController,
                                  maxLines: 5,
                                  // autofocus: true,
                                  maxLength: 250,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please check that you\'ve entered your message';
                                    }
                                    return null;
                                  },
                                  decoration: textDecorNoBorder(
                                    hint: 'Leave Your Message Here (Max 250 Letters)',
                                    hintColor: Colors.grey[400],
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),


                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  padding: EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
                  child: sText2("Submit",color: Colors.white,weight: FontWeight.bold),
                  decoration: BoxDecoration(
                      color: dPurple,
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
