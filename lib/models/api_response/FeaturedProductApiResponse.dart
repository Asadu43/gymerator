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
    List<Product>? featuredProducts,
    List<Product>? hotProducts,
  }) {
    _featuredProducts = featuredProducts;
    _hotProducts = hotProducts;
  }

  Data.fromJson(dynamic json) {
    if (json['updatedFeaturedProducts'] != null) {
      _featuredProducts = [];
      json['updatedFeaturedProducts'].forEach((v) {
        _featuredProducts?.add(Product.fromJson(v));
      });
    }
    if (json['updatedHotProducts'] != null) {
      _hotProducts = [];
      json['updatedHotProducts'].forEach((v) {
        _hotProducts?.add(Product.fromJson(v));
      });
    }
  }
  List<Product>? _featuredProducts;
  List<Product>? _hotProducts;

  List<Product>? get featuredProducts => _featuredProducts;
  List<Product>? get hotProducts => _hotProducts;
}
