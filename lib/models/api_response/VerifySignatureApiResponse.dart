class VerifySignatureApiResponse {
  VerifySignatureApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  VerifySignatureApiResponse.fromJson(dynamic json) {
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
  Data({String? email, String? walletAddress}) {
    _email = email;
    _walletAddress = walletAddress;
  }

  Data.fromJson(dynamic json) {
    _email = json['email'];
    _walletAddress = json['walletAddress'];
  }

  String? _email;
  String? _walletAddress;

  String? get email => _email;
  String? get walletAddress => _walletAddress;
}
