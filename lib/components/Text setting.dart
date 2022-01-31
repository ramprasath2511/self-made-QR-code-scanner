import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

Text headerText(var text) {
  return Text(text,
      maxLines: 2,
      style: TextStyle(
          fontStyle: FontStyle.normal,
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 32));
}

Text subHeadingText(var text) {
  return Text(
    text,
    style: TextStyle(
        fontStyle: FontStyle.normal, fontSize: 17.5, color: Colors.black),
  );
}

Widget hinttext(var text,
    {var fontSize = 18,
    textColor = Colors.black45,
    var fontFamily,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: maxLine,
      style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          height: 1.5,
          letterSpacing: latterSpacing));
}

class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var maxLine;
  TextEditingController mController;

  VoidCallback onPressed;

  EditText(
      {var this.fontSize = textSizeNormal,
      var this.textColor = Colors.black,
      var this.fontFamily = fontRegular,
      var this.isPassword = true,
      var this.isSecure = false,
      var this.text = "",
      var this.mController,
      var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: Colors.black45,
        maxLines: widget.maxLine,
        style: TextStyle(
            fontSize: widget.fontSize,
            color: Colors.black,
            fontFamily: widget.fontFamily),
      );
    } else {
      return TextField(
          controller: widget.mController,
          obscureText: widget.isPassword,
          cursorColor: Colors.black45,
          style: TextStyle(
              fontSize: widget.fontSize,
              color: Colors.black,
              fontFamily: widget.fontFamily),
          decoration: new InputDecoration(
            suffixIcon: new GestureDetector(
              onTap: () {
                setState(() {
                  widget.isPassword = !widget.isPassword;
                });
              },
              child: new Icon(
                  widget.isPassword ? Icons.visibility : Icons.visibility_off),
            ),
          ));
    }
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

/*fonts*/
const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';
/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 30.0;

class AppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  AppButton({@required this.textContent, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return AppButtonState();
  }
}

class AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: widget.onPressed,
        textColor: Colors.white,
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFe84c0f),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        useWhiteForeground(color));
  } on Exception catch (e) {
    print(e);
  }
}
