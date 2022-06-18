import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/services/get_my_transactions.dart';

class MyTransactions extends StatefulWidget {
  const MyTransactions({Key? key}) : super(key: key);

  @override
  State<MyTransactions> createState() => _MyTransactionsState();
}

class _MyTransactionsState extends State<MyTransactions> {
  bool progressCode = true;
  String progressCodeError = "Sorry, No transactions available";
  List<TransactionData> listTransactionData = [];
  getMyTransactions()async{
    // try{
    var json =  {
      "filter":null,
      "filters":{},
      "intialRequest":0,
      "orderByFieldName":null,
      "page":1,
      "rowsPerPage":10,
      "searchRecord":{"transaction_id":"","plan_name":""}
    };
    var js = await doPost('payments/api/v2/transactions/records',json
    );
    print("res timeline: $js");
    if(!js["error"] && js["data"]["data"].isNotEmpty){
      for(int i = 0; i < js["data"]["data"].length; i++){
        TransactionData transactionData = TransactionData.fromJson(js["data"]["data"][i]);
        listTransactionData.add(transactionData);
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
    getMyTransactions();
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
            listTransactionData.isNotEmpty ?
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
