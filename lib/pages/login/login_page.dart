import 'dart:async';
import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:doctor_appointment_booking/blocs/google_sign_in_bloc.dart';
import 'package:doctor_appointment_booking/blocs/login_bloc.dart';
import 'package:doctor_appointment_booking/components/Text%20setting.dart';
import 'package:doctor_appointment_booking/database/Database.dart';
import 'package:doctor_appointment_booking/model/GoogleSignInModel.dart';
import 'package:doctor_appointment_booking/model/backup_email_provider.dart';
import 'package:doctor_appointment_booking/model/login_model.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/pages/Forgot%20password/forgot%20password.dart';
import 'package:doctor_appointment_booking/pages/home/home.dart';
import 'package:doctor_appointment_booking/pages/signup/signup_page.dart';
import 'package:doctor_appointment_booking/utils/common_methods.dart';
import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sqflite/sqflite.dart';

import 'google.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => new LoginScreenState();
}

final TextEditingController _email_controller = new TextEditingController();
final TextEditingController _password_controller = new TextEditingController();

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus = 0;
  LoginBloc _bloc;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    if (Platform.isIOS) {
      //check for ios if developing for both android & ios
      AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      });
    }
  }

  /* @override
  void dispose() {
    _loginButtonController.dispose();
    _email_controller.dispose();
    _password_controller.dispose();
    super.dispose();
  }*/

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (_) => new AlertDialog(
            title: new Text('Are you sure you want to exit?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => SystemNavigator.pop(),
                //Navigator.pushReplacementNamed(context, "/home"),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          body: new Container(
            child: new Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child: ListView(
                // padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  new Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      new Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 250.0,
                            height: 250.0,
                            alignment: Alignment.center,
                            child: Image.asset('assets/images/logoo.png'),
                          ),
                          Container(
                            margin: new EdgeInsets.symmetric(horizontal: 0.0),
                            child: new Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Form(
                                    child: new Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 5.0),
                                        child: new TextFormField(
                                          textInputAction:
                                              TextInputAction.next,
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                          obscureText: false,
                                          controller: _email_controller,
                                          decoration: new InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Icon(
                                                Icons.person_outline,
                                                color: Colors.grey,
                                              ), // icon is 48px widget.
                                            ),
                                            labelText: "Email-Id",
                                            labelStyle: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                            enabledBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFe84c0f)),
                                            ),
                                            focusedBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFe84c0f)),
                                            ),
                                            enabled: true,
                                            filled: false,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        )),
                                    new Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: new TextFormField(
                                          textInputAction:
                                              TextInputAction.done,
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                          obscureText: true,
                                          controller: _password_controller,
                                          decoration: new InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Icon(
                                                Icons.lock_outline,
                                                color: Colors.grey,
                                              ), // icon is 48px widget.
                                            ),
                                            labelText: "Password*",
                                            labelStyle: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                            enabledBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFe84c0f)),
                                            ),
                                            focusedBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFe84c0f)),
                                            ),
                                            enabled: true,
                                            filled: false,
                                          ),
                                          keyboardType: TextInputType.text,
                                        )),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  child: InkWell(
                                    child: subHeadingText('Forgot Password?'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetPasswordPage()),
                                      );
                                    },
                                  ))
                            ],
                          ),
                          new SignUp()
                        ],
                      ),
                      animationStatus == 0
                          ? new Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: new InkWell(
                                  onTap: () {
                                    if (isvalidated(context)) {
                                      callLoginAPI();
                                      setState(() {
                                        animationStatus = 1;
                                      });
                                      // _playAnimation();

                                    }
                                  },
                                  child: new SignIn()),
                            )
                          : /*new StaggerAnimation(
                                  buttonController:
                                      _loginButtonController.view)*/
                          Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: circularProgress(),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Platform.isIOS ? _appleUI() : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  GoogleSignInButton(
                      onPressed: () async {
                        signInWithGoogle().then((FirebaseUser user) {
                          // model.clearAllModels();
                        }).catchError((e) => print(e));
                      },
                      darkMode: true),
                ],
              ),
            ),
          ),
        )));
  }

  //
  // Widget appleSignIN() {
  //   // return AppleSignInButton(
  //   //   //style: ButtonStyle.black,
  //   //   onPressed: createAppleLogIn,
  //   // );
  // }

  Map<String, String> bodyData;
  LoginModel _loginModel;

  void callLoginAPI() {
    bodyData = {
      "email": _email_controller.text.toString(),
      "password": _password_controller.text.toString()
    };
    _bloc = new LoginBloc(bodyData);
    _bloc.chuckListStream.listen((onData) {
      _loginModel = onData.data;
      //print(onData.status);
      if (onData.status == Status.LOADING) {
        // _playAnimation();
      } else if (onData.status == Status.COMPLETED) {
        if (_loginModel.success == 1) {
          CommonMethod.setPreference(context, "name", _loginModel.data.name);
          CommonMethod.setPreference(context, "email", _loginModel.data.email);
          CommonMethod.setPreference(
              context, "mobile", _loginModel.data.mobile);
          CommonMethod.setPreference(context, "id", _loginModel.data.id);
          var transactionType =
              Provider.of<EmailProvider>(context, listen: false);
          transactionType.setProfileImage(_loginModel.data.profilePic);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
          goToHome();
        } else {
          CommonMethod.showToast(context, _loginModel.msg);
          setState(() {
            animationStatus = 0;
          });
        }
      } else if (onData.status == Status.ERROR) {}
    });
  }

  Future<FirebaseUser> signInWithGoogle() async {
    // model.state =ViewState.Busy;

    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    AuthResult authResult = await _auth.signInWithCredential(credential);

    print("Token ${googleSignInAuthentication.accessToken}");
    _user = authResult.user;

    assert(!_user.isAnonymous);

    assert(await _user.getIdToken() != null);

    FirebaseUser currentUser = await _auth.currentUser();

    assert(_user.uid == currentUser.uid);

    //model.state =ViewState.Idle;
    callGoogleSignInAPI(
        googleSignInAuthentication.accessToken, _user.displayName);
    print("User Name: ${_user.displayName}");
    print("User Email ${_user.uid}");
    // if(Platform.version == "28"){
    //   var databasesPath = await getDatabasesPath();
    //   String dbFilepath = path.join(databasesPath, 'QRKnowDB.db');
    //   await DBProvider.db.deleteLocalDatabase();
    //   DBProvider.db.setDataBase = null;
    //   try {
    //     var file = File("QRKnowDB.db");
    //     await file.copy(dbFilepath);
    //     await DBProvider.db.initDB();
    //     await DBProvider.db.database;
    //   } catch (e) {
    //     print('restoreDataCheck error: $e');
    //   }
    // }
  }

  GoogleSignInBloc _googleSignInBloc;
  GoogleSignInModel _googleSignInModel;

  callGoogleSignInAPI(String accessToken, String displayName) {
    bodyData = {"google_token": accessToken, "name": displayName};
    _googleSignInBloc = new GoogleSignInBloc(bodyData);
    _googleSignInBloc.chuckListStream.listen((onData) {
      _googleSignInModel = onData.data;
      //print(onData.status);
      if (onData.status == Status.LOADING) {
        // _playAnimation();
      } else if (onData.status == Status.COMPLETED) {
        if (_googleSignInModel.success == 1) {
          CommonMethod.setPreference(
              context, "name", _googleSignInModel.data.name);
          CommonMethod.setPreference(
              context, "mobile", _googleSignInModel.data.mobile);
          CommonMethod.setPreference(
              context, "email", _googleSignInModel.data.email);
          CommonMethod.setPreference(context, "id", _googleSignInModel.data.id);
          //  Navigator.of(context).pushReplacementNamed(Routes.home);

          goToHome();
        } else {
          CommonMethod.showToast(context, _googleSignInModel.msg);
        }
      } else if (onData.status == Status.ERROR) {}
    });
  }

  goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
      (route) => false,
    );
  }

  Widget _appleUI() {
    return AppleSignInButton(
      onPressed: () => createAppleLogIn(),
    );
  }

  createAppleLogIn() async {
    if (await AppleSignIn.isAvailable()) {
      final AuthorizationResult result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);
      switch (result.status) {
        case AuthorizationStatus.authorized:
          CommonMethod.setPreference(
              context, "AppleUser", result.credential.user);
          print(
              "====>>>>>${result.credential.user} && ${result.credential.fullName.nameSuffix} && ${result.credential.fullName.namePrefix}");
          goToHome();
          print(
              "=========>>>>>${result.credential.user} ${result.credential.authorizationCode}"); //// All the required credentials
          break;
        case AuthorizationStatus.error:
          print("Sign in failed: ${result.error.localizedDescription}");
          break;
        case AuthorizationStatus.cancelled:
          print('User cancelled');
          break;
      }
    }
  }
}

Widget circularProgress() {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFe84c0f),
    ),
    child: CircularProgressIndicator(
      backgroundColor: Colors.white,
    ),
  );
}

bool isvalidated(BuildContext context) {
  if ((_email_controller.value.text.toString().trim().length == 0)) {
    _onValidationAlert(context, "Please enter Email-Id !");
    return false;
  }

  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(_email_controller.text)) {
    _onValidationAlert(context, "Please enter valid Email-Id!");
    return false;
  }
  if ((_password_controller.value.text.toString().trim().length == 0)) {
    _onValidationAlert(context, "Please enter Password !");
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

class SignUp extends StatelessWidget {
//  SignUp();
  @override
  Widget build(BuildContext context) {
    return (new FlatButton(
      padding: const EdgeInsets.only(
        top: 160.0,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      },
      child: Text(
        "Don't have an account? Register Now",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: Colors.black,
            fontSize: 15.0),
      ),
    ));
  }
}

class SignIn extends StatelessWidget {
  // SignIn();

  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: 320.0,
      height: 60.0,
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: Color(0xFFe84c0f),
        borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
      ),
      child: new Text(
        "Sign In",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
        ),
      ),
    ));
  }
}
