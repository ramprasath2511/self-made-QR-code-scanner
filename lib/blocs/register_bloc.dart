import 'dart:async';

import 'package:doctor_appointment_booking/model/login_model.dart';
import 'package:doctor_appointment_booking/model/register_model.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/repository/login_repository.dart';
import 'package:doctor_appointment_booking/repository/register_repository.dart';

class RegisterBloc {
  RegisterRepository _registerRepository;
  StreamController _loginController;

  StreamSink<Response<RegisterModel>> get chuckListSink =>
      _loginController.sink;

  Stream<Response<RegisterModel>> get chuckListStream =>
      _loginController.stream;

  RegisterBloc(var data) {
    _loginController = StreamController<Response<RegisterModel>>();
    _registerRepository = RegisterRepository();
    fetchLoginData(data);
  }

  fetchLoginData(var data) async {
    chuckListSink.add(Response.loading('Checking user...'));
    try {
      RegisterModel chuckCats =
      await _registerRepository.fetchRegister(data);
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