

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/RemoveCartItemApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class RemoveCartItemPutApi {
  Future<RemoveCartItemApiResponse> removeRequest(String id) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response =
      await dio.put(ApiConstants.removeCartItem, queryParameters: {
        'itemID': id,
      }, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return RemoveCartItemApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return RemoveCartItemApiResponse.fromJson(response.data);
      } else {
        return RemoveCartItemApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return RemoveCartItemApiResponse.fromJson(e.response?.data);
      } else {
        return RemoveCartItemApiResponse();
      }
    }
  }
}
