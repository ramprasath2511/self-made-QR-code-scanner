import 'package:doctor_appointment_booking/model/secrete_code_data.dart';
import 'package:doctor_appointment_booking/netwoking/ApiProvider.dart';

class SecreteCodeRepository
{
  ApiProvider _provider = ApiProvider();

  Future<SecreteCodeModel> fetchSecreteCode() async {
    final response = await _provider.get("Api/all_secret_codes");
    return SecreteCodeModel.fromJson(response);
  }
}