import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/VerifySignatureApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class VerifySignaturePutApi {
  Future<VerifySignatureApiResponse> verifySignatureRequest(Map data) async {
    try {

      print(data);
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.put(ApiConstants.verifyWallet,
          data: data, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));

      print(response.data);
      if (response.statusCode == 200) {
        return VerifySignatureApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return VerifySignatureApiResponse.fromJson(response.data);
      } else {
        return VerifySignatureApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return VerifySignatureApiResponse.fromJson(e.response?.data);
      } else {
        return VerifySignatureApiResponse();
      }
    }
  }
}
