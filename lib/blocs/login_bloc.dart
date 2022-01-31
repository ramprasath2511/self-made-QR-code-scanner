import 'dart:async';

import 'package:doctor_appointment_booking/model/login_model.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/repository/login_repository.dart';

class LoginBloc {
  LoginRepository _loginRepository;
  StreamController _loginController;

  StreamSink<Response<LoginModel>> get chuckListSink =>
      _loginController.sink;

  Stream<Response<LoginModel>> get chuckListStream =>
      _loginController.stream;

  LoginBloc(var data) {
    _loginController = StreamController<Response<LoginModel>>();
    _loginRepository = LoginRepository();
    fetchLoginData(data);
  }

  fetchLoginData(var data) async {
    chuckListSink.add(Response.loading('Checking user...'));
    try {
      LoginModel chuckCats =
      await _loginRepository.fetchLogin(data);
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