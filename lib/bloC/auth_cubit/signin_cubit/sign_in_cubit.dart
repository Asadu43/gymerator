import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/LoginWithGoogleApiResponse.dart';

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
    Map data = {"email": email, "password": password};
    final SignInApiResponse signInModel = await _repository.signIn(data);
    if (signInModel.error == null) {
      storeToken(signInModel.data!.isRequiredInfoAdded!);
      storeAccept(signInModel.data!.isAccepted!);
      emit(SignInSuccessful(signInModel));
    } else {
      emit(SignInFailed(signInModel.message ?? "Incorrect email or password."));
    }
  }

  Future loginWithGoogle({
    required String displayName,
    required String email,
    required String phoneNumber,
    String? photoURL,
  }) async {
    emit(LoadingState());

    Map data = {
      "displayName": displayName,
      "email": email,
      "mobileNumber": phoneNumber,
      "photoURL": photoURL ?? ""
    };
    final LoginWithGoogleApiResponse signInModel =
        await _repository.loginWithGoogle(data);
    print(signInModel.message);
    print(signInModel.data);
    print(signInModel.error);
    if (signInModel.error == null) {
      storeToken(signInModel.data!.isRequiredInfoAdded!);
      storeAccept(signInModel.data!.isAccepted!);
      emit(LoginWithGoogleSuccessfully(signInModel));
    } else {
      emit(LoginWithGoogleFailed(
          signInModel.message ?? "Incorrect email or password."));
    }
  }

  storeToken(bool result) {
    GetStorage().write('isRequiredInfoAdded', result);
  }

  storeAccept(bool result) {
    GetStorage().write('isAccepted', result);
  }
}
