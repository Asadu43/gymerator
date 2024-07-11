part of 'update_password_cubit.dart';

sealed class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordInitial extends UpdatePasswordState {}

class LoadingState extends UpdatePasswordState {}

class UpdatePasswordSuccessfully extends UpdatePasswordState {
  final String message;

  const UpdatePasswordSuccessfully(this.message);
}

class PasswordUpdateFailed extends UpdatePasswordState {
  final String message;

  const PasswordUpdateFailed(this.message);
}
