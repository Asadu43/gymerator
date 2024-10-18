class CreateOrderApiResponse {
  CreateOrderApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  CreateOrderApiResponse.fromJson(dynamic json) {
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
    String? user,
    List<Products>? products,
    double? totalAmount,
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
  double? _totalAmount;
  String? _status;
  String? _paymentMethod;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get user => _user;

  List<Products>? get products => _products;

  double? get totalAmount => _totalAmount;

  String? get status => _status;

  String? get paymentMethod => _paymentMethod;

  String? get id => _id;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  int? get v => _v;
}

class Products {
  Products({
    String? product,
    List<dynamic>? variants,
    int? quantity,
    int? unitPrice,
    int? total,
    String? id,
  }) {
    _product = product;
    _variants = variants;
    _quantity = quantity;
    _unitPrice = unitPrice;
    _total = total;
    _id = id;
  }

  Products.fromJson(dynamic json) {
    _product = json['product'];
    if (json['variants'] != null) {
      _variants = [];
      json['variants'].forEach((v) {
        _variants?.add(v);
      });
    }
    _quantity = json['quantity'];
    _unitPrice = json['unitPrice'];
    _total = json['total'];
    _id = json['_id'];
  }

  String? _product;
  List<dynamic>? _variants;
  int? _quantity;
  int? _unitPrice;
  int? _total;
  String? _id;

  String? get product => _product;

  List<dynamic>? get variants => _variants;

  int? get quantity => _quantity;

  int? get unitPrice => _unitPrice;

  int? get total => _total;

  String? get id => _id;
}
