import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetAllProductApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class AllProductGetApi {
  Future<GetAllProductApiResponse> getProductRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.allProduct);

      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GetAllProductApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetAllProductApiResponse.fromJson(response.data);
      } else {
        return GetAllProductApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetAllProductApiResponse.fromJson(e.response?.data);
      } else {
        return GetAllProductApiResponse();
      }
    }
  }
}
