import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/service/cache_manager.dart';
import 'package:flutter_tiktok/ui/home/home_builder.dart';
import 'package:flutter_tiktok/ui/home/home_page.dart';
import 'package:flutter_tiktok/ui/profile/profile_builder.dart';
import 'package:flutter_tiktok/ui/profile/profile_page.dart';
import 'package:flutter_tiktok/ui/upload_icon.dart';
import 'package:flutter_tiktok/ultils/color.dart';
import 'package:flutter_tiktok/ultils/icon.dart';
import 'package:flutter_tiktok/ultils/size.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody(){
    return IndexedStack(
      index: pageIndex,
      children: [
        const HomeBuilder(),
        Center(
          child: Text("${CacheManager.instance.get('login', 0)}",style: TextStyle(
              color: ConstColor.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
        ),
        Center(
          child: Text("Upload",style: TextStyle(
              color: ConstColor.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
        ),
        Center(
          child: Text("All Activity",style: TextStyle(
              color: ConstColor.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
        ),
        const ProfileBuilder()
      ],
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    List bottomItems = [
      {"icon": TikTokIcons.home, "label": "Home", "isIcon": true},
      {"icon": TikTokIcons.search, "label": "Discover", "isIcon": true},
      {"icon": "", "label": "", "isIcon": false},
      {"icon": TikTokIcons.messages, "label": "Inbox", "isIcon": true},
      {"icon": TikTokIcons.profile, "label": "Profile", "isIcon": true}
    ];
    return Container(
      width: double.infinity,
      height: ConstSize.size80,
      decoration: const BoxDecoration(color: ConstColor.colorBg),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return bottomItems[index]['isIcon']?
            InkWell(
              onTap: (){
                selectPage(index);
              },
              child: Column(
                children: [
                  Icon(
                    bottomItems[index]['icon'],
                    color: ConstColor.colorText,
                  ),
                  const SizedBox(
                    height: ConstSize.size5,
                  ),
                  Text(
                    bottomItems[index]['label'],
                    style: const TextStyle(
                      color: ConstColor.colorText,
                    ),
                  )
                ],
              ),
            ):
            InkWell(
                onTap: (){
                  selectPage(index);
                },
                child: const UploadIcon());
        })),
      ),
    );
  }

  selectPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
