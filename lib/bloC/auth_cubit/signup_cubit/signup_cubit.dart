import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/api_response/SignupApiResponse.dart';
import '../../../resources/repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignUpInitial());

  final _repository = Repository();

  Future signUp({
    required String firstname,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String country,
    required String postalCode,
    required String lat,
    required String long,
  }) async {
    emit(LoadingState());

    Map data = {
      "firstName": firstname,
      "lastName": lastName,
      "email": email,
      "password": password,
      "mobile": phoneNumber,
      "address1": address1,
      "address2": address1,
      "city": city,
      "state": state,
      "country": country,
      "postalCode": postalCode,
      "latitude": lastName,
      "longitude": long
    };
    print(data);
    final SignupApiResponse signUpModel = await _repository.signUp(data);
    if (signUpModel.error == null) {
      emit(const SignUpSuccessful("Sign Up Successfully"));
    } else {
      emit(const SignUpFailed("Sign Up Failed"));
    }
  }
}
