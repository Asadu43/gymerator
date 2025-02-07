import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetNonceApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class NonceGetApi {
  Future<GetNonceApiResponse> getNonceRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.post(ApiConstants.getNonce);
      if (response.statusCode == 200) {
        return GetNonceApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetNonceApiResponse.fromJson(response.data);
      } else {
        return GetNonceApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetNonceApiResponse.fromJson(e.response?.data);
      } else {
        return GetNonceApiResponse();
      }
    }
  }
}
