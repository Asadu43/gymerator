class GetWorkoutSummaryApiResponse {
  GetWorkoutSummaryApiResponse({
      Data? data, 
      String? message, 
      dynamic error,}){
    _data = data;
    _message = message;
    _error = error;
}

  GetWorkoutSummaryApiResponse.fromJson(dynamic json) {
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
      int? totalWorkouts, 
      int? totalCalories, 
      int? totalSets, 
      int? totalReps, 
      int? totalWeight, 
      int? averageCalories, 
      int? heartRateAvg,}){
    _totalWorkouts = totalWorkouts;
    _totalCalories = totalCalories;
    _totalSets = totalSets;
    _totalReps = totalReps;
    _totalWeight = totalWeight;
    _averageCalories = averageCalories;
    _heartRateAvg = heartRateAvg;
}

  Data.fromJson(dynamic json) {
    _totalWorkouts = json['totalWorkouts'];
    _totalCalories = json['totalCalories'];
    _totalSets = json['totalSets'];
    _totalReps = json['totalReps'];
    _totalWeight = json['totalWeight'];
    _averageCalories = json['averageCalories'];
    _heartRateAvg = json['heartRateAvg'];
  }
  int? _totalWorkouts;
  int? _totalCalories;
  int? _totalSets;
  int? _totalReps;
  int? _totalWeight;
  int? _averageCalories;
  int? _heartRateAvg;

  int? get totalWorkouts => _totalWorkouts;
  int? get totalCalories => _totalCalories;
  int? get totalSets => _totalSets;
  int? get totalReps => _totalReps;
  int? get totalWeight => _totalWeight;
  int? get averageCalories => _averageCalories;
  int? get heartRateAvg => _heartRateAvg;

}