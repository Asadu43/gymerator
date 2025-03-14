import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/DeviceRemoveApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class DeviceRemoveDeleteApi {
  Future<DeviceRemoveApiResponse> deleteRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.delete(ApiConstants.registerDevice,
          options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      print(response.statusCode);
      print(response.data);
      print("response Data of Device");
      if (response.statusCode == 200) {
        return DeviceRemoveApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return DeviceRemoveApiResponse.fromJson(response.data);
      } else {
        return DeviceRemoveApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return DeviceRemoveApiResponse.fromJson(e.response?.data);
      } else {
        return DeviceRemoveApiResponse();
      }
    }
  }
}
