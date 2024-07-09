part of 'signup_cubit.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignupState {}

class LoadingState extends SignupState {}

class SignUpSuccessful extends SignupState {
  final String message;

  const SignUpSuccessful(this.message);
}

class SignUpFailed extends SignupState {
  final String message;

  const SignUpFailed(this.message);
}
