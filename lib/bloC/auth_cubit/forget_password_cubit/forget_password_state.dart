part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

class LoadingState extends ForgetPasswordState {}

class CodeSendSuccessful extends ForgetPasswordState {
  final String message;

  const CodeSendSuccessful(this.message);
}

class FailedToSendCode extends ForgetPasswordState {
  final String message;

  const FailedToSendCode(this.message);
}
