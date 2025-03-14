import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/DeviceRegisterApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class DeviceRegisterPostApi {
  Future<DeviceRegisterApiResponse> registerRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.post(ApiConstants.registerDevice,
          data: formData, options: Options(validateStatus: (status) {
            return status! <= 500;
          }));
      print(response.statusCode);
      print(response.data);
      print("response Data of Device");
      if (response.statusCode == 200) {
        return DeviceRegisterApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return DeviceRegisterApiResponse.fromJson(response.data);
      } else {
        return DeviceRegisterApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return DeviceRegisterApiResponse.fromJson(e.response?.data);
      } else {
        return DeviceRegisterApiResponse();
      }
    }
  }
}
