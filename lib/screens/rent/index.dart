import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/services/get_my_rented_movies.dart';
import 'package:homi/services/get_my_transactions.dart';

class RentedMovies extends StatefulWidget {
  const RentedMovies({Key? key}) : super(key: key);

  @override
  State<RentedMovies> createState() => _RentedMoviesState();
}

class _RentedMoviesState extends State<RentedMovies> {
  bool progressCode = true;
  String progressCodeError = "Sorry, No transactions available";
  List<RentData> listRentData = [];
  getMyRentedMovies()async{
    // try{
    var json =   {
      "filter":null,
      "filters":{},
      "intialRequest":0,
      "orderByFieldName":null,
      "page":1,
      "rowsPerPage":10,
      "searchRecord":{"transaction_id":"","plan_name":""}
    };
    var js = await doPost('payments/api/v2/purchase_videos/records',json
    );
    print("res timeline: $js");
    if(!js["error"] && js["data"]["data"].isNotEmpty){
      for(int i = 0; i < js["data"]["data"].length; i++){
        RentData rentData = RentData.fromJson(js["data"]["data"][i]);
        listRentData.add(rentData);
      }
    }else{
      if(js["error"]){
        progressCodeError = js["message"];
      }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyRentedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        backgroundColor: themeAppBarColors(),
        title: sText("My Transactions",weight: FontWeight.bold,size: 20),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            listRentData.isNotEmpty ?
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context,int index){
                    return Container(
                      padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 20),
                      margin: EdgeInsets.only(right: 10,left: 10,bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: sText("M",weight: FontWeight.bold,size: 20),
                                        padding: appPadding(10),
                                        decoration: BoxDecoration(
                                            color: dPurple,
                                            shape: BoxShape.circle
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        child: sText("Monthly Standard",weight: FontWeight.w500),
                                      ),

                                    ],

                                  ),

                                ),
                                Container(
                                  child: sText("5.99",weight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(height: 0,),
                                Container(
                                  child: sText("May 20 2022 09:59 PM",weight: FontWeight.normal),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  child: sText2("Paid",weight: FontWeight.bold,color: Colors.green),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    );
                  }),
            )
                : progressCode ?
            Expanded(
                child: Center(
                  child: progress(),
                ))
                : Expanded(
                child: Center(
                  child: Container(
                      child: sText("$progressCodeError",weight: FontWeight.bold)
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
