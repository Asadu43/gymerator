part of 'update_user_info_cubit.dart';

sealed class UpdateUserInfoState extends Equatable {
  const UpdateUserInfoState();

  @override
  List<Object> get props => [];
}

final class UpdateUserInfoInitial extends UpdateUserInfoState {}

class LoadingState extends UpdateUserInfoState {}

class UpdateUserSuccessfully extends UpdateUserInfoState {
  final String message;

  const UpdateUserSuccessfully(this.message);
}

class FailedToUpdateUserInfo extends UpdateUserInfoState {
  final String message;

  const FailedToUpdateUserInfo(this.message);
}
