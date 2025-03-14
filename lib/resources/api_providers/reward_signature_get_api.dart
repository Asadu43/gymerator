import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetRewardSignatureApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class RewardSignatureGetApi {
  Future<GetRewardSignatureApiResponse> getRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(ApiConstants.getSignatureReward);
      print(response.data);
      if (response.statusCode == 200) {
        print(response.statusMessage);
        return GetRewardSignatureApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return GetRewardSignatureApiResponse.fromJson(response.data);
      } else {
        return GetRewardSignatureApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return GetRewardSignatureApiResponse.fromJson(e.response?.data);
      } else {
        return GetRewardSignatureApiResponse();
      }
    }
  }
}
