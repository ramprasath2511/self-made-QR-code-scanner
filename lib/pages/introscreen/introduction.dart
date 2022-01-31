import 'package:doctor_appointment_booking/components/Text%20setting.dart';
import 'package:doctor_appointment_booking/pages/login/login_page.dart';
import 'package:doctor_appointment_booking/pages/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import '../login/loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus = 0;

  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
        body: new Container(
            child: new ListView(
      padding: const EdgeInsets.all(0.0),
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                alignment: Alignment.center,
                child: Image.asset('assets/images/logoo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2.4),
                      child: Container(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Discover your new scanner',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )))
                ],
              ),
            ])
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                alignment: AlignmentDirectional.bottomCenter,
                child: new Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: new InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: new SignIn()),
                )),
            Container(
                alignment: AlignmentDirectional.bottomCenter,
                child: new Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: new InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: new SignUpbutton()),
                )),
            Container(
                alignment: AlignmentDirectional.bottomCenter,
                child: new Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: new InkWell(
                      onTap: () => _launchURL(), child: new Order()),
                ))
          ],
        ),
      ],
    )));
  }
}

class SignUp extends StatelessWidget {
  SignUp();

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
  SignIn();

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

class SignUpbutton extends StatelessWidget {
  SignUpbutton();

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
        "Sign Up",
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

class Order extends StatelessWidget {
  Order();

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
        "Get Stickers",
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

_launchURL() async {
  const url = 'https://www.amazon.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
