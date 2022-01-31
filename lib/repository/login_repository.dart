import 'package:doctor_appointment_booking/model/login_model.dart';
import 'package:doctor_appointment_booking/netwoking/ApiProvider.dart';

class LoginRepository
{
  ApiProvider _provider = ApiProvider();

  Future<LoginModel> fetchLogin(var body) async {
    final response = await _provider.post("Api/login" ,body);
    return LoginModel.fromJson(response);
  }
}