import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/AddWorkoutMetricsApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class AddWorkoutMetricsPostApi {
  Future<AddWorkoutMetricsApiResponse> addRequest(var data) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.post(ApiConstants.addWorkoutMetrics,
          data: data, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return AddWorkoutMetricsApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return AddWorkoutMetricsApiResponse.fromJson(response.data);
      } else {
        return AddWorkoutMetricsApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return AddWorkoutMetricsApiResponse.fromJson(e.response?.data);
      } else {
        return AddWorkoutMetricsApiResponse();
      }
    }
  }
}
