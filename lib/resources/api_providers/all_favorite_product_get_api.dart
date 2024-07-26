import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetAllFavoriteProductApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class AllFavoriteProductGetApi {
  Future<GetAllFavoriteProductApiResponse> getFavoriteRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.userFavoriteProduct);
      if (response.statusCode == 200) {
        return GetAllFavoriteProductApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetAllFavoriteProductApiResponse.fromJson(response.data);
      } else {
        return GetAllFavoriteProductApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return GetAllFavoriteProductApiResponse.fromJson(e.response?.data);
      } else {
        return GetAllFavoriteProductApiResponse();
      }
    }
  }
}
