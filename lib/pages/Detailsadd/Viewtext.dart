import 'package:doctor_appointment_booking/model/qr_data.dart';
import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment_booking/blocs/DatabaseBloc.dart';

class ViewText extends StatefulWidget {
  List<QRData> data;
  ViewText({@required this.data});
  @override
  _ViewTextState createState() => _ViewTextState();
}

class _ViewTextState extends State<ViewText> {
  String listOfTempNotes2;
  List<String> tempList = [];
  final bloc = QRDataBloc();

  void fetchData() async {

    List<QRData> data = await bloc.getAllData();

    setState(() {

      int number = data.length ?? 0;
      for(int i=0; i<number; i++) {
        print("i +> $i");
        tempList.add(data[i]?.listNotes ?? "");
      }
      listOfTempNotes2 = tempList.join(",");
    });

  }


  @override
  void initState(){

    // TODO: implement initState
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {

    String listOfTempNotes = widget.data?.first?.listNotes ?? "";
    print("listOfTempNotes => $listOfTempNotes");
    List<String> result = (listOfTempNotes2?.isNotEmpty ?? false) ? listOfTempNotes2.split(',') : [];
    result = result.toSet().toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Text',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, top: 20),
          child: (result?.length ?? 0) != 0 ? Column(
            children: <Widget>[
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: result?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: kColorPrimary,
                                radius: 30,
                                child: Icon(Icons.history_rounded,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                    '${result[index]}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              FlatButton(
                                onPressed: () {

                                  Navigator.pop(context, '${result[index]}');

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ViewText(data:widget.data,)),
                                  // );
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                color: kColorPrimary,
                                splashColor: kColorPrimary,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'select',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ],
          ) : Center(child: Text("No saved text!", style: TextStyle(fontSize: 25),),),
        ),
      ),
    );
  }
}
