

abstract class AuthRemoteDataSource{
  Future<bool> getOTP(String number);
  Future<bool> verifyOTP(String mobileNumber,String otp);
}
