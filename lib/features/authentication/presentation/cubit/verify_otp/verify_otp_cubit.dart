import 'package:bloc/bloc.dart';
import 'package:dental_ui/features/authentication/domain/use_cases/verify_otp_use_case.dart';
import 'package:equatable/equatable.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOTPUseCase verifyOTPUseCase;

  VerifyOtpCubit(this.verifyOTPUseCase) : super(VerifyOtpInitial());

  Future<void> call(String mobileNumber, String otp) async {
    emit(VerifyOtpLoading());
    try {
      final response = await verifyOTPUseCase(mobileNumber, otp);
      if (response) {
        emit(VerifyOtpSuccess());
      } else {
        emit(VerifyOtpError());
      }
    } catch (error) {
      emit(VerifyOtpError());
    }
  }
}
