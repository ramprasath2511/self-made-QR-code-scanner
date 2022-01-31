import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

final TextEditingController _emailController = TextEditingController();

class _ForgotPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password',
            style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 20)),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: ForgotUI(context),
    );
  }

  @override
  void initState() {
    setListners();

    super.initState();
  }

  void setListners() {
    _emailController.addListener(() {
      setState(() {
        ForgotUI(context);
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }
}

Widget ForgotUI(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 30, left: 40, right: 40),
    color: Colors.white,
    child: ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/images/logoo.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Forgot Password?",
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 32)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Enter your registered Email Id to Reset the password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: FlatButton(
                        child: Text(
                          "Enter",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          if (_isValidate(context)) {
                            _onAlertotp(context);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}

bool _isValidate(BuildContext context) {
  print("called ");
  print(_emailController.text);
  if (_emailController.text.isEmpty) {
    _onValidationAlert(context, "Please enter Email!");
    return false;
  }

  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(_emailController.text)) {
    _onValidationAlert(context, "Please enter valid Email!");
    return false;
  }

  return true;
}

_onAlertotp(context) {
  Alert(
      context: context,
      title: "Enter Your OTP",
      content: Column(
        children: <Widget>[
          OTPTextField(
            length: 5,
            width: MediaQuery.of(context).size.width / 2,
            fieldWidth: 40,
            style: TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              print("Completed: " + pin);
            },
          )
        ],
      ),
      buttons: [
        DialogButton(
          color: kColorPrimary,
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

_onValidationAlert(context, String s) {
  Alert(context: context, title: s, content: Column(), buttons: [
    DialogButton(
      color: kColorPrimary,
      onPressed: () => Navigator.pop(context),
      child: Text(
        "Ok",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    )
  ]).show();
}
