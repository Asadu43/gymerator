import 'package:dio/dio.dart';
import 'package:gymmerator/models/api_response/ChatAiApiResponse.dart';

class ChatBotPostApi {
  Future<ChatAiApiResponse> chatRequest(Map formData) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.post("http://chat.gymerator.fit/ask",
          data: formData, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
      if (response.statusCode == 200) {
        return ChatAiApiResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return ChatAiApiResponse.fromJson(response.data);
      } else {
        return ChatAiApiResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return ChatAiApiResponse.fromJson(e.response?.data);
      } else {
        return ChatAiApiResponse();
      }
    }
  }
}
