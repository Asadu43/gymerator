class DeviceRegisterApiResponse {
  DeviceRegisterApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  DeviceRegisterApiResponse.fromJson(dynamic json) {
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
    String? userId,
    String? token,
    String? deviceType,
    String? id,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _userId = userId;
    _token = token;
    _deviceType = deviceType;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _userId = json['userId'];
    _token = json['token'];
    _deviceType = json['deviceType'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _userId;
  String? _token;
  String? _deviceType;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get userId => _userId;
  String? get token => _token;
  String? get deviceType => _deviceType;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;
}
