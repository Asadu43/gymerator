import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/UpdatePasswordApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class UpdatePasswordPutApi {
  Future<UpdatePasswordApiResponse> updateRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.put(ApiConstants.updatePassword,
          data: formData, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return UpdatePasswordApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return UpdatePasswordApiResponse.fromJson(response.data);
      } else {
        return UpdatePasswordApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return UpdatePasswordApiResponse.fromJson(e.response?.data);
      } else {
        return UpdatePasswordApiResponse();
      }
    }
  }
}
