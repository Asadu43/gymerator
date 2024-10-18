class ChatAiApiResponse {
  ChatAiApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  ChatAiApiResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
    _error = json['error'];
  }

  Data? _data;
  String? _message;
  dynamic _error;

  Data? get data => _data;

  String? get message => _message;

  dynamic get error => _error;
}

class Data {
  Data({
    String? userInput,
    String? response,
  }) {
    _userInput = userInput;
    _response = response;
  }

  Data.fromJson(dynamic json) {
    _userInput = json['user_input'];
    _response = json['response'];
  }

  String? _userInput;
  String? _response;

  String? get userInput => _userInput;

  String? get response => _response;
}
