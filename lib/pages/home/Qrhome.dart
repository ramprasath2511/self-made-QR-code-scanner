import 'package:doctor_appointment_booking/blocs/DatabaseBloc.dart';
import 'package:doctor_appointment_booking/blocs/secrete_code_bloc.dart';
import 'package:doctor_appointment_booking/model/qr_data.dart';
import 'package:doctor_appointment_booking/model/secrete_code_data.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/pages/Detailsadd/detailsadd.dart';
import 'package:doctor_appointment_booking/pages/Detailscreen/Details.dart';
import 'package:doctor_appointment_booking/utils/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  var qrText = '';
  final bloc = QRDataBloc();
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isScanned = false;

  @override
  void initState() {
    //getDbList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Stack(children: <Widget>[
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).padding.horizontal + 130,
                      vertical: 50),
                  child: Container(
                    height: 60,
                    width: 210,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        highlightColor: Colors.transparent,
                        onTap: () => _launchURL(),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFe84c0f),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              'Get Stickers',
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
              ])),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code;

        if(qrText!= null)
          {
            print("QR TO MATCH ${qrText.split("-")[0]}");
            getAllSecreteCodes(qrText.split("-")[0],qrText);
          //  Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetails(),));
          }
      });
    });
  }

  SecreteCodeBloc _bloc;
  SecreteCodeModel _secreteCodeModel;
  List<Data> _secreteCodeList = new List();
  void getAllSecreteCodes(String qrText, String qrCode) async{
    _bloc = new SecreteCodeBloc();
    _bloc.chuckListStream.listen((onData) {
      _secreteCodeModel = onData.data;
      //print(onData.status);
      if (onData.status == Status.LOADING) {
        // _playAnimation();
      } else if (onData.status == Status.COMPLETED) {
        if (_secreteCodeModel.success == 1) {


          if(!isScanned)
            {
              setState(() {
                _secreteCodeList.addAll(_secreteCodeModel.data);
                var product = _secreteCodeList.firstWhere((element) => element.name == qrText, orElse: () => null);

                if (product == null) {
                  isScanned = false;
                  CommonMethod.showToast(context, "QR Code is not valid");
                }
                else
                {
                  getDbList(qrText, qrCode, product);
                  isScanned = true;
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetails(qrData: product,qrCode: qrCode,),));
                }
                //  if(qrText)

              });
            }

        } else {
          // CommonMethod.showToast(context, _googleSignInModel.msg);

        }
      } else if (onData.status == Status.ERROR) {
        setState(() {
         // secreteCodeCalled = true;
        });
      }
    });
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getDbList(String qrText, String qrCode, Data product) async{
    print("ssdsdsdsds");
    QRData data =await bloc.checkQrCode(qrCode);
    List<QRData> data2 = [data];
    if(data!=null)
      {
        CommonMethod.showToast(context, "QrCode already exists");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(data: data2,from: "d",index: 0,)),
        );
      }
    else{

      Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetails(qrData: product,qrCode: qrCode,from: "add",),));
    }
    print("DAtta ${data}");

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
