class GetAllUserOrdersApiResponse {
  GetAllUserOrdersApiResponse({
    List<Data>? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  GetAllUserOrdersApiResponse.fromJson(dynamic json) {
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
    User? user,
    List<Products>? products,
    int? totalAmount,
    String? status,
    String? paymentMethod,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _id = id;
    _user = user;
    _products = products;
    _totalAmount = totalAmount;
    _status = status;
    _paymentMethod = paymentMethod;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
    _totalAmount = json['totalAmount'];
    _status = json['status'];
    _paymentMethod = json['paymentMethod'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  User? _user;
  List<Products>? _products;
  int? _totalAmount;
  String? _status;
  String? _paymentMethod;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get id => _id;
  User? get user => _user;
  List<Products>? get products => _products;
  int? get totalAmount => _totalAmount;
  String? get status => _status;
  String? get paymentMethod => _paymentMethod;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

}

class Products {
  Products({
    Product? product,
    List<String>? variants,
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
    _product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    _variants = json['variants'] != null ? json['variants'].cast<String>() : [];
    _quantity = json['quantity'];
    _unitPrice = json['unitPrice'];
    _total = json['total'];
    _id = json['_id'];
  }
  Product? _product;
  List<String>? _variants;
  int? _quantity;
  int? _unitPrice;
  int? _total;
  String? _id;

  Product? get product => _product;
  List<String>? get variants => _variants;
  int? get quantity => _quantity;
  int? get unitPrice => _unitPrice;
  int? get total => _total;
  String? get id => _id;

}

class Product {
  Product({
    String? id,
    String? name,
    String? description,
    int? price,
    int? stock,
    List<String>? images,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _price = price;
    _stock = stock;
    _images = images;
  }

  Product.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _stock = json['stock'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  String? _id;
  String? _name;
  String? _description;
  int? _price;
  int? _stock;
  List<String>? _images;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  int? get price => _price;
  int? get stock => _stock;
  List<String>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['stock'] = _stock;
    map['images'] = _images;
    return map;
  }
}

class User {
  User({
    String? id,
    String? firstName,
    String? email,
  }) {
    _id = id;
    _firstName = firstName;
    _email = email;
  }

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
    _email = json['email'];
  }
  String? _id;
  String? _firstName;
  String? _email;

  String? get id => _id;
  String? get firstName => _firstName;
  String? get email => _email;

}
