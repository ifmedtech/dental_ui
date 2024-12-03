part of 'verify_otp_cubit.dart';

sealed class VerifyOtpState extends Equatable {
  const VerifyOtpState();
}

final class VerifyOtpInitial extends VerifyOtpState {
  @override
  List<Object> get props => [];
}

final class VerifyOtpSuccess extends VerifyOtpState {
  @override
  List<Object> get props => [];
}

final class VerifyOtpError extends VerifyOtpState {
  @override
  List<Object> get props => [];
}

final class VerifyOtpLoading extends VerifyOtpState {
  @override
  List<Object> get props => [];
}
