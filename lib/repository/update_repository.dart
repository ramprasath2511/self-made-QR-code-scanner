import 'package:doctor_appointment_booking/model/update_model.dart';
import 'package:doctor_appointment_booking/netwoking/ApiProvider.dart';

class UpdateRepository
{
  ApiProvider _provider = ApiProvider();

  Future<UpdateModel> updateUser(var body) async {
    final response = await _provider.post("Api/update_user_profile" ,body);
    return UpdateModel.fromJson(response);
  }
}