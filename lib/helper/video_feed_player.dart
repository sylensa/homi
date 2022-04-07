import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';
import 'package:video_box/video_box.dart';

class VideoPlayerRemoteFeeds extends StatefulWidget {
  String url;
  VideoPlayerRemoteFeeds({this.url = ''});
  @override
  _VideoPlayerRemoteFeedsState createState() => _VideoPlayerRemoteFeedsState();
}

class _VideoPlayerRemoteFeedsState extends State<VideoPlayerRemoteFeeds> {
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
    return   Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoBox(controller: vcs!,background: Container(
            width: appWidth(context),
            child: Image.asset("assets/images/Cough.png")),
        ),
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key? key, this.controller}) : super(key: key);

  final VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(

          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller!.value.isPlaying
              ? SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller!.play();
          },
        ),
      ],
    );
  }
}