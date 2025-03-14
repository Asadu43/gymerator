class GetRewardSignatureApiResponse {
  GetRewardSignatureApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  GetRewardSignatureApiResponse.fromJson(dynamic json) {
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
    String? signature,
    int? rewardAmount,
    String? message,
    int? nonce,
  }) {
    _signature = signature;
    _rewardAmount = rewardAmount;
    _message = message;
    _nonce = nonce;
  }

  Data.fromJson(dynamic json) {
    _signature = json['signature'];
    _rewardAmount = json['rewardAmount'];
    _message = json['message'];
    _nonce = json['nonce'];
  }
  String? _signature;
  int? _rewardAmount;
  String? _message;
  int? _nonce;

  String? get signature => _signature;
  int? get rewardAmount => _rewardAmount;
  String? get message => _message;
  int? get nonce => _nonce;
}
