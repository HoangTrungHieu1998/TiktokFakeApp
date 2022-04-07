
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/ui/home/home.dart';
import 'package:flutter_tiktok/ultils/color.dart';
import 'package:flutter_tiktok/ultils/img.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
        splash: SizedBox(
          height: size.height,
          width: size.width,
          child: Image.asset(
              ConstImage.backgroundSplashScreen,
          ),
        ),
        backgroundColor: ConstColor.colorBg,
        animationDuration: const Duration(milliseconds: 200),
        pageTransitionType: PageTransitionType.rightToLeft,
        nextScreen: const Home());
  }
}
