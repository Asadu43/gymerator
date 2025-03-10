import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetWorkoutMetricsApiResponse.dart';
import 'package:gymmerator/models/api_response/GetWorkoutMetricsByDateApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class WorkoutMetricsGetApi {
  Future<GetWorkoutMetricsApiResponse> getRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.getWorkoutMetrics);
      print(response.data);
      if (response.statusCode == 200) {
        print(response.statusMessage);
        return GetWorkoutMetricsApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetWorkoutMetricsApiResponse.fromJson(response.data);
      } else {
        return GetWorkoutMetricsApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetWorkoutMetricsApiResponse.fromJson(e.response?.data);
      } else {
        return GetWorkoutMetricsApiResponse();
      }
    }
  }

  Future<GetWorkoutMetricsByDateApiResponse> getWorkoutByDateRequest(
      String date) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response =
          await dio.get(ApiConstants.getWorkoutMetricsByDate, queryParameters: {
        'date': date,
      });
      print(response.data);
      if (response.statusCode == 200) {
        print(response.statusMessage);
        return GetWorkoutMetricsByDateApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetWorkoutMetricsByDateApiResponse.fromJson(response.data);
      } else {
        return GetWorkoutMetricsByDateApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetWorkoutMetricsByDateApiResponse.fromJson(e.response?.data);
      } else {
        return GetWorkoutMetricsByDateApiResponse();
      }
    }
  }
}
