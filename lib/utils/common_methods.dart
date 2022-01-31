import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonMethod
{
    static showToast(BuildContext context,String message)
    {
      Fluttertoast.showToast(msg: message,gravity: ToastGravity.BOTTOM,);
      print("QR SEARCH not valid");
    }

    static setPreference(BuildContext context ,String key,String val) async
    {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(key, val);
    }

    static showLoaderDialog(BuildContext context,String message){
      AlertDialog alert=
      AlertDialog(
        content: new Row(
          children: [
            CircularProgressIndicator(backgroundColor: Colors.blue,valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
            Container(margin: EdgeInsets.only(left: 7),child:Text(message)),
          ],),
      );
      showDialog(
        barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return WillPopScope(
            onWillPop: () {},
            child: alert,
          );
        },
      );
    }

    static dismissDialog(BuildContext context){
      Navigator.pop(context);

    }
}