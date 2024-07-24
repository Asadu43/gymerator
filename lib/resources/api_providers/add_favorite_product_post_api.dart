import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/AddFavoriteProductApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class AddFavoriteProductPostApi {
  Future<AddFavoriteProductApiResponse> addFavoriteRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.post(ApiConstants.addToCartProduct,
          data: formData, options: Options(validateStatus: (status) {
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
      if (e is DioError) {
        return AddFavoriteProductApiResponse.fromJson(e.response?.data);
      } else {
        return AddFavoriteProductApiResponse();
      }
    }
  }
}
