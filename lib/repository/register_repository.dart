import 'package:doctor_appointment_booking/model/register_model.dart';
import 'package:doctor_appointment_booking/netwoking/ApiProvider.dart';

class RegisterRepository
{
  ApiProvider _provider = ApiProvider();

  Future<RegisterModel> fetchRegister(var body) async {
    final response = await _provider.post("Api/user_register" ,body);
    return RegisterModel.fromJson(response);
  }
}