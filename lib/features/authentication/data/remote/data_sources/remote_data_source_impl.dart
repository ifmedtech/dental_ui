import 'package:dental_ui/core/network/custom_dio.dart';
import 'package:dental_ui/core/network/endpoint.dart';
import 'package:dental_ui/features/authentication/data/remote/data_sources/remote_data_source.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<bool> getOTP(String number) async {
    final response = await dioInstance().get("${Endpoint.getOTP}$number");
    return response.statusCode! < 300;
  }
}
