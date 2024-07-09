import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/UpdatePasswordApiResponse.dart';
import 'package:gymmerator/models/api_response/VerifyOTPApiResponse.dart';

import '../../../resources/repository.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitial());


  final _repository = Repository();

  Future verifyRequest({
    required String email,
    required int code,
  }) async {
    emit(LoadingState());
    final VerifyOtpApiResponse model = await _repository.verifyRequest(email,code);
    if (model.error == null) {
      emit(VerifyOtpSuccessfully(model.message ?? "Verify Otp Successfully"));
    } else {
      emit(FailedToVerifyCode(model.message ?? "Failed To Verify Otp."));
    }
  }


}
