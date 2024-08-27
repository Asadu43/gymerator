class OrderPlaceApiResponse {
  OrderPlaceApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  OrderPlaceApiResponse.fromJson(dynamic json) {
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    map['error'] = _error;
    return map;
  }
}

class Data {
  Data({
    String? user,
    List<Products>? products,
    int? totalAmount,
    String? status,
    String? paymentMethod,
    String? id,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _user = user;
    _products = products;
    _totalAmount = totalAmount;
    _status = status;
    _paymentMethod = paymentMethod;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
    _totalAmount = json['totalAmount'];
    _status = json['status'];
    _paymentMethod = json['paymentMethod'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _user;
  List<Products>? _products;
  int? _totalAmount;
  String? _status;
  String? _paymentMethod;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get user => _user;
  List<Products>? get products => _products;
  int? get totalAmount => _totalAmount;
  String? get status => _status;
  String? get paymentMethod => _paymentMethod;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = _user;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['totalAmount'] = _totalAmount;
    map['status'] = _status;
    map['paymentMethod'] = _paymentMethod;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}

class Products {
  Products({
    String? product,
    int? quantity,
    int? unitPrice,
    int? total,
    String? id,
  }) {
    _product = product;
    _quantity = quantity;
    _unitPrice = unitPrice;
    _total = total;
    _id = id;
  }

  Products.fromJson(dynamic json) {
    _product = json['product'];
    _quantity = json['quantity'];
    _unitPrice = json['unitPrice'];
    _total = json['total'];
    _id = json['_id'];
  }
  String? _product;
  int? _quantity;
  int? _unitPrice;
  int? _total;
  String? _id;

  String? get product => _product;
  int? get quantity => _quantity;
  int? get unitPrice => _unitPrice;
  int? get total => _total;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product'] = _product;
    map['quantity'] = _quantity;
    map['unitPrice'] = _unitPrice;
    map['total'] = _total;
    map['_id'] = _id;
    return map;
  }
}
