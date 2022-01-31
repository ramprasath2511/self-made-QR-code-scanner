import 'dart:convert';

import 'dart:typed_data';

QRData qrDataFromJson(String str) {
  final jsonData = json.decode(str);
  return QRData.fromMap(jsonData);
}

String qrDataToJson(QRData data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class QRData {
  int id;
  String title;
  String note;
  String listNotes;
  int dateTime;
  String qrCode;
  int saveText;
  Uint8List qrImage;
  int updatedTime;
  int backUpDone;
  String secreteId;

  QRData({
    this.id,
    this.title,
    this.note,
    this.dateTime,
    this.listNotes,
    this.qrCode,
    this.saveText,
    this.qrImage,
    this.updatedTime,
    this.backUpDone,
    this.secreteId
  });

  factory QRData.fromMap(Map<String, dynamic> json) => new QRData(
    id: json["id"],
    title: json["title"],
    note: json["note"],
    dateTime: json["dateTime"],
    qrCode: json["qrCode"],
    saveText: json["saveText"],
    qrImage: json["qrImage"],
    updatedTime: json["updatedTime"],
    backUpDone: json["backUpDone"],
    listNotes: json['listNotes'],
    secreteId: json["secreteId"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "note": note,
    "dateTime": dateTime,
    "qrCode" : qrCode,
    "listNotes" :listNotes,
    "saveText" : saveText,
    "qrImage" : qrImage,
    "updatedTime" : updatedTime,
    "backUpDone" : backUpDone,
    "secreteId" : secreteId
  };
}
