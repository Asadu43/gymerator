import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/RemoveFavoriteProductApiResponse.dart';
import '../../utils/api_constants/api_constants.dart';

class RemoveFavoritePutApi {
  Future<RemoveFavoriteProductApiResponse> removeFavoriteRequest(String id) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response =
          await dio.put(ApiConstants.removeFavoriteProduct, queryParameters: {
        'productID': id,
      }, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));

      if (response.statusCode == 200) {
        return RemoveFavoriteProductApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return RemoveFavoriteProductApiResponse.fromJson(response.data);
      } else {
        return RemoveFavoriteProductApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return RemoveFavoriteProductApiResponse.fromJson(e.response?.data);
      } else {
        return RemoveFavoriteProductApiResponse();
      }
    }
  }
}
