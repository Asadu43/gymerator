import 'Product.dart';

class GetAllProductApiResponse {
  GetAllProductApiResponse({
    List<Product>? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  GetAllProductApiResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Product.fromJson(v));
      });
    }
    _message = json['message'];
    _error = json['error'];
  }
  List<Product>? _data;
  String? _message;
  dynamic _error;

  List<Product>? get data => _data;
  String? get message => _message;
  dynamic get error => _error;
}
