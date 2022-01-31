
import 'package:doctor_appointment_booking/blocs/register_bloc.dart';
import 'package:doctor_appointment_booking/components/Text%20setting.dart';
import 'package:doctor_appointment_booking/model/register_model.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/pages/login/login_page.dart';
import 'package:doctor_appointment_booking/utils/common_methods.dart';
import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

final TextEditingController name_controller = new TextEditingController();
final TextEditingController password_controller = new TextEditingController();
final TextEditingController dobcontroller = new TextEditingController();
final TextEditingController email_controller = new TextEditingController();
final TextEditingController mobile_controller = new TextEditingController();
final TextEditingController re_password_controller =
    new TextEditingController();
String birthDateInString;

class SignUpState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  String initValue = "Select your Birth Date";
  bool isDateSelected = false;
  DateTime birthDate;
  bool valuefirst = false;
  bool valuesecond = false;
  bool registerCalled=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Map<String,String> bodyData;
  RegisterModel _registerModel;
  RegisterBloc _bloc;
  void callRegisterAPI() {
    bodyData ={
      "email": email_controller.text.toString(),
      "password": password_controller.text.toString(),
      "name": name_controller.text.toString(),
      // "mobile": mobile_controller.text.toString()
    };
    _bloc = new RegisterBloc(bodyData);
    _bloc.chuckListStream.listen((onData){
      _registerModel = onData.data;
      //print(onData.status);
      if(onData.status == Status.LOADING)
      {

      }
      else if(onData.status == Status.COMPLETED)
      {
        if(_registerModel.success==1)
        {
          CommonMethod.showToast(context, _registerModel.msg);
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
        }
        else
        {
          setState(() {
            registerCalled = false;
          });
          CommonMethod.showToast(context, _registerModel.msg);
        }

      }
      else if(onData.status == Status.ERROR)
      {
        setState(() {
          registerCalled = false;
        });

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        body: new ListView(
          shrinkWrap: true,
          reverse: false,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: new Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 0.0, bottom: 0.0, top: 0.0),
                              child: subHeadingText(
                                "SIGN UP",
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset(
                      "assets/images/logoo.png",
                      height: 180.0,
                      width: 220.0,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
                new Center(
                    child: new Center(
                  child: new Stack(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: new Form(
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: new TextFormField(
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                    controller: name_controller,
                                    decoration: new InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFe84c0f)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFe84c0f)),
                                      ),
                                      labelText: "Full Name*",
                                      labelStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                      filled: false,
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                new Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0, right: 10.0, top: 5.0),
                                    child: new TextFormField(
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                      obscureText: false,
                                      controller: email_controller,
                                      decoration: new InputDecoration(
                                        labelText: "Email-Id",
                                        labelStyle: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFe84c0f)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFe84c0f)),
                                        ),
                                        enabled: true,
                                        filled: false,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    )),
                                new Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 5.0),
                                    child: new TextFormField(
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                      obscureText: true,
                                      controller: password_controller,
                                      decoration: new InputDecoration(
                                        labelText: "Password*",
                                        labelStyle: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFe84c0f)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFe84c0f)),
                                        ),
                                        enabled: true,
                                        filled: false,
                                      ),
                                      keyboardType: TextInputType.text,
                                    )),
                                new Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 5.0),
                                    child: new TextFormField(
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                      obscureText: true,
                                      controller: re_password_controller,
                                      decoration: new InputDecoration(
                                        labelText: "Confirm Password*",
                                        labelStyle: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFe84c0f)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFe84c0f)),
                                        ),
                                        enabled: true,
                                        filled: false,
                                      ),
                                      keyboardType: TextInputType.text,
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1.2),
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            new Checkbox(
                                              checkColor: Colors.black,
                                              activeColor: Colors.red,
                                              value: this.valuefirst,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  this.valuefirst = value;
                                                });
                                              },
                                            ),
                                            subHeadingText(
                                                'Opt out of Mailing List')
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                registerCalled?CircularProgressIndicator(): new Padding(
                                  padding: EdgeInsets.only(
                                      left: 0.0, top: 45.0, bottom: 20.0),
                                  child: new RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      if (_isValidated(context)) {
                                        /*Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                        );*/
                                        setState(() {
                                          registerCalled =  true;
                                        });
                                        callRegisterAPI();
                                      }
                                    },
                                    child: new Text("SignUp ",
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                    color: Color(0xFFe84c0f),
                                    textColor: Colors.white,
                                    elevation: 5.0,
                                    padding: EdgeInsets.only(
                                        left: 80.0,
                                        right: 80.0,
                                        top: 15.0,
                                        bottom: 15.0),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ))
              ],
            )
          ],
        ));
  }
/*
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    name_controller.dispose();
    password_controller.dispose();
    email_controller.dispose();
    dobcontroller.dispose();
    re_password_controller.dispose();
    super.dispose();
  }*/
}



bool _isValidated(BuildContext context) {
  if ((name_controller.value.text
      .toString()
      .trim()
      .length == 0)) {
    _onValidationAlert(context, "Please enter Name !");
    return false;
  }
  if ((email_controller.value.text
      .toString()
      .trim()
      .length == 0)) {
    _onValidationAlert(context, "Please enter Email-Id !");
    return false;
  }



  if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email_controller.text)) {
    _onValidationAlert(context, "Please enter valid Email-Id!");
    return false;
  }
  // if ((mobile_controller.value.text
  //     .toString()
  //     .trim()
  //     .length == 0)) {
  //   _onValidationAlert(context, "Please enter mobile !");
  //   return false;
  // }
  // if ((mobile_controller.value.text
  //     .toString()
  //     .trim()
  //     .length < 10)) {
  //   _onValidationAlert(context, "Please enter valid mobile!");
  //   return false;
  // }

  // if (dobcontroller.text.length == 0) {
  //   _onValidationAlert(context, "Please choose Date of Birth !");
  //   return false;
  // }

  if ((password_controller.value.text
      .toString()
      .trim()
      .length == 0)) {
    _onValidationAlert(context, "Please enter password !");
    return false;
  }

  if ((re_password_controller.value.text
      .toString()
      .trim()
      .length == 0)) {
    _onValidationAlert(context, "Please enter confirm password !");
    return false;
  }

  if (password_controller.value.text.toString() !=
      re_password_controller.value.text.toString()) {
    _onValidationAlert(context, "Password & confirm password should be same !");
    return false;
  }

  return true;
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
