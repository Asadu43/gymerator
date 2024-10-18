class AcceptWorkoutPlanApiResponse {
  AcceptWorkoutPlanApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  AcceptWorkoutPlanApiResponse.fromJson(dynamic json) {
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
    String? user,
    List<WorkoutPlan>? workoutPlan,
    bool? isAccepted,
    String? id,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _user = user;
    _workoutPlan = workoutPlan;
    _isAccepted = isAccepted;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'];
    if (json['workoutPlan'] != null) {
      _workoutPlan = [];
      json['workoutPlan'].forEach((v) {
        _workoutPlan?.add(WorkoutPlan.fromJson(v));
      });
    }
    _isAccepted = json['isAccepted'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }

  String? _user;
  List<WorkoutPlan>? _workoutPlan;
  bool? _isAccepted;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get user => _user;

  List<WorkoutPlan>? get workoutPlan => _workoutPlan;

  bool? get isAccepted => _isAccepted;

  String? get id => _id;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  int? get v => _v;
}

class WorkoutPlan {
  WorkoutPlan({
    String? day,
    List<Exercises>? exercises,
    bool? restDay,
    String? id,
  }) {
    _day = day;
    _exercises = exercises;
    _restDay = restDay;
    _id = id;
  }

  WorkoutPlan.fromJson(dynamic json) {
    _day = json['day'];
    if (json['exercises'] != null) {
      _exercises = [];
      json['exercises'].forEach((v) {
        _exercises?.add(Exercises.fromJson(v));
      });
    }
    _restDay = json['rest_day'];
    _id = json['_id'];
  }

  String? _day;
  List<Exercises>? _exercises;
  bool? _restDay;
  String? _id;

  String? get day => _day;

  List<Exercises>? get exercises => _exercises;

  bool? get restDay => _restDay;

  String? get id => _id;
}

class Exercises {
  Exercises({
    String? exercise,
    String? sets,
    String? reps,
    String? rest,
    String? id,
  }) {
    _exercise = exercise;
    _sets = sets;
    _reps = reps;
    _rest = rest;
    _id = id;
  }

  Exercises.fromJson(dynamic json) {
    _exercise = json['exercise'];
    _sets = json['sets'];
    _reps = json['reps'];
    _rest = json['rest'];
    _id = json['_id'];
  }

  String? _exercise;
  String? _sets;
  String? _reps;
  String? _rest;
  String? _id;

  String? get exercise => _exercise;

  String? get sets => _sets;

  String? get reps => _reps;

  String? get rest => _rest;

  String? get id => _id;
}
