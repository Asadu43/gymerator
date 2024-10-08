import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GenerateWorkoutPlanApiResponse.dart';

import '../../models/api_response/AcceptWorkoutPlanApiResponse.dart';
import '../../utils/api_constants/api_constants.dart';
import '../common_variables/common_variables.dart';

class GenerateWorkPlanGetApi {
  Future<GenerateWorkoutPlanApiResponse> generatePlanRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.generatePlan);
      workout_plan = response.data['data'];
      if (response.statusCode == 200) {
        return GenerateWorkoutPlanApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GenerateWorkoutPlanApiResponse.fromJson(response.data);
      } else {
        return GenerateWorkoutPlanApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GenerateWorkoutPlanApiResponse.fromJson(e.response?.data);
      } else {
        return GenerateWorkoutPlanApiResponse();
      }
    }
  }

  Future<AcceptWorkoutPlanApiResponse> acceptRequest() async {
    print("workout_plan");
    print(workout_plan);
    print("workout_plan");
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio
          .post(ApiConstants.acceptPlan, data: {"workoutPlan": workout_plan},
              options: Options(validateStatus: (status) {
        return status! <= 500;
      }));

      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return AcceptWorkoutPlanApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return AcceptWorkoutPlanApiResponse.fromJson(response.data);
      } else {
        return AcceptWorkoutPlanApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return AcceptWorkoutPlanApiResponse.fromJson(e.response?.data);
      } else {
        return AcceptWorkoutPlanApiResponse();
      }
    }
  }
}
