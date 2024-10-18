import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/UpdateWorkoutPlanApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';
import '../common_variables/common_variables.dart';

class UpdateWorkOutPutApi {
  Future<UpdateWorkoutPlanApiResponse> updateRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.put(ApiConstants.updateWorkoutPlan,
          data: {"workoutPlan": workout_plan},
          options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return UpdateWorkoutPlanApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return UpdateWorkoutPlanApiResponse.fromJson(response.data);
      } else {
        return UpdateWorkoutPlanApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return UpdateWorkoutPlanApiResponse.fromJson(e.response?.data);
      } else {
        return UpdateWorkoutPlanApiResponse();
      }
    }
  }
}
