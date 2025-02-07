import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetWorkoutSummaryApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class WorkoutMetricsSummaryGetApi {
  Future<GetWorkoutSummaryApiResponse> getRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.getWorkoutSummary);
      print(response.data);
      if (response.statusCode == 200) {
        return GetWorkoutSummaryApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetWorkoutSummaryApiResponse.fromJson(response.data);
      } else {
        return GetWorkoutSummaryApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetWorkoutSummaryApiResponse.fromJson(e.response?.data);
      } else {
        return GetWorkoutSummaryApiResponse();
      }
    }
  }
}
