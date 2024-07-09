import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/ForgetPasswordApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class ForgetPasswordPostApi {
  Future<ForgetPasswordApiResponse> forgetRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.post(ApiConstants.forgetPassword,
          data: formData, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return ForgetPasswordApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return ForgetPasswordApiResponse.fromJson(response.data);
      } else {
        return ForgetPasswordApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return ForgetPasswordApiResponse.fromJson(e.response?.data);
      } else {
        return ForgetPasswordApiResponse();
      }
    }
  }
}
