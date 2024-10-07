


import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetWorkoutPlanApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class WorkoutPlanGetApi {
  Future<GetWorkoutPlanApiResponse> getPlanRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.generatePlan);

      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GetWorkoutPlanApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetWorkoutPlanApiResponse.fromJson(response.data);
      } else {
        return GetWorkoutPlanApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetWorkoutPlanApiResponse.fromJson(e.response?.data);
      } else {
        return GetWorkoutPlanApiResponse();
      }
    }
  }
}