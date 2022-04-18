import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/services/get_screens.dart';

class AddEdithProfile extends StatefulWidget {
   ResponseScreens? responseScreens;
   AddEdithProfile({this.responseScreens}) ;

  @override
  _AddEdithProfileState createState() => _AddEdithProfileState();
}

class _AddEdithProfileState extends State<AddEdithProfile> {
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
    nameController.text = widget.responseScreens!.name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 240,
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
                child: sText("Add Profile"),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  attachDoc();
                },
                child: Container(
                  child:  profileImagePath.isNotEmpty ?
                  CircleAvatar(
                    foregroundColor: Colors.grey,
                    backgroundColor: Colors.white,
                    radius: 40,
                    backgroundImage:  FileImage(File(profileImagePath)),
                    // child:  Image.file(File(profileImagePath),height: 80,width: 80,),
                  ) :
                  displayImage("${widget.responseScreens!.profileImage}",width: 70,height: 70),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 20,),
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
                                    hint: 'Name',
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
