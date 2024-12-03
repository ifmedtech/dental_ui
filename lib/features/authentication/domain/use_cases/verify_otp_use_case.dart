import 'package:dental_ui/features/authentication/domain/repositories/auth_repositories.dart';

class VerifyOTPUseCase {
  final AuthRepositories authRepositories;

  VerifyOTPUseCase(this.authRepositories);

  Future<bool> call(String mobileNumber, String otp) =>
      authRepositories.verifyOTP(mobileNumber, otp);
}
