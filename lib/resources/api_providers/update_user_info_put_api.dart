


import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/UpdateUserInfoApiResponse.dart';
import '../../utils/api_constants/api_constants.dart';

class UpdateUserInfoPutApi {
  Future<UpdateUserInfoApiResponse> updateRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.post(ApiConstants.updateUserInfo,
          data: formData, options: Options(validateStatus: (status) {
            return status! <= 500;
          }));

      print(response.data);
      print(response.headers["x-auth-token"]!.first);

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