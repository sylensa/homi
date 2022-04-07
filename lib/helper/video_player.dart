import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/helper/helper.dart';
import 'package:video_box/video_box.dart';

class VideoPlayerRemote extends StatefulWidget {
   String url;
  VideoPlayerRemote({this.url = ''});
  @override
  _VideoPlayerRemoteState createState() => _VideoPlayerRemoteState();
}

class _VideoPlayerRemoteState extends State<VideoPlayerRemote> {
  VideoController? vcs ;
  @override
  void initState() {
    super.initState();
    vcs = (VideoController(source: VideoPlayerController.network("${widget.url}"))
      ..initialize());
  }

  @override
  void dispose() {
    vcs!.dispose();//dispose the VideoPlayer
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: leftPadding(60),
      height: 200.0,
      width: appWidth(context),
      padding: const EdgeInsets.only(top: 12.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoBox(controller: vcs!),
      ),
    );
  }
}