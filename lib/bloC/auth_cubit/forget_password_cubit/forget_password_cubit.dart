import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/ForgetPasswordApiResponse.dart';

import '../../../resources/repository.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final _repository = Repository();

  Future forgetRequest({
    required String email,
  }) async {
    emit(LoadingState());

    Map data = {"email": email};
    final ForgetPasswordApiResponse model =
        await _repository.forgetRequest(data);
    if (model.error == null) {
      emit(CodeSendSuccessful(model.message ?? "Code Send Successfully"));
    } else {
      emit(FailedToSendCode(model.message ?? "Failed To Send Code"));
    }
  }
}
