import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetNotificationsApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class UserNotificationsGetApi {
  Future<GetNotificationsApiResponse> getUserNotificationRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.userNotification);

      print(response.data);
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GetNotificationsApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetNotificationsApiResponse.fromJson(response.data);
      } else {
        return GetNotificationsApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetNotificationsApiResponse.fromJson(e.response?.data);
      } else {
        return GetNotificationsApiResponse();
      }
    }
  }
}
