class GetAllUserOrdersApiResponse {
  GetAllUserOrdersApiResponse({
      this.data, 
      this.message, 
      this.error,});

  GetAllUserOrdersApiResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }
  List<Data>? data;
  String? message;
  dynamic error;

}

class Data {
  Data({
      this.id, 
      this.user, 
      this.products, 
      this.totalAmount, 
      this.status, 
      this.paymentMethod, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  User? user;
  List<Products>? products;
  num? totalAmount;
  String? status;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;
  num? v;

}

class Products {
  Products({
      this.product, 
      this.variants, 
      this.quantity, 
      this.unitPrice, 
      this.total, 
      this.id,});

  Products.fromJson(dynamic json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    variants = json['variants'] != null ? json['variants'].cast<String>() : [];
    quantity = json['quantity'];
    unitPrice = _convertToDouble(json['unitPrice']);
    total = _convertToDouble(json['total']);
    id = json['_id'];
  }

  // Method to convert a dynamic value to a double
  static double? _convertToDouble(dynamic val) {
    if (val == null) {
      return null;
    }
    if (val is int) {
      return val.toDouble();
    } else if (val is double) {
      return val;
    } else if (val is String) {
      return double.tryParse(val);
    } else {
      throw ArgumentError('Unsupported type: ${val.runtimeType}');
    }
  }
  Product? product;
  List<String>? variants;
  num? quantity;
  num? unitPrice;
  num? total;
  String? id;
}

class Product {
  Product({
      this.id, 
      this.name, 
      this.description, 
      this.price, 
      this.stock, 
      this.images,});

  Product.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  String? id;
  String? name;
  String? description;
  num? price;
  num? stock;
  List<String>? images;

}

class User {
  User({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.profile,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    profile = json['profile'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profile;

}