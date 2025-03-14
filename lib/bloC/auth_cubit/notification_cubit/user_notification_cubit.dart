import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/GetNotificationsApiResponse.dart';

import '../../../resources/repository.dart';

part 'user_notification_state.dart';

class UserNotificationCubit extends Cubit<UserNotificationState> {
  UserNotificationCubit() : super(UserNotificationInitial());

  final _repository = Repository();

  Future getNotificationRequest() async {
    emit(LoadingState());
    final GetNotificationsApiResponse model =
        await _repository.getNotificationRequest();
    if (model.error == null) {
      emit(AllNotificationGetSuccessfully(model));
    } else {
      emit(FailedToGetNotifications(model));
    }
  }
}
