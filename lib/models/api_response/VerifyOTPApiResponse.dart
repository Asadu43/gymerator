class VerifyOtpApiResponse {
  VerifyOtpApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  VerifyOtpApiResponse.fromJson(dynamic json) {
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
    bool? otpVerified,
  }) {
    _otpVerified = otpVerified;
  }

  Data.fromJson(dynamic json) {
    _otpVerified = json['otpVerified'];
  }

  bool? _otpVerified;

  bool? get otpVerified => _otpVerified;
}
