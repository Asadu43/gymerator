import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/api_response/SignInApiResponse.dart';
import '../../../resources/repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  final _repository = Repository();

  Future signIn({
    required String email,
    required String password,
  }) async {
    emit(LoadingState());

    Map data = {
      "email": email,
      "password": password,
    };
    print(data);
    final SignInApiResponse signInModel = await _repository.signIn(data);

    print(signInModel.error);
    print(signInModel.message);
    if (signInModel.error == null) {
      emit(SignInSuccessful(signInModel));
    } else {
      emit(SignInFailed(signInModel.message ?? "Incorrect email or password."));
    }
  }
}
