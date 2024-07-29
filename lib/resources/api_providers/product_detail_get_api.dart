import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/ProductDetailApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class ProductDetailGetApi {
  Future<ProductDetailApiResponse> detailRequest(String id) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(
        "${ApiConstants.detailProduct}?productId=$id",
      );

      print(response.data);
      if (response.statusCode == 200) {
        return ProductDetailApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return ProductDetailApiResponse.fromJson(response.data);
      } else {
        return ProductDetailApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return ProductDetailApiResponse.fromJson(e.response?.data);
      } else {
        return ProductDetailApiResponse();
      }
    }
  }
}
