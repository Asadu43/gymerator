class DeviceRemoveApiResponse {
  DeviceRemoveApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  DeviceRemoveApiResponse.fromJson(dynamic json) {
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
    bool? acknowledged,
    int? deletedCount,
  }) {
    _acknowledged = acknowledged;
    _deletedCount = deletedCount;
  }

  Data.fromJson(dynamic json) {
    _acknowledged = json['acknowledged'];
    _deletedCount = json['deletedCount'];
  }
  bool? _acknowledged;
  int? _deletedCount;

  bool? get acknowledged => _acknowledged;
  int? get deletedCount => _deletedCount;
}
