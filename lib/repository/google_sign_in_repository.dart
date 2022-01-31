import 'package:doctor_appointment_booking/model/GoogleSignInModel.dart';
import 'package:doctor_appointment_booking/netwoking/ApiProvider.dart';

class GoogleSignInRepository
{
  ApiProvider _provider = ApiProvider();

  Future<GoogleSignInModel> fetchGoogleSignIn(var body) async {
    final response = await _provider.post("Api/google_social_login" ,body);
    return GoogleSignInModel.fromJson(response);
  }
}