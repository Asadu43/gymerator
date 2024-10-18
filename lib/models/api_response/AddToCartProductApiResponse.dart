class AddToCartProductApiResponse {
  AddToCartProductApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  AddToCartProductApiResponse.fromJson(dynamic json) {
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
    String? id,
    String? user,
    int? v,
    String? createdAt,
    int? discount,
    List<Items>? items,
    int? subTotal,
    int? tax,
    int? total,
    String? updatedAt,
  }) {
    _id = id;
    _user = user;
    _v = v;
    _createdAt = createdAt;
    _discount = discount;
    _items = items;
    _subTotal = subTotal;
    _tax = tax;
    _total = total;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _v = json['__v'];
    _createdAt = json['createdAt'];
    _discount = json['discount'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _subTotal = json['subTotal'];
    _tax = json['tax'];
    _total = json['total'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _user;
  int? _v;
  String? _createdAt;
  int? _discount;
  List<Items>? _items;
  int? _subTotal;
  int? _tax;
  int? _total;
  String? _updatedAt;

  String? get id => _id;

  String? get user => _user;

  int? get v => _v;

  String? get createdAt => _createdAt;

  int? get discount => _discount;

  List<Items>? get items => _items;

  int? get subTotal => _subTotal;

  int? get tax => _tax;

  int? get total => _total;

  String? get updatedAt => _updatedAt;
}

class Items {
  Items({
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

  Items.fromJson(dynamic json) {
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
}
