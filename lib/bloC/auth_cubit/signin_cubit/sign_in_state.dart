part of 'sign_in_cubit.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

class LoadingState extends SignInState {}

class SignInSuccessful extends SignInState {
  final String message;

  const SignInSuccessful(this.message);
}

class SignInFailed extends SignInState {
  final String message;

  const SignInFailed(this.message);
}
