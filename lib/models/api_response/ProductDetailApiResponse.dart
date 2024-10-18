import 'package:gymmerator/models/api_response/Product.dart';

class ProductDetailApiResponse {
  ProductDetailApiResponse({
    this.data,
    this.message,
    this.error,
  });

  ProductDetailApiResponse.fromJson(dynamic json) {
    data = json['data'] != null ? Product.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'];
  }

  Product? data;
  String? message;
  dynamic error;
}
