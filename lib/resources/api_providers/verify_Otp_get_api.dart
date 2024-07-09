import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/VerifyOTPApiResponse.dart';
import '../../utils/api_constants/api_constants.dart';

class VerifyOtpGetApi {
  Future<VerifyOtpApiResponse> verifyRequest(String email,int code) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.get("${ApiConstants.verifyOTP}?email=$email&otp=$code",);
      if (response.statusCode == 200) {
        return VerifyOtpApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return VerifyOtpApiResponse.fromJson(response.data);
      } else {
        return VerifyOtpApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return VerifyOtpApiResponse.fromJson(e.response?.data);
      } else {
        return VerifyOtpApiResponse();
      }
    }
  }
}
