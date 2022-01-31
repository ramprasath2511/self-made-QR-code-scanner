/**
 * Author: Sudip Thapa
 * profile: https://github.com/sudeepthapa
 */

import 'dart:io';
import 'package:doctor_appointment_booking/model/qr_data.dart';
import 'package:doctor_appointment_booking/pages/Detailsadd/detailsadd.dart';
import 'package:doctor_appointment_booking/pages/History/historyscreen.dart';
import 'package:doctor_appointment_booking/pages/home/home.dart';
import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Details extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile7.dart";
  int index;
  List<QRData> data;
  String from;
  Details({@required this.data,this.from,this.index});

  @override
  Widget build(BuildContext context) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(data[index].dateTime,isUtc: false);
    var format = new DateFormat("dd-MM-yyyy");
    var dateString = format.format(date);
    return WillPopScope(
      onWillPop: (){
        if(from=="h")
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Details',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 32)),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddDetails(from: "edit",qrCode: data[index].qrCode,data: data,index: index)),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: kColorPrimary,
                    ),
                  )
                ],
              ),
            ],
          ),
          backgroundColor: Color(0xfff0f0f0),
          body: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(top: 20),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/qr.png',
                        ),
                        radius: 5,
                        backgroundColor: Colors.black,
                      )),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Text(
                    "${data[index].title}",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: kColorPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(
                    "${dateString}",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: kColorPrimary,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Card(
                        color: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                                '${data[index].note}',
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    height: 2)))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 55),
                    child: Container(
                      height: 48,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Theme.of(context).dividerColor,
                            blurRadius: 8,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          highlightColor: Colors.transparent,
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                color: Color(0xFFe84c0f),
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                'Save',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))),
    );
  }

  Future<bool> goBack() {

  }
}
