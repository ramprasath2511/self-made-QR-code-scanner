import 'package:doctor_appointment_booking/blocs/DatabaseBloc.dart';
import 'package:doctor_appointment_booking/components/Text%20setting.dart';
import 'package:doctor_appointment_booking/model/qr_data.dart';
import 'package:doctor_appointment_booking/model/secrete_code_data.dart';
import 'package:doctor_appointment_booking/pages/Detailsadd/Viewtext.dart';
import 'package:doctor_appointment_booking/pages/History/historyscreen.dart';
import 'package:doctor_appointment_booking/pages/home/home.dart';
import 'package:doctor_appointment_booking/pages/home/widgets/app_bar_title_widget.dart';
import 'package:doctor_appointment_booking/utils/common_methods.dart';
import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:flutter/material.dart';

const Color primary = Color(0xffE20056);
const TextStyle whiteBoldText = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const TextStyle whiteText = TextStyle(
  color: Colors.white,
);
const TextStyle primaryText = TextStyle(
  color: primary,
);

class AddDetails extends StatefulWidget {
  Data qrData;
  String qrCode, from;
  List<QRData> data;
  int index;

  AddDetails(
      {this.qrData, this.qrCode, @required this.from, this.data, this.index});

  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  static final String path = "lib/src/pages/invitation/inlanding.dart";
  bool valuefirst = false;
  String listOfTempNotes = "";
  final notesController = TextEditingController();
  final titleController = TextEditingController();
  final bloc = QRDataBloc();

  @override
  void initState() {
    print("DAAAAAA ${DateTime.now()}");
    if (widget.from == "edit") {
      notesController.text = widget.data[widget.index].note;
      titleController.text = widget.data[widget.index].title;
    } else {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: AppBarTitleWidget(),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60.0),
                        topLeft: Radius.circular(60.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0), //(x,y)
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  height: 750,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text('Add Details',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: kColorPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 30)),
                      SizedBox(height: 40),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Title(optional)',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: kColorPrimary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                SizedBox(height: 15),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1.2, color: Colors.black38)),
                                  child: TextField(
                                    controller: titleController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      color: kColorBlue,
                                    ),
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Title',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                /*Text('Created Date(optional)',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: kColorPrimary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                SizedBox(height: 15),
                                Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 100,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1.2,
                                                  color: Colors.black38)),
                                          child: TextField(
                                            keyboardType:
                                            TextInputType.datetime,
                                            style: TextStyle(
                                              color: kColorBlue,
                                            ),
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Date',
                                              hintStyle: TextStyle(

                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 100,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1.2,
                                                  color: Colors.black38)),
                                          child: TextField(
                                            keyboardType:
                                            TextInputType.datetime,
                                            style: TextStyle(
                                              color: kColorBlue,
                                            ),
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Month',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 100,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1.2,
                                                  color: Colors.black38)),
                                          child: TextField(
                                            keyboardType:
                                            TextInputType.datetime,
                                            style: TextStyle(
                                              color: kColorBlue,
                                            ),
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Year',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),*/
                                SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Notes(Required)',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: kColorPrimary,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20)),
                                      FlatButton(
                                        onPressed: () async {
                                          String result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewText(
                                                      data: widget.data,
                                                    )),
                                          );

                                          if (result?.isNotEmpty ?? false) {
                                            notesController.text = result;
                                          }
                                        },
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        color: kColorPrimary,
                                        splashColor: kColorPrimary,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'View Text',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]),
                                SizedBox(height: 15),
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1.2, color: Colors.black38)),
                                  child: TextField(
                                    controller: notesController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      color: kColorBlue,
                                    ),
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Notes',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
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
                                            subHeadingText('Save Text')
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 50),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: FlatButton(
                                    onPressed: () async {

                                      if(notesController.text.trim().length == 0){
                                         CommonMethod.showToast(context, "Please Enter Note");
                                        return;
                                      }

                                      if ((widget.data != null) && widget.data[widget.index].listNotes
                                          .contains(notesController.text)) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => History(),
                                            ));
                                      } else {
                                        int dt = new DateTime.now()
                                            .millisecondsSinceEpoch;
                                        if (widget.from == "add") {
                                          print("from====>from");
                                          listOfTempNotes = widget.data == null
                                              ? notesController.text
                                              : (widget.data[widget.index]
                                                      .listNotes +
                                                  "," +
                                                  notesController.text.trim());
                                          QRData data = new QRData(
                                              secreteId: widget.qrData.name,
                                              backUpDone: 0,
                                              updatedTime: dt,
                                              qrCode: widget.qrCode,
                                              dateTime: dt,
                                              note: notesController.text,
                                              title: titleController.text,
                                              saveText: valuefirst ? 0 : 1,
                                              listNotes: listOfTempNotes);
                                          bloc.add(data).whenComplete(
                                              () => Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        History(),
                                                  )));
                                        } else {
                                          print("from1====>from");

                                          // listOfNotes.add(notesController.text);
                                          listOfTempNotes =
                                              (widget.data == null)
                                                  ? notesController.text
                                                  : (widget.data[widget.index]
                                                          .listNotes +
                                                      "," +
                                                      notesController.text.trim());
                                          print("dddd");
                                          QRData data = new QRData(
                                              secreteId: widget
                                                  .data[widget.index].secreteId,
                                              backUpDone: 0,
                                              dateTime: widget
                                                  .data[widget.index].dateTime,
                                              updatedTime: dt,
                                              qrCode: widget.qrCode,
                                              note: notesController.text,
                                              title: titleController.text,
                                              saveText: valuefirst ? 0 : 1,
                                              id: widget.data[widget.index].id,
                                              listNotes: listOfTempNotes);
                                          bloc.updateQRData(data).whenComplete(
                                              () => Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        History(),
                                                  )));
                                        }
                                      }
                                    },
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    color: kColorPrimary,
                                    splashColor: kColorPrimary,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Save',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ])),
                    ],
                  ),
                ))));
  }
}
