import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog{
  MyDialog._();
  static final MyDialog instance = MyDialog._();

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Future<void> dialogOK(
      BuildContext context, String message, String title) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}