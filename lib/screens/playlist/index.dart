import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/helper/progress_dialog.dart';
import 'package:homi/screens/movie/index.dart';
import 'package:homi/services/get_playlist.dart';
import 'package:homi/services/get_playlist_videos.dart';
import 'package:share/share.dart';

class MyPlaylistMovies extends StatefulWidget {
  String id ;
  String name;
   MyPlaylistMovies({this.id = '',this.name = ''});

  @override
  _MyPlaylistMoviesState createState() => _MyPlaylistMoviesState();
}

class _MyPlaylistMoviesState extends State<MyPlaylistMovies> {

  bool progressCode = true;
  List<PlaylistMovieResponse> listPlaylistData = [];
  getPlaylistMovie()async{
    // try{
    var js = await doGet('useractions/api/v2/create_playlist_videos?playlist_id=${widget.id}');
    print("res create_playlist_videos: $js");
    if(js["status"] == 'success' && js["response"]["playlist_videos"]["data"].isNotEmpty){
      PlaylistMovieResponse responsePlaylist = PlaylistMovieResponse.fromJson(js["response"]);
      listPlaylistData.add(responsePlaylist);
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
  deletePlaylistMovie({String movieId = '', int index = 0})async{
    // try{
    var js = await doDelete('useractions/api/v2/create_playlist_videos?playlist_id=${widget.id}&video_id=$movieId');
    print("res deleted_playlist_videos: $js");
    if(js["status"] == 'success'){
      setState(() {
        if( listPlaylistData[0].playlistVideos!.data!.length > 0){
          listPlaylistData[0].playlistVideos!.data!.removeAt(index);
        }else{
          listPlaylistData.clear();
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

  popUpMenu({String movieId = "",BuildContext? context,int index = 0}){
    return  PopupMenuButton(onSelected: (result) async{
      if(result == "playlist"){
        showDialog(
            context: context!,
            useRootNavigator: false,
            builder: (BuildContext context) => const ProgressDialog(message: "Deleting video...",)
        );
        await deletePlaylistMovie(movieId: movieId,index: index);
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
            child: sText("Remove from Playlist",size: 18),
          )
          , value: 'playlist',
          onTap: (){

          },
        ),
        PopupMenuItem<String>(
          child: Container(
            // height: 30,
              child: sText("Share",size: 18)
          )
          , value: 'share',
          onTap: (){
            _onShareData(context!);
          },
        ),
      ],
    );
  }

  _onShareData(BuildContext context) async {

    await Share.share("ds", subject: "Homi",);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlaylistMovie();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: themeAppBarColors(),
        title: sText("${widget.name}",weight: FontWeight.bold),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 20),

        child:  Column(
          children: [
            listPlaylistData.isNotEmpty ?
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: appPadding(0),
                // shrinkWrap: true,
                crossAxisCount: 3,
                itemCount:listPlaylistData[0].playlistVideos!.data!.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: (){
                        goTo(context, MoviePage(slug: listPlaylistData[0].playlistVideos!.data![index].video!.slug!,title: listPlaylistData[0].playlistVideos!.data![index].video!.title!,));
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              height: 150,
                              child: displayImage("${listPlaylistData[0].playlistVideos!.data![index].video!.thumbnailImage}",radius: 0,),
                            ),
                          ),
                          Positioned(

                            right: 0,
                            child: Container(
                                padding: EdgeInsets.only(left: 5,top: 3,bottom: 5,right: 0),
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
                                ),
                                child: popUpMenu(movieId:listPlaylistData[0].playlistVideos!.data![index].video!.slug! ,context: context,index: index)
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
            ) : progressCode ? Expanded(child: Center(child: progress(),)) : Expanded(child: Center(child: sText("Playlist Empty",weight: FontWeight.bold),)),
          ],
        ),
      ),
    );
  }
}
