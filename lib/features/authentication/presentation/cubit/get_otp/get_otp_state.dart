part of 'get_otp_cubit.dart';

sealed class GetOtpState extends Equatable {
  const GetOtpState();
}

final class GetOtpInitial extends GetOtpState {
  @override
  List<Object> get props => [];
}

final class GetOtpLoading extends GetOtpState {
  @override
  List<Object> get props => [];
}

final class GetOtpError extends GetOtpState {
  final String errorMessage;

  const GetOtpError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class GetOtpSuccess extends GetOtpState {
  final String mobileNumber;

  const GetOtpSuccess({required this.mobileNumber});

  @override
  List<Object> get props => [mobileNumber];
}
