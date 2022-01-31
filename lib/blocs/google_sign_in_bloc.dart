import 'dart:async';

import 'package:doctor_appointment_booking/model/GoogleSignInModel.dart';
import 'package:doctor_appointment_booking/model/login_model.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/repository/google_sign_in_repository.dart';
import 'package:doctor_appointment_booking/repository/login_repository.dart';

class GoogleSignInBloc {
  GoogleSignInRepository _googleSignInRepository;
  StreamController _loginController;

  StreamSink<Response<GoogleSignInModel>> get chuckListSink =>
      _loginController.sink;

  Stream<Response<GoogleSignInModel>> get chuckListStream =>
      _loginController.stream;

  GoogleSignInBloc(var data) {
    _loginController = StreamController<Response<GoogleSignInModel>>();
    _googleSignInRepository = GoogleSignInRepository();
    fetchLoginData(data);
  }

  fetchLoginData(var data) async {
    chuckListSink.add(Response.loading('Checking user...'));
    try {
      GoogleSignInModel chuckCats =
      await _googleSignInRepository.fetchGoogleSignIn(data);
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