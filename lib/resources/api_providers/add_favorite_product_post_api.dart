import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/AddFavoriteProductApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class AddFavoriteProductPostApi {
  Future<AddFavoriteProductApiResponse> addFavoriteRequest(String id) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response =
          await dio.put(ApiConstants.addFavoriteProduct, queryParameters: {
        'productID': id,
      }, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return AddFavoriteProductApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return AddFavoriteProductApiResponse.fromJson(response.data);
      } else {
        return AddFavoriteProductApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return AddFavoriteProductApiResponse.fromJson(e.response?.data);
      } else {
        return AddFavoriteProductApiResponse();
      }
    }
  }
}
