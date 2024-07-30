import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/UpdateCartItemApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class UpdateCartItemPutApi {
  Future<UpdateCartItemApiResponse> updateRequest(String id,int quantity) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response =
          await dio.put(ApiConstants.updateCartItem, queryParameters: {
            'itemID': id,
            'quantity': quantity
      }, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return UpdateCartItemApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return UpdateCartItemApiResponse.fromJson(response.data);
      } else {
        return UpdateCartItemApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return UpdateCartItemApiResponse.fromJson(e.response?.data);
      } else {
        return UpdateCartItemApiResponse();
      }
    }
  }
}
