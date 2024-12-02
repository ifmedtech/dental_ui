import 'package:bloc/bloc.dart';
import 'package:dental_ui/features/authentication/domain/use_cases/get_otp_use_case.dart';
import 'package:equatable/equatable.dart';

part 'get_otp_state.dart';

class GetOtpCubit extends Cubit<GetOtpState> {
  final GetOTPUseCase getOTPUseCase;

  GetOtpCubit(this.getOTPUseCase) : super(GetOtpInitial());

  Future<void> call(String mobileNumber) async {
    emit(GetOtpLoading());
    try {
      final response = await getOTPUseCase(mobileNumber);
      if (response) {
        emit(GetOtpSuccess(mobileNumber: mobileNumber));
      } else {
        emit(GetOtpError(errorMessage: "some thing went wrong"));
      }
    } catch (error) {
      emit(GetOtpError(errorMessage: error.toString()));
    }
  }
}
