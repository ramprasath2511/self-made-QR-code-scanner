import 'dart:async';

import 'package:doctor_appointment_booking/model/secrete_code_data.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/repository/secrete_code_repository.dart';

class SecreteCodeBloc
{
  SecreteCodeRepository _secreteCodeRepository;
  StreamController _loginController;

  StreamSink<Response<SecreteCodeModel>> get chuckListSink =>
      _loginController.sink;

  Stream<Response<SecreteCodeModel>> get chuckListStream =>
      _loginController.stream;

  SecreteCodeBloc() {
    _loginController = StreamController<Response<SecreteCodeModel>>();
    _secreteCodeRepository = SecreteCodeRepository();
    fetchLoginData();
  }

  fetchLoginData() async {
    chuckListSink.add(Response.loading('Loading...'));
    try {
      SecreteCodeModel chuckCats =
      await _secreteCodeRepository.fetchSecreteCode();
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