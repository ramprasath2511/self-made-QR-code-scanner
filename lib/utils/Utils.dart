import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class Utils {
  static bool logEnabled = true;
  static bool tagEnabled = true;

  static void printLog(String tag, String message) {
    if (logEnabled) {
      if (tagEnabled) {
        if (tag == '_onAlertWithCustomContentPressed2') {
          print('$tag , $message');
        }
      } else {
        print('$tag , $message');
      }
    }
  }

  static Future<String> getSavedDatabaseFile() async {
    var storageDirectory;
    if (Platform.isAndroid) {
      storageDirectory = 'storage/emulated/0';
      Directory photosDirectory = Directory("$storageDirectory/BackupFiles");
      if (!await photosDirectory.exists()) {
        await photosDirectory.create();
        print("photosDirectory Done!!!===>$photosDirectory");
      }
      var savedPath = '${photosDirectory.path}/QRKnowDB.db';
      print(" savedPath Done!!!===>$savedPath");
      return savedPath;
    }

  }

}
