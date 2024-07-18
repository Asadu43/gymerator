import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/ProductDetailApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class ProductDetailGetApi {
  Future<ProductDetailApiResponse> detailRequest(String id) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.get(
        "${ApiConstants.detailProduct}?productId=$id",
      );
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
