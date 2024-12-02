import 'package:dental_ui/features/authentication/domain/repositories/auth_repositories.dart';

class GetOTPUseCase {
  final AuthRepositories authRepositories;

  GetOTPUseCase(this.authRepositories);

  Future<bool> call(String mobileNumber) =>
      authRepositories.getOTP(mobileNumber);
}
