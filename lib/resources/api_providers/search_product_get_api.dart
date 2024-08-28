import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/SearchProductApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class SearchProductGetApi {
  Future<SearchProductApiResponse> searchRequest(String id) async {

    print("id\n\n\n\n");
    print(id);
    print("id\n\n\n\n");
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response =
          await dio.get(ApiConstants.searchProduct, queryParameters: {
        'query': id,
      }, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));

      print(response.data);
      if (response.statusCode == 200) {
        return SearchProductApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return SearchProductApiResponse.fromJson(response.data);
      } else {
        return SearchProductApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return SearchProductApiResponse.fromJson(e.response?.data);
      } else {
        return SearchProductApiResponse();
      }
    }
  }
}
