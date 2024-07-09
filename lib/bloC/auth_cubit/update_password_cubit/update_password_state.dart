part of 'update_password_cubit.dart';

sealed class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordInitial extends UpdatePasswordState {}

class LoadingState extends UpdatePasswordState {}

class SignInSuccessful extends UpdatePasswordState {
  final String message;

  const SignInSuccessful(this.message);
}

class SignInFailed extends UpdatePasswordState {
  final String message;

  const SignInFailed(this.message);
}
