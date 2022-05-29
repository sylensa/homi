import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/pages/list_playlist.dart';
import 'package:homi/services/get_playlist.dart';
import 'package:homi/services/get_screens.dart';

class EditPlaylist extends StatefulWidget {
  String name;
  String id;
  EditPlaylist({this.name = '',this.id = ''}) ;

  @override
  _EditPlaylistState createState() => _EditPlaylistState();
}

class _EditPlaylistState extends State<EditPlaylist> {
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
  bool progressCode = false;
  editPlaylist({String name = ''})async{
    // try{
    var js = await doPost('useractions/api/v2/create_playlist',{"screen": responseScreenUser[0].id,"name":name,"id": widget.id});
    print("res timeline: $js");
    if(js["status"] == "success"){
      await  getPlaylist();
    }
    else if(js["message"] == "Playlist already exists"){
      Navigator.pop(context);
      setState(() {
        progressCode = false;
        toast(js["message"]);
      });
    } else{
      Navigator.pop(context);
      setState(() {
        progressCode = false;
        toast(js["message"]);
      });
    }

    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }

  }

  getPlaylist()async{
    // try{
    var js = await doGet('useractions/api/v2/create_playlist');
    print("res list_playlist: $js");
    if(js["status"] == 'success'){
      myPlaylist.clear();
      MyPlaylist responsePlaylist = MyPlaylist.fromJson(js["response"]["my_playlist"]);
      myPlaylist.add(responsePlaylist);
      Navigator.pop(context);
      setState(() {
        progressCode = false;
        toast(js["message"]);
      });
    }else{
      Navigator.pop(context);
      toast(js["message"]);
    }
    setState(() {
      progressCode = false;
    });

    // }catch(e){
    //   print("error timeline: $e");
    //   toast("$e, try again");
    // }

  }

  @override
  void initState() {
    // TODO: implement initState
    print(progressCode);
    nameController.text = widget.name;
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
                child: sText("Edit Playlist",weight: FontWeight.bold,size: 20),
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
                    !progressCode ?
                    GestureDetector(
                      onTap: (){
                        if(nameController.text.isNotEmpty){
                          setState(() {
                            progressCode = true;
                          });
                          editPlaylist(name: nameController.text);
                        }else{
                          toast("Field is empty");
                        }

                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        width: 150,
                        child: sText2("Save",color: Colors.white,align: TextAlign.center),
                        decoration: BoxDecoration(
                            color: dPurple,
                            borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                    ) : progress(),
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
