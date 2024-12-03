import 'package:dental_ui/features/authentication/data/remote/data_sources/remote_data_source.dart';
import 'package:dental_ui/features/authentication/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:dental_ui/features/authentication/data/repositories/auth_repositories_impl.dart';
import 'package:dental_ui/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:dental_ui/features/authentication/domain/use_cases/get_otp_use_case.dart';
import 'package:dental_ui/features/authentication/domain/use_cases/verify_otp_use_case.dart';
import 'package:dental_ui/features/authentication/presentation/cubit/get_otp/get_otp_cubit.dart';
import 'package:dental_ui/features/authentication/presentation/cubit/verify_otp/verify_otp_cubit.dart';
import 'package:dental_ui/injection_container.dart';

Future<void> authInjectionContainer() async {
  //bloc
  sl.registerFactory<GetOtpCubit>(() => GetOtpCubit(sl.call<GetOTPUseCase>()));
  sl.registerFactory<VerifyOtpCubit>(
      () => VerifyOtpCubit(sl.call<VerifyOTPUseCase>()));
  //use case
  sl.registerLazySingleton<GetOTPUseCase>(
      () => GetOTPUseCase(sl.call<AuthRepositories>()));
  sl.registerLazySingleton<VerifyOTPUseCase>(
      () => VerifyOTPUseCase(sl.call<AuthRepositories>()));
  // repository
  sl.registerLazySingleton<AuthRepositories>(
      () => AuthRepositoriesImpl(sl.call<AuthRemoteDataSource>()));

  //datasource
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
}
