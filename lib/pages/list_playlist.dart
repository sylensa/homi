import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/pages/create_playlist.dart';
import 'package:homi/services/get_playlist.dart';
import 'package:homi/services/get_screens.dart';

class ListPlaylist extends StatefulWidget {
  ResponseScreens? responseScreens;
  String slug;
  ListPlaylist({this.responseScreens,this.slug = ''}) ;

  @override
  _ListPlaylisttState createState() => _ListPlaylisttState();
}

class _ListPlaylisttState extends State<ListPlaylist> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String profileImagePath = '';
  String profileImageName = '';
  bool progressCode = true;
  List<Datum> data = [];
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

  getPlaylist()async{
    // try{
    var js = await doGet('useractions/api/v2/create_playlist?video_id=queen-of-the-sun&page=1');
    print("res timeline: $js");
    if(js["status"] == 'success'){
      MyPlaylist responsePlaylist = MyPlaylist.fromJson(js["response"]["my_playlist"]);
      myPlaylist.add(responsePlaylist);
    }else{
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

  addMovieToPlaylist()async{
    // try{
    var js = await doPost('useractions/api/v2/create_playlist',{"name":data[0].name,"videos":widget.slug,"id":data[0].id,"screen":responseUserData.isNotEmpty ? widget.responseScreens!.id : ""});
    print("res timeline: $js");
    if(js["status"] == 'success'){
      toast(js["message"]);
    }else{
      toast(js["message"]);
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
    getPlaylist();
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
                              if(data.isNotEmpty){
                                addMovieToPlaylist();
                              }

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

                        goTo(context, CreatePlaylist(responseScreens: responseScreenUser[0],slug: widget.slug,));

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
                    SizedBox(height: 10,),
                    myPlaylist.isNotEmpty ?
                        Column(
                          children: [
                            for(int i = 0; i < myPlaylist[0].data.length; i++)
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(data.contains(myPlaylist[0].data[i])){
                                      data.clear();
                                    }else{
                                      data.clear();
                                      data.add(myPlaylist[0].data[i]);
                                    }
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: data.contains(myPlaylist[0].data[i]) ? true : false,
                                        onChanged: (value){
                                          print(value);
                                        },
                                        activeColor: dPurple,

                                      ),
                                      Container(
                                        child: sText("${myPlaylist[0].data[i].name}"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ) :
                    Center(child: progress(),)
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
