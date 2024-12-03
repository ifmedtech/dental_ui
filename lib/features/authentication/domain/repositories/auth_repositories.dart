abstract class AuthRepositories {
  Future<bool> getOTP(String mobileNumber);

  Future<bool> verifyOTP(String mobileNumber, String otp);
}
