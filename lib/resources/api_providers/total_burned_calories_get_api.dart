import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/TotalBurnedCaloriesApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class TotalBurnedCaloriesGetApi {
  Future<TotalBurnedCaloriesApiResponse> getRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.getBurnedCalories);
      print(response.data);
      if (response.statusCode == 200) {
        return TotalBurnedCaloriesApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return TotalBurnedCaloriesApiResponse.fromJson(response.data);
      } else {
        return TotalBurnedCaloriesApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return TotalBurnedCaloriesApiResponse.fromJson(e.response?.data);
      } else {
        return TotalBurnedCaloriesApiResponse();
      }
    }
  }
}
