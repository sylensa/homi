import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/helper/hide.dart';
import 'package:homi/helper/progress_dialog.dart';
import 'package:homi/pages/index.dart';
import 'package:homi/screens/login/index.dart';
import 'package:homi/screens/profile/add_edit_profile.dart';
import 'package:homi/services/get_history_movies.dart';
import 'package:homi/services/get_homepage_banner.dart';
import 'package:homi/services/get_screens.dart';
import 'package:homi/services/get_user.dart';

class ManageProfile extends StatefulWidget {
  bool fromSettings;
   ManageProfile({this.fromSettings = false}) ;

  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  bool progressCode = true;
  String errorMessage ='';
  var js;
  bool isRequest = true;
  String s_id = '';
  getScreens()async{
    // try{
     js = await doGet('users/api/v2/screens');
    print("res listResponseScreensssssss: $js");
    // return;
    if(!js["error"]){
      for(int i = 0; i < js["response"]["screens"].length; i++){
        ResponseScreens responseScreens = ResponseScreens.fromJson(js["response"]["screens"][i]);
        listResponseScreens.add(responseScreens);
      }
    }else{
      errorMessage = js["message"];
    }
    if(mounted){
      setState(() {
        progressCode = false;
      });
    }

    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }
  }
  getHomePageBanner()async{
    // try{
    var js = await doGet('medias/api/v2/home_page_banner');
    print("res timeline: $js");
    if(js["status"] == 'success'){
      listBannerData.clear();
      BannerResponse responseScreens = BannerResponse.fromJson(js["response"]["banner"]);
      listBannerData.add(responseScreens);
      BannerResponse _responseScreens = BannerResponse.fromJson(js["response"]["new"]);
      listNewData.add(_responseScreens);
      await getHomePageContent();
    }else{
      Navigator.pop(context);
      showDialogOk(message: "failed",context: context,status: false);
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
      listHomeContent.clear();
      for(int i = 0; i < js["response"]["home_content"].length; i++){
        BannerResponse responseScreens = BannerResponse.fromJson(js["response"]["home_content"][i]);
        listHomeContent.add(responseScreens);
        await getMyHistoryVideos();
        Navigator.pop(context);
        goTo(context, Index(initialIndex: 0,));
      }

    }else{
      Navigator.pop(context);
      showDialogOk(message: "failed",context: context,status: false);
    }


    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }

  }

  getMyHistoryVideos()async{
    // try{
    listHistoryData.clear();
    var js = await doGet('medias/api/v2/continue_watching');
    print("res recent: $js");
    if(!js["error"] && js["response"].isNotEmpty){
      for(int i = 0; i < js["response"].length; i++){
        ResponseContinueData historyData = ResponseContinueData.fromJson(js["response"][i]);
        listHistoryData.add(historyData);
      }
    }



    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }

  }

  requestProfile(String screenId)async{
    // try{
    var js = await doGet('users/api/v2/set-screen/$screenId');

    print("res createDummy: $js");

    // return;
    if(js["status"] == 'success'){
      toast(js["message"]);
      setState((){
        isRequest = true;
        s_id = '';

      });
    } else{
      setState((){
        isRequest = true;
        s_id = '';
      });
      showDialogOk(message: "${js["message"]}",context: context,status: false);
    }
    // }catch(e){
    //   Navigator.pop(context);
    //   print("error: $e");
    //   showDialogOk(message: "$e",context: context,status: false);
    // }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listResponseScreens.clear();
    getScreens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        backgroundColor: themeAppBarColors(),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: widget.fromSettings,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sText("Who's Watching",weight: FontWeight.bold,size: 20),
            sText("Select profile to explore related content",size: 14),
          ],
        ),
      ),
      body: Container(

        padding: EdgeInsets.only(bottom: 10,left: 20,right: 20,top: 10),
        child: Column(
          children: [
            listResponseScreens.isNotEmpty ?
            Expanded(
              child: ListView.builder(
                itemCount: listResponseScreens.length,
                  itemBuilder: (BuildContext context, int index){
                  if(index == 0){
                    return GestureDetector(
                      onTap: ()async{
                        ResponseScreens res = ResponseScreens(
                          id: listResponseScreens[index].id,
                          createdAt: listResponseScreens[index].createdAt,
                          customerId: listResponseScreens[index].customerId,
                          deviceId: listResponseScreens[index].deviceId,
                          isDefault: listResponseScreens[index].isDefault,
                          isOccupied: listResponseScreens[index].isOccupied,
                          name: listResponseScreens[index].name,
                          profileImage: listResponseScreens[index].profileImage,
                          updatedAt: listResponseScreens[index].updatedAt,
                          response: jsonEncode(js["response"]["screens"][index])
                        );

                        await userAccountController.dropUserData("user_screen");
                        await userAccountController.saveUserScreensData(res);
                        List<Map<String, dynamic>> timelineResponse = await userAccountController.fetchUserData("user_screen");
                        print("response:$timelineResponse");
                        Map<String, dynamic> _res = json.decode(timelineResponse[0]["response"]);
                        ResponseScreens dataData = ResponseScreens.fromJson(_res);
                        responseScreenUser.clear();
                        responseScreenUser.add(dataData);
                        showDialog(
                            context: context,
                            useRootNavigator: false,
                            builder: (BuildContext context) => const ProgressDialog(message: "Setting homepage...",)
                        );
                        await  getHomePageBanner();

                      },
                      child: Column(
                        children: [
                          Container(
                            padding: appPadding(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: dPurple),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: displayImage("${listResponseScreens[index].profileImage}",width: 50,height: 50),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: sText("${listResponseScreens[index].name}",weight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: ()async{
                                             var res = await goTo(context, AddEdithProfile(responseScreens: listResponseScreens[index],));
                                             print("res:$res");
                                              if(res != null && res){
                                                setState((){
                                                  listResponseScreens.clear();
                                                  getScreens();
                                                });
                                              }
                                            },
                                            child: Container(
                                              padding: appPadding(5),
                                              decoration: BoxDecoration(
                                                  color: dPurple,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: sText2("Edit Profile",weight: FontWeight.bold,color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          listResponseScreens[index].isDefault == 1 ?
                                          GestureDetector(
                                            onTap: ()async{
                                            var res =  await goTo(context, AddEdithProfile(responseScreens: listResponseScreens[index],isEdit: false,));
                                             if(res != null && res){
                                               setState((){
                                                 listResponseScreens.clear();
                                                 getScreens();
                                               });
                                             }

                                            },
                                            child: Container(
                                              padding: appPadding(5),
                                              decoration: BoxDecoration(
                                                  color: dPurple,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: sText2("Add New Profile",weight: FontWeight.bold,color: Colors.white),
                                            ),
                                          ) : Container(),
                                        ],

                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    );
                  }else{
                    return Column(
                      children: [
                        Container(
                          padding: appPadding(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: dPurple),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: displayImage("${listResponseScreens[index].profileImage}",width: 50,height: 50),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: sText("${listResponseScreens[index].name} ${listResponseScreens[index].deviceId == deviceId ? "(Current Device)" : ""}",weight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: ()async{
                                         var res =  await  goTo(context, AddEdithProfile(responseScreens: listResponseScreens[index],));
                                           print("res:$res");
                                           if(res != null && res){
                                             setState((){
                                               listResponseScreens.clear();
                                               getScreens();
                                             });
                                           }
                                          },
                                          child: Container(
                                            padding: appPadding(5),
                                            decoration: BoxDecoration(
                                                color: dPurple,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: sText2("Edit Profile",weight: FontWeight.bold,color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        listResponseScreens[index].deviceId == deviceId ?
                                            Container() :
                                        GestureDetector(
                                          onTap: (){
                                            setState((){
                                              isRequest = false;
                                              s_id = listResponseScreens[index].id;
                                            });
                                            requestProfile(listResponseScreens[index].id);
                                          },
                                          child: Container(
                                            padding: appPadding(5),
                                            decoration: BoxDecoration(
                                                color:  s_id == listResponseScreens[index].id ? Colors.grey[400] : dPurple,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                sText2("Request ",weight: FontWeight.bold,color: Colors.white),
                                                SizedBox(width: 10,),
                                                !isRequest &&  s_id == listResponseScreens[index].id ? progress() : Container()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10,)
                      ],
                    );
                  }

              }),
            ) : progressCode ? Expanded(child: Center(child: progress(),)) : Expanded(child: Container()),
            errorMessage.isNotEmpty ?
            GestureDetector(
              onTap: (){
                goTo(context, LoginPage(),replace: true);
              },
              child: Container(
                padding: appPadding(20),
                child: sText2("$errorMessage",color: dPurple,align: TextAlign.center,weight: FontWeight.bold),
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
