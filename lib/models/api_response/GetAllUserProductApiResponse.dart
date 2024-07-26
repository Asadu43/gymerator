import 'Product.dart';

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
      int? discount, 
      List<Items>? items, 
      int? subTotal, 
      int? tax, 
      int? total, 
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
      Product? product, 
      int? quantity, 
      int? unitPrice, 
      int? total, 
      String? id,}){
    _product = product;
    _quantity = quantity;
    _unitPrice = unitPrice;
    _total = total;
    _id = id;
}

  Items.fromJson(dynamic json) {
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    _quantity = json['quantity'];
    _unitPrice = json['unitPrice'];
    _total = json['total'];
    _id = json['_id'];
  }
  Product? _product;
  int? _quantity;
  int? _unitPrice;
  int? _total;
  String? _id;

  Product? get product => _product;
  int? get quantity => _quantity;
  int? get unitPrice => _unitPrice;
  int? get total => _total;
  String? get id => _id;


}

// class Product {
//   Product({
//       String? id,
//       String? name,
//       String? description,
//       int? price,
//       String? sku,
//       int? stock,
//       bool? isAvailable,
//       String? category,
//       List<String>? tags,
//       List<String>? images,
//       int? averageRating,
//       List<dynamic>? relatedProducts,
//       String? metaTitle,
//       String? metaDescription,
//       List<dynamic>? variants,
//       List<dynamic>? reviews,
//       List<dynamic>? discounts,
//       String? createdAt,
//       String? updatedAt,
//       int? v,}){
//     _id = id;
//     _name = name;
//     _description = description;
//     _price = price;
//     _sku = sku;
//     _stock = stock;
//     _isAvailable = isAvailable;
//     _category = category;
//     _tags = tags;
//     _images = images;
//     _averageRating = averageRating;
//     _relatedProducts = relatedProducts;
//     _metaTitle = metaTitle;
//     _metaDescription = metaDescription;
//     _variants = variants;
//     _reviews = reviews;
//     _discounts = discounts;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _v = v;
// }
//
//   Product.fromJson(dynamic json) {
//     _id = json['_id'];
//     _name = json['name'];
//     _description = json['description'];
//     _price = json['price'];
//     _sku = json['sku'];
//     _stock = json['stock'];
//     _isAvailable = json['isAvailable'];
//     _category = json['category'];
//     _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
//     _images = json['images'] != null ? json['images'].cast<String>() : [];
//     _averageRating = json['averageRating'];
//     if (json['relatedProducts'] != null) {
//       _relatedProducts = [];
//       json['relatedProducts'].forEach((v) {
//         _relatedProducts?.add(Dynamic.fromJson(v));
//       });
//     }
//     _metaTitle = json['metaTitle'];
//     _metaDescription = json['metaDescription'];
//     if (json['variants'] != null) {
//       _variants = [];
//       json['variants'].forEach((v) {
//         _variants?.add(Dynamic.fromJson(v));
//       });
//     }
//     if (json['reviews'] != null) {
//       _reviews = [];
//       json['reviews'].forEach((v) {
//         _reviews?.add(Dynamic.fromJson(v));
//       });
//     }
//     if (json['discounts'] != null) {
//       _discounts = [];
//       json['discounts'].forEach((v) {
//         _discounts?.add(Dynamic.fromJson(v));
//       });
//     }
//     _createdAt = json['createdAt'];
//     _updatedAt = json['updatedAt'];
//     _v = json['__v'];
//   }
//   String? _id;
//   String? _name;
//   String? _description;
//   int? _price;
//   String? _sku;
//   int? _stock;
//   bool? _isAvailable;
//   String? _category;
//   List<String>? _tags;
//   List<String>? _images;
//   int? _averageRating;
//   List<dynamic>? _relatedProducts;
//   String? _metaTitle;
//   String? _metaDescription;
//   List<dynamic>? _variants;
//   List<dynamic>? _reviews;
//   List<dynamic>? _discounts;
//   String? _createdAt;
//   String? _updatedAt;
//   int? _v;
//
//   String? get id => _id;
//   String? get name => _name;
//   String? get description => _description;
//   int? get price => _price;
//   String? get sku => _sku;
//   int? get stock => _stock;
//   bool? get isAvailable => _isAvailable;
//   String? get category => _category;
//   List<String>? get tags => _tags;
//   List<String>? get images => _images;
//   int? get averageRating => _averageRating;
//   List<dynamic>? get relatedProducts => _relatedProducts;
//   String? get metaTitle => _metaTitle;
//   String? get metaDescription => _metaDescription;
//   List<dynamic>? get variants => _variants;
//   List<dynamic>? get reviews => _reviews;
//   List<dynamic>? get discounts => _discounts;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   int? get v => _v;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = _id;
//     map['name'] = _name;
//     map['description'] = _description;
//     map['price'] = _price;
//     map['sku'] = _sku;
//     map['stock'] = _stock;
//     map['isAvailable'] = _isAvailable;
//     map['category'] = _category;
//     map['tags'] = _tags;
//     map['images'] = _images;
//     map['averageRating'] = _averageRating;
//     if (_relatedProducts != null) {
//       map['relatedProducts'] = _relatedProducts?.map((v) => v.toJson()).toList();
//     }
//     map['metaTitle'] = _metaTitle;
//     map['metaDescription'] = _metaDescription;
//     if (_variants != null) {
//       map['variants'] = _variants?.map((v) => v.toJson()).toList();
//     }
//     if (_reviews != null) {
//       map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
//     }
//     if (_discounts != null) {
//       map['discounts'] = _discounts?.map((v) => v.toJson()).toList();
//     }
//     map['createdAt'] = _createdAt;
//     map['updatedAt'] = _updatedAt;
//     map['__v'] = _v;
//     return map;
//   }
//
// }