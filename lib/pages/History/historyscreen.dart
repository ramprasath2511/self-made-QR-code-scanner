import 'package:doctor_appointment_booking/blocs/DatabaseBloc.dart';
import 'package:doctor_appointment_booking/components/Text%20setting.dart';
import 'package:doctor_appointment_booking/database/Database.dart';
import 'package:doctor_appointment_booking/model/qr_data.dart';
import 'package:doctor_appointment_booking/pages/Detailscreen/Details.dart';
import 'package:doctor_appointment_booking/pages/home/home.dart';
import 'package:doctor_appointment_booking/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);
  static final String path = "lib/src/pages/lists/list2.dart";

  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  final bloc = QRDataBloc();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: goToHome,
        child: Scaffold(
          backgroundColor: Color(0xfff0f0f0),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 135),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: StreamBuilder(
                    stream: bloc.clients,
                    builder: (BuildContext context, AsyncSnapshot<List<QRData>> snapshot)
                    {
                      print("AsyncSnapshot<List<QRData>> ${snapshot.hasData}");
                      return snapshot.hasData?buildList(context,snapshot.data):Center(child: CircularProgressIndicator());
                    }
                      )),
                Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xfff0f0f0),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back_sharp),
                              onPressed: () =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),))
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            headerText("History"),
                          ]),
                    )),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Recently Scanned',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 32)),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, List<QRData> data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context,index)
      {
        print("Dat ${data[index].dateTime}");
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(data[index].dateTime,isUtc: false);
        var format = new DateFormat("dd-MM-yyyy");
        var dateString = format.format(date);
        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Details(data: data,from: "h",index: index,)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 110,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data[index].title,
                        style: TextStyle(
                            color: kColorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.history_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(dateString,
                              style: TextStyle(
                                  color: kColorPrimary,
                                  fontSize: 13,
                                  letterSpacing: .3)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> goToHome() {
    print("bacccck");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
  }
}
