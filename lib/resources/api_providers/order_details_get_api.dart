import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/UserOrderDetailsApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class OrderDetailsGetApi {
  Future<UserOrderDetailsApiResponse> detailRequest(String id) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(
        "${ApiConstants.orderDetails}?orderID=$id",
      );

      print(response.data);
      if (response.statusCode == 200) {
        return UserOrderDetailsApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return UserOrderDetailsApiResponse.fromJson(response.data);
      } else {
        return UserOrderDetailsApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return UserOrderDetailsApiResponse.fromJson(e.response?.data);
      } else {
        return UserOrderDetailsApiResponse();
      }
    }
  }
}
