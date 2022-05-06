import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/services/get_screens.dart';

class CreatePlaylist extends StatefulWidget {
  ResponseScreens? responseScreens;
  CreatePlaylist({this.responseScreens}) ;

  @override
  _CreatePlaylistState createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
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
              SizedBox(height: 10,),
              Container(
                child: sText("Create Playlist",weight: FontWeight.bold,size: 20),
              ),

              Column(
                children: [
                  SizedBox(height: 10,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: nameController,
                                  // autofocus: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please check that you\'ve entered name correctly';
                                    }
                                    return null;
                                  },
                                  decoration: textDecorNoBorder(
                                    hint: 'Playlist name',
                                    hintColor: Colors.grey[400],
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      width: 150,
                      child: sText2("Save",color: Colors.white,align: TextAlign.center),
                      decoration: BoxDecoration(
                          color: dPurple,
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        width: 150,
                        child: sText2("Cancel",color: Colors.white,align: TextAlign.center),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
