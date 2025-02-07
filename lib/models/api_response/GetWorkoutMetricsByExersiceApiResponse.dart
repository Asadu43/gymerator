class GetWorkoutMetricsByExersiceApiResponse {
  GetWorkoutMetricsByExersiceApiResponse({
    List<Data>? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  GetWorkoutMetricsByExersiceApiResponse.fromJson(dynamic json) {
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
    String? id,
    String? user,
    String? day,
    String? exercise,
    int? setsCompleted,
    int? repsCompleted,
    int? weightUsed,
    int? caloriesBurned,
    int? heartRateAvg,
    int? distanceCovered,
    int? pace,
    bool? personalRecord,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _id = id;
    _user = user;
    _day = day;
    _exercise = exercise;
    _setsCompleted = setsCompleted;
    _repsCompleted = repsCompleted;
    _weightUsed = weightUsed;
    _caloriesBurned = caloriesBurned;
    _heartRateAvg = heartRateAvg;
    _distanceCovered = distanceCovered;
    _pace = pace;
    _personalRecord = personalRecord;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _day = json['day'];
    _exercise = json['exercise'];
    _setsCompleted = json['setsCompleted'];
    _repsCompleted = json['repsCompleted'];
    _weightUsed = json['weightUsed'];
    _caloriesBurned = json['caloriesBurned'];
    _heartRateAvg = json['heartRateAvg'];
    _distanceCovered = json['distanceCovered'];
    _pace = json['pace'];
    _personalRecord = json['personalRecord'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _user;
  String? _day;
  String? _exercise;
  int? _setsCompleted;
  int? _repsCompleted;
  int? _weightUsed;
  int? _caloriesBurned;
  int? _heartRateAvg;
  int? _distanceCovered;
  int? _pace;
  bool? _personalRecord;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get id => _id;
  String? get user => _user;
  String? get day => _day;
  String? get exercise => _exercise;
  int? get setsCompleted => _setsCompleted;
  int? get repsCompleted => _repsCompleted;
  int? get weightUsed => _weightUsed;
  int? get caloriesBurned => _caloriesBurned;
  int? get heartRateAvg => _heartRateAvg;
  int? get distanceCovered => _distanceCovered;
  int? get pace => _pace;
  bool? get personalRecord => _personalRecord;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;
}
