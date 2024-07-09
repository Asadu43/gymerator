import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/SignInApiResponse.dart';
import '../../utils/api_constants/api_constants.dart';

class SignInPostApi {
  Future<SignInApiResponse> signInRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.post(ApiConstants.signIn,
          data: formData, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return SignInApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return SignInApiResponse.fromJson(response.data);
      } else {
        return SignInApiResponse();
      }
    } catch (e) {
      if (e is DioError) {
        return SignInApiResponse.fromJson(e.response?.data);
      } else {
        return SignInApiResponse();
      }
    }
  }
}
