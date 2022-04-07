import 'package:flutter/material.dart';
import 'package:flutter_tiktok/model/UserVideo.dart';
import 'package:video_player/video_player.dart';

import '../../ultils/color.dart';

class VideoBuilder extends StatefulWidget {
  final UserVideo? video;
  const VideoBuilder({Key? key,this.video}) : super(key: key);

  @override
  State<VideoBuilder> createState() => _VideoBuilderState();
}

class _VideoBuilderState extends State<VideoBuilder> {

  late VideoPlayerController _videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoController = VideoPlayerController.network(widget.video!.videoUrl!)
      ..initialize().then((value) {
        _videoController.play();
        setState(() {

          isShowPlaying = false;
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController.dispose();
  }

  Widget isPlaying(){
    return _videoController.value.isPlaying && !isShowPlaying  ? Container() : Icon(Icons.play_arrow,size: 80,color: ConstColor.white.withOpacity(0.5),);
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_videoController);
  }
}
