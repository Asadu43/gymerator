


import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/MarkAsReadApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class MarkedAsReadPutApi {
  Future<MarkAsReadApiResponse> readRequest(String id) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response =
      await dio.put(ApiConstants.markAsNotification, queryParameters: {
        'notificationId': id,
      }, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return MarkAsReadApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return MarkAsReadApiResponse.fromJson(response.data);
      } else {
        return MarkAsReadApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return MarkAsReadApiResponse.fromJson(e.response?.data);
      } else {
        return MarkAsReadApiResponse();
      }
    }
  }
}