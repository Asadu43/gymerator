class GenerateWorkoutPlanApiResponse {
  GenerateWorkoutPlanApiResponse({
      List<Data>? data, 
      String? message, 
      dynamic error,}){
    _data = data;
    _message = message;
    _error = error;
}

  GenerateWorkoutPlanApiResponse.fromJson(dynamic json) {
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
      String? day, 
      List<Exercises>? exercises, 
      bool? restDay,}){
    _day = day;
    _exercises = exercises;
    _restDay = restDay;
}

  Data.fromJson(dynamic json) {
    _day = json['day'];
    if (json['exercises'] != null) {
      _exercises = [];
      json['exercises'].forEach((v) {
        _exercises?.add(Exercises.fromJson(v));
      });
    }
    _restDay = json['rest_day'];
  }
  String? _day;
  List<Exercises>? _exercises;
  bool? _restDay;

  String? get day => _day;
  List<Exercises>? get exercises => _exercises;
  bool? get restDay => _restDay;
}

class Exercises {
  Exercises({
      String? exercise, 
      String? sets, 
      String? reps, 
      String? rest,}){
    _exercise = exercise;
    _sets = sets;
    _reps = reps;
    _rest = rest;
}

  Exercises.fromJson(dynamic json) {
    _exercise = json['exercise'];
    _sets = json['sets'];
    _reps = json['reps'];
    _rest = json['rest'];
  }
  String? _exercise;
  String? _sets;
  String? _reps;
  String? _rest;

  String? get exercise => _exercise;
  String? get sets => _sets;
  String? get reps => _reps;
  String? get rest => _rest;

}