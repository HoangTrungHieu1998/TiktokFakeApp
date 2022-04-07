import 'package:flutter/material.dart';
import 'package:flutter_tiktok/model/Profile.dart';
import 'package:flutter_tiktok/model/UserVideo.dart';
import 'package:flutter_tiktok/ui/profile/video_builder.dart';
import 'package:video_player/video_player.dart';

import '../../ultils/color.dart';
import '../../ultils/img.dart';

class ItemImage extends StatelessWidget {
  final List<UserVideo>? userVideo;
  const ItemImage({Key? key,this.userVideo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3/4, // 2/2
      crossAxisCount: 3,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
      children: List.generate(userVideo!.length, (index) {
        return VideoBuilder(video: userVideo![index],);
      }),
    );
  }
}
