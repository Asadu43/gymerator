

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/AcceptWorkoutPlanApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class AcceptWorkoutPostApi {
  Future<AcceptWorkoutPlanApiResponse> acceptRequest(var data) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response =
      await dio.post(ApiConstants.acceptPlan,
          data: data, options: Options(validateStatus: (status) {
            return status! <= 500;
          }));
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