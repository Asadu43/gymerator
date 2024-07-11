


import 'package:dio/dio.dart';

import '../../models/api_response/UpdateUserInfoApiResponse.dart';
import '../../utils/api_constants/api_constants.dart';

class UpdateUserInfoPutApi {
  Future<UpdateUserInfoApiResponse> updateRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.put(ApiConstants.updateUserInfo,
          data: formData, options: Options(validateStatus: (status) {
            return status! <= 500;
          }));
      if (response.statusCode == 200) {
        return UpdateUserInfoApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return UpdateUserInfoApiResponse.fromJson(response.data);
      } else {
        return UpdateUserInfoApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return UpdateUserInfoApiResponse.fromJson(e.response?.data);
      } else {
        return UpdateUserInfoApiResponse();
      }
    }
  }
}