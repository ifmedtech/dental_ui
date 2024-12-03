import 'package:dental_ui/core/network/custom_dio.dart';
import 'package:dental_ui/core/network/endpoint.dart';
import 'package:dental_ui/features/authentication/data/remote/data_sources/remote_data_source.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<bool> getOTP(String number) async {
    final response = await dioInstance().get("${Endpoint.getOTP}$number");
    //TODO : form dummy otp
    if (response.statusCode! < 300) {
      Fluttertoast.showToast(msg: "OTP - ${response.data['otp']}");
    }
    return response.statusCode! < 300;
  }

  @override
  Future<bool> verifyOTP(String mobileNumber, String otp) {
    // TODO: implement verifyOTP
    throw UnimplementedError();
  }
}
