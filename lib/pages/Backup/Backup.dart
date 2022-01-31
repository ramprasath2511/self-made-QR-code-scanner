import 'dart:io';
import 'dart:typed_data';
import 'package:doctor_appointment_booking/components/Text%20setting.dart';
import 'package:doctor_appointment_booking/database/Database.dart';
import 'package:doctor_appointment_booking/model/backup_email_provider.dart';
import 'package:doctor_appointment_booking/utils/Utils.dart';
import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class ExampleViewModel {
  final List<Color> pageColors;
  final CircularSliderAppearance appearance;
  final double min;
  final double max;
  final double value;
  final InnerWidget innerWidget;

  ExampleViewModel(
      {@required this.pageColors,
      @required this.appearance,
      this.min = 0,
      this.max = 100,
      this.value = 50,
      this.innerWidget});
}

class ExamplePage extends StatelessWidget {
  final ExampleViewModel viewModel;

  const ExamplePage({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_sharp),
                  onPressed: () => Navigator.pop(context, false),
                ),
                SizedBox(
                  width: 30,
                ),
                headerText("Backup"),
              ]),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Your Complete Data Will get backed up in your email'),
                Consumer<EmailProvider>(builder: (context, data, child) {
                  return Text(
                    '${data.email != null ? data.email : ""}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  );
                }),
                SizedBox(
                  height: 30,
                ),
                headerText("Start"),
              ]),
        ),
        SafeArea(
          child: Center(
              child: SleekCircularSlider(
            onChangeStart: (double value) {},
            onChangeEnd: (double value) {},
            innerWidget: viewModel.innerWidget,
            appearance: viewModel.appearance,
            min: viewModel.min,
            max: viewModel.max,
            initialValue: viewModel.value,
          )),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      onPressed: () =>
                          _onAlertWithCustomContentPressed2(context),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      color: kColorPrimary,
                      splashColor: kColorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Restore',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () =>
                          _onAlertWithCustomContentPressed(context),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      color: kColorPrimary,
                      splashColor: kColorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Backup',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ]),
    ));
  }
}

bool dataShare = false;

doBackupProcess(context) async {

  await DBProvider.db.disablePragma();

  var databasesPath = await getDatabasesPath();
  String dbFilePath = path.join(databasesPath, 'QRKnowDB.db');
  // Directory documentsDirectory = await getApplicationDocumentsDirectory();
  // String dbFilePath = path.join(documentsDirectory.path, "QRKnowDB.db");
  File databaseFile = new File(dbFilePath);
  print("Done!!!===>$dbFilePath");

  if (Platform.isAndroid) {
    String savedPath = await Utils.getSavedDatabaseFile();

    if (await File(savedPath).exists()) {
      await File(savedPath).delete();
    }

    File savedFile =
        await saveFile(path: savedPath, databaseFile: databaseFile);
    if (await File(savedFile.path).exists()) {
      print('savedFile found');
    }
  }

  dataShare = await shareFile(dbFilePath);

  dataShare
      ? Alert(
          context: context,
          image: Image(
            image: AssetImage('assets/images/1787-clear.gif'),
          ),
          title: "Select Restore backup",
          content: Column(
            children: <Widget>[],
          ),
          buttons: [
              DialogButton(
                color: kColorPrimary,
                onPressed: () => {
                  Navigator.pop(context),
                  dataShare = false,
                },
                child: Text(
                  "Okay",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ]).show()
      : Container();
}

_onAlertWithCustomContentPressed(context) async {
  var status = await Permission.storage.status;
  if (status != PermissionStatus.granted) {
    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    } else {
      if (await Permission.storage.request().isGranted) {
        doBackupProcess(context);
      }
    }
  } else {
    doBackupProcess(context);
  }
}

Future<File> saveFile(
    {String path = "",
    File databaseFile,
    Duration delay: const Duration(milliseconds: 20)}) {
  return new Future.delayed(delay, () async {
    try {
      Uint8List bytes = databaseFile.readAsBytesSync();
      if (path == "") {
        final directory = (await getApplicationDocumentsDirectory()).path;
        String fileName = DateTime.now().toIso8601String();
        path = '$directory/$fileName.png';
      }
      File imgFile = new File(path);
      await imgFile.writeAsBytes(bytes).then((onValue) {
        print("imgFile is :-->>>>${imgFile.path}");
      });
      return imgFile;
    } catch (Exception) {
      throw (Exception);
    }
  });
}

Future<bool> shareFile(String path) async {
  if (path == null || path.isEmpty) return false;

  dataShare = await FlutterShare.shareFile(
    title: 'Share DataBase File',
    filePath: path,
  );
  return dataShare;
}

doRestoreProcess(context) async {
  var databasesPath = await getDatabasesPath();
  String dbFilepath = path.join(databasesPath, 'QRKnowDB.db');
  // Directory documentsDirectory = await getApplicationDocumentsDirectory();
  // String dbFilepath = path.join(documentsDirectory.path, "QRKnowDB.db");
  print("File Path===>>$dbFilepath");

  FilePickerResult result = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );

  PlatformFile platformFile = result.files.first;
  print(result.files.first.path);

  if (result != null && platformFile.extension == "db") {
    await DBProvider.db.deleteLocalDatabase();
    DBProvider.db.setDataBase = null;
    try {
      var file = File(result.files.first.path);
      await file.copy(dbFilepath);
      await DBProvider.db.initDB();
      await DBProvider.db.database;
    } catch (e) {
      print('restoreDataCheck error: $e');
    }

    Alert(
        context: context,
        image: Image(
          image: AssetImage('assets/images/39261-data-back-up.gif'),
        ),
        title: "Your backup has completed successfully",
        content: Column(
          children: <Widget>[],
        ),
        buttons: [
          DialogButton(
            color: kColorPrimary,
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  } else {
    // User canceled the picker
    Alert(
      context: context,
      title: "Please Select Appropriate File",
      buttons: [
        DialogButton(
          color: kColorPrimary,
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
    print("hello");
  }
}

_onAlertWithCustomContentPressed2(context) async {
  var status = await Permission.storage.status;
  if (status != PermissionStatus.granted) {
    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    } else {
      if (await Permission.storage.request().isGranted) {
        doRestoreProcess(context);
      }
    }
  } else {
    doRestoreProcess(context);
  }
}
