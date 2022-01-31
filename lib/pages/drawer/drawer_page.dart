import 'package:doctor_appointment_booking/components/Text%20setting.dart';
import 'package:doctor_appointment_booking/model/backup_email_provider.dart';
import 'package:doctor_appointment_booking/pages/Backup/circular%20indicator.dart';
import 'package:doctor_appointment_booking/pages/Detailsadd/detailsadd.dart';
import 'package:doctor_appointment_booking/pages/History/historyscreen.dart';
import 'package:doctor_appointment_booking/pages/home/home.dart';
import 'package:doctor_appointment_booking/pages/profile/profilescreen.dart';
import 'package:doctor_appointment_booking/pages/terms_and_conditions/Privacy_policy.dart';
import 'package:doctor_appointment_booking/pages/terms_and_conditions/terms%20and%20conditions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/routes.dart';
import '../../utils/constants.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../Backup/Backup.dart';
import 'dart:io';

class DrawerPage extends StatelessWidget {
  final Function onTap;
  final String name, networkImage;

  const DrawerPage(
      {Key key, @required this.onTap, this.name, this.networkImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String subject =
        'Hi there, I hope Qr know app will be helpful for you. Here is the link to install Qr know app: www.example.com Stay Safe!';
    String text =
        'Hi there, I hope Qr know app will be helpful for you. Here is the link to install Qr know app: www.example.com Stay Safe!';
    return GestureDetector(
      onTap: onTap,
      child: Scaffold(
        backgroundColor: kColorPrimary,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 35, horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Consumer<EmailProvider>(
                            builder: (context, data, child) {
                          return
                              // !Platform.isIOS?
                              CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey,
                            backgroundImage: data.profileImage != null &&
                                    data.profileImage != ""
                                ? NetworkImage(data.profileImage)
                                : AssetImage(
                                    'assets/images/220px-Matthew_Perry_as_Chandler_Bing.png',
                                  ),
                          );
                          // :Container();
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        // !Platform.isIOS ?
                        name != null
                            ? Text("$name",
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  fontFamily: 'Literata',
                                ))
                            : Text("Apple User",
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  fontFamily: 'Literata',
                                )),
                        // :Container(),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _drawerItem(
                      image: 'home',
                      text: 'Home',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      }),
                  _drawerItem(
                      image: 'backup',
                      text: 'Back-up',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Backup()),
                        );
                      }),
                  _drawerItem(
                      image: 'history',
                      text: 'History',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => History()),
                        );
                      }),
                  _drawerItem(
                      image: 'profile1',
                      text: 'Profile',
                      onTap: () {
                        /*_onAlertWithCustomContentPressed(context),*/
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => profile()),
                        );
                      } //Nearby app
                      ),
                  _drawerItem(
                    image: 'add',
                    text: 'Order more Stickers',
                    onTap: () => _launchURL(),
                    /*Navigator.of(context).pushNamed(Routes.selfmonitoring), */ //Self monitoring Screen
                  ),
                  _drawerItem(
                    image: 'invite',
                    text: 'Invite Friends',
                    onTap: () {
                      final RenderBox box = context.findRenderObject();
                      Share.share(text,
                          subject: subject,
                          sharePositionOrigin:
                              box.localToGlobal(Offset.zero) & box.size);
                    },
                  ),
                  _drawerItem(
                      image: 'i',
                      text: 'T&C',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Termsandcondition()),
                        );
                      }),
                  _drawerItem(
                      image: 'lock',
                      text: 'Privacy Policy',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicy()),
                        );
                      }),
                  _drawerItem(
                      image: 'logout',
                      text: 'Logout',
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.clear();
                        Navigator.of(context).pushNamed(Routes.login);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell _drawerItem({
    @required String image,
    @required String text,
    @required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
        //this.onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 65,
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/$image.png',
              color: Colors.white,
              height: 35,
              width: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

_onAlertWithCustomContentPressed(context) {
  Alert(
      context: context,
      image: Image(
        image: AssetImage('assets/images/Location.gif'),
      ),
      title: "Coming Soon",
      content: Column(
        children: <Widget>[],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

_onAlertWithCustomContentPress(context) {
  Alert(
      context: context,
      image: Image(
        image: AssetImage('assets/images/Coming soon.gif'),
      ),
      title: "Coming Soon",
      content: Column(
        children: <Widget>[],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: kColorPrimary,
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

_launchURL() async {
  const url = 'https://www.amazon.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
