import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetAllUserProductApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class UserCartProductsGetApi {
  Future<GetAllUserProductApiResponse> getCartRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.userCartProduct);

      print(response.data);
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GetAllUserProductApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetAllUserProductApiResponse.fromJson(response.data);
      } else {
        return GetAllUserProductApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetAllUserProductApiResponse.fromJson(e.response?.data);
      } else {
        return GetAllUserProductApiResponse();
      }
    }
  }
}
