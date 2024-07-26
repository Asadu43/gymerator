import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/AddToCartProductApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class AddToCartPostApi {
  Future<AddToCartProductApiResponse> cartRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.post(ApiConstants.addToCartProduct,
          data: formData, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return AddToCartProductApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return AddToCartProductApiResponse.fromJson(response.data);
      } else {
        return AddToCartProductApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return AddToCartProductApiResponse.fromJson(e.response?.data);
      } else {
        return AddToCartProductApiResponse();
      }
    }
  }
}
