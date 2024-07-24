import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/FeaturedProductApiResponse.dart';

import '../../utils/api_constants/api_constants.dart';

class FeaturedProductGetApi {
  Future<FeaturedProductApiResponse> featuredRequest() async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.get(ApiConstants.featuredProduct);
      if (response.statusCode == 200) {
        return FeaturedProductApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return FeaturedProductApiResponse.fromJson(response.data);
      } else {
        return FeaturedProductApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        return FeaturedProductApiResponse.fromJson(e.response?.data);
      } else {
        return FeaturedProductApiResponse();
      }
    }
  }
}
