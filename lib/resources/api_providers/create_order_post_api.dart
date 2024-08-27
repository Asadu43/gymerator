import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/CreateOrderApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class CreateOrderPostApi {
  Future<CreateOrderApiResponse> createRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.post(ApiConstants.createOrder,
          data: formData, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      print(response.statusCode);
      print(response.data);
      print("response.data");
      if (response.statusCode == 200) {
        return CreateOrderApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return CreateOrderApiResponse.fromJson(response.data);
      } else {
        return CreateOrderApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return CreateOrderApiResponse.fromJson(e.response?.data);
      } else {
        return CreateOrderApiResponse();
      }
    }
  }
}
