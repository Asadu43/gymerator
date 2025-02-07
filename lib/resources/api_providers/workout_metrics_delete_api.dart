import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/DeleteWorkoutMetricsApiResponse.dart';
import '../../utils/api_constants/api_constants.dart';

class WorkoutMetricsDeleteApi {
  Future<DeleteWorkoutMetricsApiResponse> deleteRequest(String id) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response =
          await dio.delete(" ${ApiConstants.deleteWorkoutMetrics}?id=$id");
      print(response.data);
      if (response.statusCode == 200) {
        return DeleteWorkoutMetricsApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return DeleteWorkoutMetricsApiResponse.fromJson(response.data);
      } else {
        return DeleteWorkoutMetricsApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return DeleteWorkoutMetricsApiResponse.fromJson(e.response?.data);
      } else {
        return DeleteWorkoutMetricsApiResponse();
      }
    }
  }
}
