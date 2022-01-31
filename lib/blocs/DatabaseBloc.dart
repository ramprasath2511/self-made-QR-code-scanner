import 'dart:async';

import 'package:doctor_appointment_booking/database/Database.dart';
import 'package:doctor_appointment_booking/model/qr_data.dart';
import 'package:flutter/cupertino.dart';


class QRDataBloc {
  QRDataBloc() {
    getQRDatas();
  }

  final _dataController = StreamController<List<QRData>>.broadcast();

  get clients => _dataController.stream;

  getQRDatas() async {
    _dataController.sink.add(await DBProvider.db.getAllDatas());
  }

  Future<void> blockUnblock(QRData client) async {
    await DBProvider.db.blockOrUnblock(client);
    await getQRDatas();
  }

  Future<void> delete(int id) async {
    await DBProvider.db.deleteData(id);
    await getQRDatas();
  }

  Future<List<QRData>> getAllData() async {
   return await DBProvider.db.getAllDatas();
   // await getAllDatas(id);
  }

  Future<void> add(QRData client) async {
    await DBProvider.db.newData(client);
    await getQRDatas();
  }

  Future<QRData> checkQrCode(String code) async{
    QRData data = await DBProvider.db.checkQr(code);
    return data;
  }

  updateQRData(QRData data) async {
    await DBProvider.db.updateData(data);
  }



  dispose() {
    _dataController.close();
  }
}
