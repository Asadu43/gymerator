class TotalBurnedCaloriesApiResponse {
  TotalBurnedCaloriesApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  TotalBurnedCaloriesApiResponse.fromJson(dynamic json) {
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
    int? totalCalories,
  }) {
    _id = id;
    _totalCalories = totalCalories;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _totalCalories = json['totalCalories'];
  }
  String? _id;
  int? _totalCalories;

  String? get id => _id;
  int? get totalCalories => _totalCalories;
}
