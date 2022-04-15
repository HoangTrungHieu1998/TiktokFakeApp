import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_tiktok/model/Result.dart';
import 'package:flutter_tiktok/service/home_service.dart';
import 'package:flutter_tiktok/ultils/color.dart';
import 'package:flutter_tiktok/ultils/dialog.dart';
import 'package:get/get.dart';

import '../service/cache_manager.dart';

Widget getAlbum(albumImg) {
  return SizedBox(
    width: 50,
    height: 50,
    child: Stack(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: ConstColor.colorBg),
        ),
        Center(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        albumImg),
                    fit: BoxFit.cover)),
          ),
        )
      ],
    ),
  );
}

Widget getLikes(icon, count, size, RxBool like,int vidID,BuildContext context) {
  return Obx((){
    return Column(
      children: [
        InkWell(
            onTap: () async {
              var cusID = CacheManager.instance.get('login', 0);
              Results result = await HomeService.instance.addLike(cusId: cusID,vidId: vidID);
              if(result.access!){
                like.value = !like.value;
                count +=1;
              }else{
                Results results = await HomeService.instance.disLike(cusId: cusID,vidId: vidID);
                if(results.access!){
                  like.value = !like.value;
                  count -=1;
                }else{
                  MyDialog.instance.dialogOK(context, "Can't like", "");
                }
              }
              // like.value = !like.value;
              // if(like.value){
              //   count +=1;
              // }else{
              //   count -=1;
              // }
              print("LIKE: $like");
            },
            child: Icon(icon, color: !like.value?ConstColor.white:Colors.pink, size: size)),
        const SizedBox(
          height: 5,
        ),
        Text(
          count.toString(),
          style: const TextStyle(
              color: ConstColor.white, fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ],
    );
  });
}
Widget getComments(icon, count, size, Function? onTap,) {
  return Column(
    children: [
      InkWell(
          onTap: ()=>onTap,
          child: Icon(icon, color: ConstColor.white, size: size)),
      const SizedBox(
        height: 5,
      ),
      Text(
        count,
        style: const TextStyle(
            color: ConstColor.white, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    ],
  );
}
Widget getShare(icon, count, size) {
  return Column(
    children: [
      InkWell(
          onTap: ()async{
            await FlutterShare.share(
                title: 'Tiktok share',
                text: 'Example share text',
                linkUrl: 'https://www.facebook.com/',
                chooserTitle: 'Example Chooser Title'
            );
          },
          child: Icon(icon, color: ConstColor.white, size: size)),
      const SizedBox(
        height: 5,
      ),
      Text(
        count,
        style: const TextStyle(
            color: ConstColor.white, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    ],
  );
}

Widget getProfile(img) {
  return SizedBox(
    width: 50,
    height: 60,
    child: Stack(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: ConstColor.white),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      img),
                  fit: BoxFit.cover)),
        ),
        Positioned(
            bottom: 3,
            left: 18,
            child: Container(
              width: 20,
              height: 20,
              decoration:
              const BoxDecoration(shape: BoxShape.circle, color: ConstColor.primary),
              child: const Center(
                  child: Icon(
                    Icons.add,
                    color: ConstColor.white,
                    size: 15,
                  )),
            )),
      ],
    ),
  );
}