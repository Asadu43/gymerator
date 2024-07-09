part of 'verify_otp_cubit.dart';

sealed class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object> get props => [];
}

final class VerifyOtpInitial extends VerifyOtpState {}

class LoadingState extends VerifyOtpState {}

class VerifyOtpSuccessfully extends VerifyOtpState {
  final String message;

  const VerifyOtpSuccessfully(this.message);
}

class FailedToVerifyCode extends VerifyOtpState {
  final String message;

  const FailedToVerifyCode(this.message);
}
