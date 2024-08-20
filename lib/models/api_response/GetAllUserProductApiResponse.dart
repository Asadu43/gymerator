class GetAllUserProductApiResponse {
  GetAllUserProductApiResponse({
      Data? data, 
      String? message, 
      dynamic error,}){
    _data = data;
    _message = message;
    _error = error;
}

  GetAllUserProductApiResponse.fromJson(dynamic json) {
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
    double? discount,
    List<Items>? items,
    double? subTotal,
    int? tax,
    double? total,
    String? updatedAt,}){
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
    _discount = (json['discount'] as num).toDouble();
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _subTotal = (json['subTotal']as num).toDouble();
    _tax = json['tax'];
    _total = (json['total']as num).toDouble();
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _user;
  int? _v;
  String? _createdAt;
  double? _discount;
  List<Items>? _items;
  double? _subTotal;
  int? _tax;
  double? _total;
  String? _updatedAt;

  String? get id => _id;
  String? get user => _user;
  int? get v => _v;
  String? get createdAt => _createdAt;
  double? get discount => _discount;
  List<Items>? get items => _items;
  double? get subTotal => _subTotal;
  int? get tax => _tax;
  double? get total => _total;
  String? get updatedAt => _updatedAt;

}

class Items {
  Items({
    Product? product,
    List<Variants>? variants,
    int? quantity,
    int? unitPrice,
    int? total,
    String? id,}){
    _product = product;
    _variants = variants;
    _quantity = quantity;
    _unitPrice = unitPrice;
    _total = total;
    _id = id;
  }

  Items.fromJson(dynamic json) {
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['variants'] != null) {
      _variants = [];
      json['variants'].forEach((v) {
        _variants?.add(Variants.fromJson(v));
      });
    }
    _quantity = json['quantity'];
    _unitPrice = json['unitPrice'];
    _total = json['total'];
    _id = json['_id'];
  }
  Product? _product;
  List<Variants>? _variants;
  int? _quantity;
  int? _unitPrice;
  int? _total;
  String? _id;

  Product? get product => _product;
  List<Variants>? get variants => _variants;
  int? get quantity => _quantity;
  int? get unitPrice => _unitPrice;
  int? get total => _total;
  String? get id => _id;

}

class Variants {
  Variants({
    String? id,
    String? variantType,
    String? variant,
    int? v,}){
    _id = id;
    _variantType = variantType;
    _variant = variant;
    _v = v;
  }

  Variants.fromJson(dynamic json) {
    _id = json['_id'];
    _variantType = json['variantType'];
    _variant = json['variant'];
    _v = json['__v'];
  }
  String? _id;
  String? _variantType;
  String? _variant;
  int? _v;

  String? get id => _id;
  String? get variantType => _variantType;
  String? get variant => _variant;
  int? get v => _v;
}

class Product {
  Product({
    String? id,
    String? name,
    String? description,
    int? price,
    int? stock,
    List<String>? images,}){
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
}