import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/UpdatePasswordApiResponse.dart';
import 'package:gymmerator/resources/repository.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitial());

  final _repository = Repository();

  Future updateRequest({
    required String email,
    required String password,
  }) async {
    emit(LoadingState());

    Map data = {
      "email": email,
      "password": password,
    };
    final UpdatePasswordApiResponse signInModel =
        await _repository.updateRequest(data);

    if (signInModel.error == null) {
      emit(UpdatePasswordSuccessfully(
          signInModel.message ?? "Update Password Successfully"));
    } else {
      emit(PasswordUpdateFailed(
          signInModel.message ?? "Password Update Failed"));
    }
  }
}
