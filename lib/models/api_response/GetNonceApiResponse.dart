class GetNonceApiResponse {
  GetNonceApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  GetNonceApiResponse.fromJson(dynamic json) {
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
    int? nonce,
    bool? isUsed,
    String? id,
    int? v,
  }) {
    _nonce = nonce;
    _isUsed = isUsed;
    _id = id;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _nonce = json['nonce'];
    _isUsed = json['isUsed'];
    _id = json['_id'];
    _v = json['__v'];
  }
  int? _nonce;
  bool? _isUsed;
  String? _id;
  int? _v;

  int? get nonce => _nonce;
  bool? get isUsed => _isUsed;
  String? get id => _id;
  int? get v => _v;
}
