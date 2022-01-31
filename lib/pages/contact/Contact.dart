import 'dart:async';
import 'dart:io';
import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'bottom_curve_painter.dart';

class Contact extends StatefulWidget {
  @override
  _contactState createState() => new _contactState();
}

class _contactState extends State<Contact> {
  List<String> attachment = <String>[];
  final TextEditingController _subjectController =
      TextEditingController(text: 'Mail from Customer');
  final TextEditingController _bodyController = TextEditingController(text: '');
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> send() async {
    if (Platform.isIOS) {
      final bool canSend = await FlutterMailer.canSendMail();
      if (!canSend) {
        const SnackBar snackbar =
            const SnackBar(content: Text('no Email App Available'));
        _scafoldKey.currentState.showSnackBar(snackbar);
        return;
      }
    }

    // Platform messages may fail, so we use a try/catch PlatformException.
    final MailOptions mailOptions = MailOptions(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: <String>['contact@sataware.com'],
      isHTML: true,
      // bccRecipients: ['other@example.com'],
      ccRecipients: <String>['contact@sataware.com'],
      attachments: attachment,
    );

    String platformResponse;

    try {
      await FlutterMailer.send(mailOptions);
      platformResponse = 'success';
    } on PlatformException catch (error) {
      platformResponse = error.toString();
      print(error);
      if (!mounted) {
        return;
      }
      await showDialog<void>(
          context: _scafoldKey.currentContext,
          builder: (BuildContext context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Message',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(error.message),
                  ],
                ),
                contentPadding: const EdgeInsets.all(26),
                title: Text(error.code),
              ));
    } catch (error) {
      platformResponse = error.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }
    _scafoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Widget imagePath = Column(
        children: attachment.map((String file) => Text('$file')).toList());

    return Scaffold(
      key: _scafoldKey,
      appBar: new AppBar(
        backgroundColor: Theme.of(context).hintColor,
        title: const Text(
          'Send Queries',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: const Icon(Icons.send),
            color: Colors.white,
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
              clipper: BottomShapeClipper(),
              child: Container(
                color: kColorPrimary,
              )),
          SingleChildScrollView(
            child: new Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: TextField(
                        controller: _subjectController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.black)),
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                bottom: 10.0, left: 10.0, right: 10.0),
                            labelText: 'Subject',
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _bodyController,
                        maxLines: 15,
                        decoration: const InputDecoration(
                          hintText: 'Type your queries here',
                          hintStyle: TextStyle(fontSize: 15, height: 4),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.black)),
                          filled: true,
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                          labelText: 'Message',
                          labelStyle: TextStyle(color: Colors.black),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                    imagePath,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).hintColor,
        icon: const Icon(Icons.camera),
        label: const Text('Add Image'),
        onPressed: _picker,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _picker() async {
    final File pick = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      attachment.add(pick.path);
    });
  }

  /// create a text file in Temporary Directory to share.
  void _onCreateFile(BuildContext context) async {
    final TempFile tempFile = await _showDialog(context);
    final File newFile = await writeFile(tempFile.content, tempFile.name);
    setState(() {
      attachment.add(newFile.path);
    });
  }

  /// some A simple dialog and return fileName and content
  Future<TempFile> _showDialog(BuildContext context) {
    return showDialog<TempFile>(
      context: context,
      builder: (BuildContext context) {
        String content = '';
        String fileName = '';

        return SimpleDialog(
          title: const Text('write something to a file'),
          contentPadding: const EdgeInsets.all(8.0),
          children: <Widget>[
            TextField(
              onChanged: (String str) => fileName = str,
              autofocus: true,
              decoration: const InputDecoration(
                  suffix: const Text('.txt'), labelText: 'file name'),
            ),
            TextField(
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Content',
              ),
              onChanged: (String str) => content = str,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: const Icon(Icons.save),
                  onPressed: () {
                    final TempFile tempFile =
                        TempFile(content: content, name: fileName);
                    // Map.from({'content': content, 'fileName': fileName});
                    Navigator.of(context).pop<TempFile>(tempFile);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<String> get _localPath async {
    final Directory directory = await getTemporaryDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final String path = await _localPath;
    return File('$path/$fileName.txt');
  }

  Future<File> writeFile(String text, [String fileName = '']) async {
    fileName = fileName.isNotEmpty ? fileName : 'fileName';
    final File file = await _localFile(fileName);

    // Write the file
    return file.writeAsString('$text');
  }
}

class TempFile {
  TempFile({this.name, this.content});

  final String name, content;
}
