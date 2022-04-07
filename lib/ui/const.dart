import 'package:flutter/material.dart';
import 'package:flutter_tiktok/ultils/color.dart';

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

Widget getIcons(icon, count, size) {
  return Column(
    children: [
      Icon(icon, color: ConstColor.white, size: size),
      const SizedBox(
        height: 5,
      ),
      Text(
        count,
        style: const TextStyle(
            color: ConstColor.white, fontSize: 12, fontWeight: FontWeight.w700),
      )
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
            ))
      ],
    ),
  );
}