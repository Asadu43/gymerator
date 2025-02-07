import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetWorkoutMetricsByExersiceApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class WorkoutMetricsByExerciseGetApi {
  Future<GetWorkoutMetricsByExersiceApiResponse> getRequest(
      String exercise) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio
          .get("${ApiConstants.getMetricsByExercise}?exercise=$exercise");
      print(response.data);
      if (response.statusCode == 200) {
        return GetWorkoutMetricsByExersiceApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetWorkoutMetricsByExersiceApiResponse.fromJson(response.data);
      } else {
        return GetWorkoutMetricsByExersiceApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetWorkoutMetricsByExersiceApiResponse.fromJson(
            e.response?.data);
      } else {
        return GetWorkoutMetricsByExersiceApiResponse();
      }
    }
  }
}
