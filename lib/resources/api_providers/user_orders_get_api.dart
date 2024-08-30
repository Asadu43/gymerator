import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetAllUserOrdersApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class UserOrdersGetApi {
  Future<GetAllUserOrdersApiResponse> getAllOrdersRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.allOrders);
      print(response.data);
      if (response.statusCode == 200) {
        return GetAllUserOrdersApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetAllUserOrdersApiResponse.fromJson(response.data);
      } else {
        return GetAllUserOrdersApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetAllUserOrdersApiResponse.fromJson(e.response?.data);
      } else {
        return GetAllUserOrdersApiResponse();
      }
    }
  }
}
