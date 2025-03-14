class GetNotificationsApiResponse {
  GetNotificationsApiResponse({
    List<Data>? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  GetNotificationsApiResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
    _error = json['error'];
  }
  List<Data>? _data;
  String? _message;
  dynamic _error;

  List<Data>? get data => _data;
  String? get message => _message;
  dynamic get error => _error;
}

class Data {
  Data({
    String? id,
    String? userId,
    String? tittle,
    String? message,
    PayLoadData? data,
    dynamic fileName,
    String? status,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _id = id;
    _userId = userId;
    _tittle = tittle;
    _message = message;
    _data = data;
    _fileName = fileName;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _tittle = json['tittle'];
    _message = json['message'];
    _data = json['data'] != null ? PayLoadData.fromJson(json['data']) : null;
    _fileName = json['fileName'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _userId;
  String? _tittle;
  String? _message;
  PayLoadData? _data;
  dynamic _fileName;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get id => _id;
  String? get userId => _userId;
  String? get tittle => _tittle;
  String? get message => _message;
  PayLoadData? get data => _data;
  dynamic get fileName => _fileName;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;
}

class PayLoadData {
  PayLoadData({
    String? order,
    String? total,
  }) {
    _order = order;
    _total = total;
  }

  PayLoadData.fromJson(dynamic json) {
    // _order = json['order'];
    // _total = json['total'];
  }
  String? _order;
  String? _total;

  String? get order => _order;
  String? get total => _total;
}
