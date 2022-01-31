import 'dart:async';

import 'package:doctor_appointment_booking/model/update_model.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/repository/update_repository.dart';

class UpdateBloc
{
  UpdateRepository _repository;
  StreamController _loginController;

  StreamSink<Response<UpdateModel>> get chuckListSink =>
      _loginController.sink;

  Stream<Response<UpdateModel>> get chuckListStream =>
      _loginController.stream;

  UpdateBloc(var data) {
    _loginController = StreamController<Response<UpdateModel>>();
    _repository = UpdateRepository();
    fetchLoginData(data);
  }

  fetchLoginData(var data) async {
    chuckListSink.add(Response.loading('Checking user...'));
    try {
      UpdateModel chuckCats =
      await _repository.updateUser(data);
      chuckListSink.add(Response.completed(chuckCats));
    } catch (e) {
      chuckListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _loginController?.close();
  }
}