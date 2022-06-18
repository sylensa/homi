import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/services/get_screens.dart';

class AddEdithProfile extends StatefulWidget {
   ResponseScreens? responseScreens;
   bool isEdit;
   AddEdithProfile({this.responseScreens,this.isEdit = true}) ;

  @override
  _AddEdithProfileState createState() => _AddEdithProfileState();
}

class _AddEdithProfileState extends State<AddEdithProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String profileImagePath = '';
  String profileImageName = '';
  bool isSubmit = true;
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
  addProfile()async{
    // try{
    var js = await doPost('users/api/v2/save-screen', {
      "name": nameController.text.trim(),
      "profile_image":profileImagePath,
    });

    print("res createDummy: $js");

    // return;
    if(js["status"] == 'success'){
      toast(js["message"]);
      Navigator.pop(context,true);
    } else{
      setState((){
        isSubmit = true;
      });
      showDialogOk(message: "${js["message"]}",context: context,status: false);
    }
    // }catch(e){
    //   Navigator.pop(context);
    //   print("error: $e");
    //   showDialogOk(message: "$e",context: context,status: false);
    // }

  }
  editProfile()async{
    // try{
    var js = await doPost('users/api/v2/save-screen', {
      "name": nameController.text.trim(),
      "screen":widget.responseScreens!.id,
    });

    print("res createDummy: $js");

    // return;
    if(js["status"] == 'success'){
      toast(js["message"]);
      Navigator.pop(context,true);
    } else{
      setState((){
        isSubmit = true;
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
    nameController.text = widget.isEdit ? widget.responseScreens!.name : "";
    profileImagePath = widget.isEdit ? widget.responseScreens!.profileImage : "";
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
                child: sText(widget.isEdit ? "Edit Profile" : "Add Profile",weight: FontWeight.bold),
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
                    GestureDetector(
                      onTap: (){
                        if(isSubmit){
                          setState((){
                            isSubmit = false;
                          });
                          if(widget.isEdit){
                            editProfile();
                          }else{
                            addProfile();
                          }
                        }

                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sText2("Save",color: Colors.white,align: TextAlign.center),
                            SizedBox(width: 10,),
                            isSubmit ? Container() : progress()
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: isSubmit ? dPurple : Colors.grey[400],
                          borderRadius: BorderRadius.circular(5)
                        ),
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
