import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tiktok/service/home_service.dart';
import 'package:flutter_tiktok/ui/const.dart';
import 'package:flutter_tiktok/ui/home/home_bloc.dart';
import 'package:flutter_tiktok/ultils/color.dart';
import 'package:flutter_tiktok/ultils/img.dart';
import 'package:flutter_tiktok/ultils/size.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../model/User.dart';
import '../../ultils/icon.dart';

class HomePage extends StatefulWidget {
  List<User>? user;
  HomePage({Key? key,this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: widget.user!.length, vsync: this);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody(){
    var size = MediaQuery.of(context).size;
    return RotatedBox(
      quarterTurns: 1,
      child: TabBarView(
        controller: _tabController,
        children: List.generate(widget.user!.length, (index) {
          return VideoPlayerItem(
            size: size,
            user: widget.user![index],
          );
        }),
      ),
    );
  }

}

class VideoPlayerItem extends StatefulWidget {
  final User? user;
  const VideoPlayerItem({
    Key? key,
    required this.size,this.user
  }) : super(key: key);

  final Size size;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoController = VideoPlayerController.network(widget.user!.videoUrl!)
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
    return RotatedBox(
      quarterTurns: -1,
      child: SizedBox(
        width: widget.size.width,
        height: widget.size.height,
        child: Stack(
          children: [
            Container(
              width: widget.size.width,
              height: widget.size.height,
              decoration: const BoxDecoration(
                  color: ConstColor.colorBg
              ),
              child: VideoPlayer(_videoController),
            ),
            SizedBox(
              width: widget.size.width,
              height: widget.size.height,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: ConstSize.size25,
                      right: ConstSize.size15,
                      left: ConstSize.size15,
                    bottom: ConstSize.size15
                  ),
                  child: Column(
                    children: [
                      const HeaderHomePage(),
                      Flexible(
                        child: Row(
                          children: [
                            LeftHome(
                                size: widget.size,
                                caption: widget.user!.caption,
                                name: widget.user!.userName,
                                songName: widget.user!.songName,
                            ),
                            RightHome(
                                vidID: widget.user!.id,
                                size: widget.size,
                                albumImg: widget.user!.image,
                                comment: widget.user!.comment,
                                like: widget.user!.like,
                                profileImg: widget.user!.image,
                                share: widget.user!.share,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RightHome extends StatelessWidget {
  final String? profileImg;
  final int? like;
  final int? comment;
  final int? share;
  final String? albumImg;
  final int? vidID;
  RightHome({
    Key? key,
    required this.size, this.profileImg, this.like, this.comment, this.share, this.albumImg,this.vidID
  }) : super(key: key);

  final Size size;
  RxBool checkLike = false.obs;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: size.height,
        child: Column(
          children: [
            Container(
              height: size.height*0.3,
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getProfile(profileImg),
                    getLikes(TikTokIcons.heart, like, 35.0,checkLike,vidID!,context),
                    getComments(TikTokIcons.chat_bubble, comment.toString(), 35.0,() {}),
                    getShare(TikTokIcons.reply, share.toString(), 30.0),
                    getAlbum(albumImg)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class LeftHome extends StatelessWidget {
  final String? name;
  final String? caption;
  final String? songName;
  const LeftHome({
    Key? key,
    required this.size, this.name, this.caption, this.songName,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width*0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(name!,style: const TextStyle(color: ConstColor.white),),
          const SizedBox(height: ConstSize.size10,),
          Text(caption!,style: const TextStyle(color: ConstColor.white),),
          const SizedBox(height: ConstSize.size10,),
          Row(
            children: [
              const Icon(Icons.music_note,color: ConstColor.white,),
              Text(songName!,style: const TextStyle(color: ConstColor.white,fontSize: 12),),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Following",style: TextStyle(color: ConstColor.white.withOpacity(0.5),fontSize: ConstSize.size16),),
        const SizedBox(width: ConstSize.size5,),
        Text("|",style: TextStyle(color: ConstColor.white.withOpacity(0.5),fontSize: ConstSize.size16),),
        const SizedBox(width: ConstSize.size5,),
        const Text("For you",style: TextStyle(color: ConstColor.white,fontSize: ConstSize.size17,fontWeight: FontWeight.bold),),
      ],
    );
  }
}
