class ForgetPasswordApiResponse {
  ForgetPasswordApiResponse({
    dynamic data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  ForgetPasswordApiResponse.fromJson(dynamic json) {
    _data = json['data'];
    _message = json['message'];
    _error = json['error'];
  }
  dynamic _data;
  String? _message;
  dynamic _error;

  dynamic get data => _data;
  String? get message => _message;
  dynamic get error => _error;
}
