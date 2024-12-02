import 'package:dental_ui/features/authentication/data/remote/data_sources/remote_data_source.dart';
import 'package:dental_ui/features/authentication/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoriesImpl(this.authRemoteDataSource);

  @override
  Future<bool> getOTP(String mobileNumber) =>
      authRemoteDataSource.getOTP(mobileNumber);
}
