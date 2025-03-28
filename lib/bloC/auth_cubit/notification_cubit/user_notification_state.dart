part of 'user_notification_cubit.dart';

sealed class UserNotificationState extends Equatable {
  const UserNotificationState();

  @override
  List<Object> get props => [];
}

final class UserNotificationInitial extends UserNotificationState {

}
class LoadingState extends UserNotificationState {}

class AllNotificationGetSuccessfully extends UserNotificationState {
  final GetNotificationsApiResponse response;

  const AllNotificationGetSuccessfully(this.response);
}

class FailedToGetNotifications extends UserNotificationState {
  final GetNotificationsApiResponse response;

  const FailedToGetNotifications(this.response);
}


class MarkAsReadSuccessfully extends UserNotificationState {
  final MarkAsReadApiResponse response;

  const MarkAsReadSuccessfully(this.response);
}

class FailedToMarkedAsRead extends UserNotificationState {
  final MarkAsReadApiResponse response;

  const FailedToMarkedAsRead(this.response);
}