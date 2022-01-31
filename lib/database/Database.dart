import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:doctor_appointment_booking/model/backup_email_provider.dart';
import 'package:doctor_appointment_booking/model/qr_data.dart';
import 'package:doctor_appointment_booking/utils/GoogleAuthClient.dart';
import 'package:doctor_appointment_booking/utils/common_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  set setDataBase(Database tempDatabase) => _database =tempDatabase;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  int id;
  String title;
  String note;
  int dateTime;
  String qrCode;
  int saveText;
  Uint8List qrImage;
  int updatedTime;
  int backUpDone;

  initDB() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, "QRKnowDB.db");
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'QRKnowDB.db');
    // Platform.isAndroid ? await Directory(documentsDirectory.path +'/'+'QRKnowDB.db').create().then(((Directory directory) => print("#==>>>directorydirectory${directory.path}"))).catchError((onError){print("==>>>onErroronError$onError");}) : null;

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE QRData ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "note TEXT,"
          "listNotes TEXT,"
          "dateTime INTEGER,"
          "qrCode TEXT,"
          "saveText INTEGER,"
          "qrImage Uint8List,"
          "updatedTime INTEGER,"
          "backUpDone INTEGER,"
          "secreteId TEXT"
          ")");
    });
  }

  disablePragma() async {
    final db = await database;
    await db.rawQuery("PRAGMA wal_checkpoint");
    await db.execute("VACUUM");
  }

  newData(QRData newData) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM QRData");
    int id = table.first["id"];
    //insert to the table using the new id

    var raw = await db.rawInsert(
        "INSERT Into QRData (id,title,note,listNotes,dateTime,qrCode,saveText,qrImage,updatedTime,backUpDone,secreteId)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newData.title,
          newData.note,
          newData.listNotes,
          newData.dateTime,
          newData.qrCode,
          newData.saveText,
          newData.qrImage,
          newData.updatedTime,
          newData.backUpDone,
          newData.secreteId
        ]);
    return raw;
  }

  blockOrUnblock(QRData newData) async {
    final db = await database;
    QRData blocked = QRData(
        id: newData.id,
        title: newData.title,
        note: newData.note,
        listNotes: newData.listNotes);
    var res = await db.update("QRData", blocked.toMap(),
        where: "id = ?", whereArgs: [newData.id]);
    return res;
  }

  updateData(QRData newData) async {
    final db = await database;
    var res = await db.update("QRData", newData.toMap(),
        where: "id = ?", whereArgs: [newData.id]);
    print("Update result $res");
    return res;
  }

  getData(int id) async {
    final db = await database;
    var res = await db.query(
      "QRData",
      where: "id = ?",
      whereArgs: [id],
    );
    return res.isNotEmpty ? QRData.fromMap(res.first) : null;
  }

  Future<QRData> checkQr(String id) async {
    final db = await database;
    var res = await db.query(
      "QRData",
      where: "qrCode = ?",
      whereArgs: [id],
    );
    QRData data = res.isNotEmpty ? QRData.fromMap(res.first) : null;
    // print("QRVAL ${data.title}");
    return data;
  }

  Future<List<QRData>> getBlockedData() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("QRData", where: "blocked = ? ", whereArgs: [1]);

    List<QRData> list =
        res.isNotEmpty ? res.map((c) => QRData.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<QRData>> getAllDatas() async {
    final db = await database;
    var res = await db.query("QRData", orderBy: "id DESC");
    List<QRData> list =
        res.isNotEmpty ? res.map((c) => QRData.fromMap(c)).toList() : [];
    print("Data size ${list.length}");
    return list;
  }

  deleteData(int id) async {
    final db = await database;
    return db.delete("QRData", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from QRData");
  }

  deleteLocalDatabase() async {
    try{
      // Get a location using getDatabasesPath
      var databasesPath = await getDatabasesPath();
      String dbpath = join(databasesPath, 'QRKnowDB.db');
      print("getDatabasesPath:-->>>$dbpath");
      // Delete the database
      await deleteDatabase(dbpath);
    } catch (e){
      print('restoreDataCheck deleteDatabase error: $e');
    }
  }
}
