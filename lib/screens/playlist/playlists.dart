import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/helper/progress_dialog.dart';
import 'package:homi/pages/edit_playlist.dart';
import 'package:homi/screens/movie/index.dart';
import 'package:homi/screens/playlist/index.dart';
import 'package:homi/services/get_playlist.dart';

class ListMyPlaylist extends StatefulWidget {
  const ListMyPlaylist({Key? key}) : super(key: key);

  @override
  _ListMyPlaylistState createState() => _ListMyPlaylistState();
}

class _ListMyPlaylistState extends State<ListMyPlaylist> {

  bool progressCode = true;
  List<PlaylistData> listPlaylistData = [];
  getPlaylist()async{
    // try{
    var js = await doGet('useractions/api/v2/create_playlist');
    print("res list_playlist: $js");
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
  deletePlaylist({String playlistId = '', int index = 0})async{
    // try{
    var js = await doDelete('useractions/api/v2/create_playlist?playlist_id=$playlistId');
    print("res deleted_playlist_videos: $js");
    if(js["status"] == 'success'){
      setState(() {
        if( myPlaylist[0].data.length > 0){
          myPlaylist[0].data.removeAt(index);
        }else{
          myPlaylist.clear();
        }
      });

      Navigator.pop(context);
      toast(js["message"]);
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

  popUpMenu({String playlistId = "",String name = '',BuildContext? context,int index = 0}){
    return  PopupMenuButton(onSelected: (result) async{
      if(result == "edit"){
       await goTo(context!, EditPlaylist(name: name,id: playlistId,));
       setState(() {

       });
      }else{
        showDialog(
            context: context!,
            useRootNavigator: false,
            builder: (BuildContext context) => const ProgressDialog(message: "Deleting playlist...",)
        );
        await deletePlaylist(playlistId: playlistId,index: index);
      }
    },
      padding: bottomPadding(0),
      child: Container(
        child: Icon(Icons.more_vert,color: Colors.white),
      ),
      // add this line
      itemBuilder: (_) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          child: Container(
            // height: 30,
            child: sText("Remove Playlist",size: 18),
          )
          , value: 'playlist',
          onTap: ()async{

          },
        ),
        PopupMenuItem<String>(
          child: Container(
            // height: 30,
              child: sText("Edit Title",size: 18)
          )
          , value: 'edit',
          onTap: (){
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myPlaylist.clear();
    getPlaylist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: themeAppBarColors(),
        title: sText("My Playlist",weight: FontWeight.bold),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 20),

        child:  Column(
          children: [
            myPlaylist.isNotEmpty ?
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: appPadding(0),
                shrinkWrap: true,
                crossAxisCount: 2,
                itemCount:myPlaylist[0].data.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: (){
                        goTo(context, MyPlaylistMovies(id: myPlaylist[0].data[index].id,name: myPlaylist[0].data[index].name,));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5)),
                              child: Container(
                                height: 200,
                                child: displayImage("${myPlaylist[0].data[index].posterImage}",radius: 0),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: sText("${properCase(myPlaylist[0].data[index].name)}",color: Colors.white),
                                  ),
                                ),
                                 Container(
                                   child: popUpMenu(playlistId: myPlaylist[0].data[index].id,context: context,name: myPlaylist[0].data[index].name),
                                 )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                staggeredTileBuilder: (int index) =>
                new StaggeredTile.fit(1),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
            ) : progressCode ? Expanded(child: Center(child: progress(),)) : Expanded(child: Center(child: sText("No Playlist",weight: FontWeight.bold),)) ,
          ],
        ),
      ),
    );
  }
}
