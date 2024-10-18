import 'package:gymmerator/models/api_response/Product.dart';

class FeaturedProductApiResponse {
  FeaturedProductApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  FeaturedProductApiResponse.fromJson(dynamic json) {
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
    List<Product>? updatedHotProducts,
    List<Product>? updatedFeaturedProducts,
  }) {
    _updatedHotProducts = updatedHotProducts;
    _updatedFeaturedProducts = updatedFeaturedProducts;
  }

  Data.fromJson(dynamic json) {
    if (json['updatedHotProducts'] != null) {
      _updatedHotProducts = [];
      json['updatedHotProducts'].forEach((v) {
        _updatedHotProducts?.add(Product.fromJson(v));
      });
    }
    if (json['updatedFeaturedProducts'] != null) {
      _updatedFeaturedProducts = [];
      json['updatedFeaturedProducts'].forEach((v) {
        _updatedFeaturedProducts?.add(Product.fromJson(v));
      });
    }
  }

  List<Product>? _updatedHotProducts;
  List<Product>? _updatedFeaturedProducts;

  List<Product>? get updatedHotProducts => _updatedHotProducts;

  List<Product>? get updatedFeaturedProducts => _updatedFeaturedProducts;
}
