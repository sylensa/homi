import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/pages/create_playlist.dart';
import 'package:homi/services/get_screens.dart';

class ListPlaylist extends StatefulWidget {
  ResponseScreens? responseScreens;
  ListPlaylist({this.responseScreens}) ;

  @override
  _ListPlaylisttState createState() => _ListPlaylisttState();
}

class _ListPlaylisttState extends State<ListPlaylist> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String profileImagePath = '';
  String profileImageName = '';
  attachDoc() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);

    if(result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      PlatformFile file = result.files.first;
      print(file.name);
      setState(() {
        profileImagePath = file.path!;
        profileImageName = file.name;
        print("profileImagePath:$profileImagePath");
        print("profileImageName:$profileImageName");
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 5),
          height: 160,
          width: 340,
          decoration: BoxDecoration(
              color: themeAppBarColors(),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(blurStyle: BlurStyle.solid,color: Colors.white,spreadRadius: 1)
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 5,),
                    Container(
                      padding: rightPadding(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: bottomPadding(5),
                              child: Icon(Icons.close,color: dPurple,),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        goTo(context, CreatePlaylist(responseScreens: responseScreenUser[0],));
                      },
                      child: Container(
                        child: sText("Create New Playlist",weight: FontWeight.bold,size: 16,align: TextAlign.center),
                        padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                          color: dPurple,
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            child: sText("or choose an existing Playlist") ,
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),

                    for(int i = 0; i < 10; i++)
                      Container(
                        child: Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (value){
                                print(value);
                              },
                              activeColor: dPurple,

                            ),
                            Container(
                              child: sText("Sylensa Playlist"),
                            )
                          ],
                        ),
                      )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
