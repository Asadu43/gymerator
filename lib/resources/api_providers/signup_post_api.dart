import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/SignupApiResponse.dart';
import '../../utils/api_constants/api_constants.dart';

class SignUpPostApi {
  Future<SignupApiResponse> signUpRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.post(ApiConstants.signUp,
          data: formData, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return SignupApiResponse.fromJson(response.data);
      } else {
        return SignupApiResponse(error: response.statusMessage);
      }
    } catch (e) {
      if (e is DioError) {
        return SignupApiResponse.fromJson(e.response?.data);
      } else {
        return SignupApiResponse();
      }
    }
  }
}
