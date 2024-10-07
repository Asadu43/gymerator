class GetWorkoutPlanApiResponse {
  GetWorkoutPlanApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  GetWorkoutPlanApiResponse.fromJson(dynamic json) {
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
    String? user,
    WorkoutPlan? workoutPlan,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _id = id;
    _user = user;
    _workoutPlan = workoutPlan;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _workoutPlan = json['workoutPlan'] != null
        ? WorkoutPlan.fromJson(json['workoutPlan'])
        : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _user;
  WorkoutPlan? _workoutPlan;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get id => _id;
  String? get user => _user;
  WorkoutPlan? get workoutPlan => _workoutPlan;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;
}

class WorkoutPlan {
  WorkoutPlan({
    String? id,
    Monday? monday,
    Tuesday? tuesday,
    Wednesday? wednesday,
    Thursday? thursday,
    Friday? friday,
    Saturday? saturday,
    Sunday? sunday,
  }) {
    _id = id;
    _monday = monday;
    _tuesday = tuesday;
    _wednesday = wednesday;
    _thursday = thursday;
    _friday = friday;
    _saturday = saturday;
    _sunday = sunday;
  }

  WorkoutPlan.fromJson(dynamic json) {
    _id = json['_id'];
    _monday = json['monday'] != null ? Monday.fromJson(json['monday']) : null;
    _tuesday =
        json['tuesday'] != null ? Tuesday.fromJson(json['tuesday']) : null;
    _wednesday = json['wednesday'] != null
        ? Wednesday.fromJson(json['wednesday'])
        : null;
    _thursday =
        json['thursday'] != null ? Thursday.fromJson(json['thursday']) : null;
    _friday = json['friday'] != null ? Friday.fromJson(json['friday']) : null;
    _saturday =
        json['saturday'] != null ? Saturday.fromJson(json['saturday']) : null;
    _sunday = json['sunday'] != null ? Sunday.fromJson(json['sunday']) : null;
  }
  String? _id;
  Monday? _monday;
  Tuesday? _tuesday;
  Wednesday? _wednesday;
  Thursday? _thursday;
  Friday? _friday;
  Saturday? _saturday;
  Sunday? _sunday;

  String? get id => _id;
  Monday? get monday => _monday;
  Tuesday? get tuesday => _tuesday;
  Wednesday? get wednesday => _wednesday;
  Thursday? get thursday => _thursday;
  Friday? get friday => _friday;
  Saturday? get saturday => _saturday;
  Sunday? get sunday => _sunday;
}

class Sunday {
  Sunday({
    List<Exercises>? exercises,
    bool? restDay,
    String? id,
  }) {
    _exercises = exercises;
    _restDay = restDay;
    _id = id;
  }

  Sunday.fromJson(dynamic json) {
    if (json['exercises'] != null) {
      _exercises = [];
      json['exercises'].forEach((v) {
        _exercises?.add(Exercises.fromJson(v));
      });
    }
    _restDay = json['rest_day'];
    _id = json['_id'];
  }
  List<Exercises>? _exercises;
  bool? _restDay;
  String? _id;

  List<Exercises>? get exercises => _exercises;
  bool? get restDay => _restDay;
  String? get id => _id;
}

class Saturday {
  Saturday({
    List<Exercises>? exercises,
    bool? restDay,
    String? id,
  }) {
    _exercises = exercises;
    _restDay = restDay;
    _id = id;
  }

  Saturday.fromJson(dynamic json) {
    if (json['exercises'] != null) {
      _exercises = [];
      json['exercises'].forEach((v) {
        _exercises?.add(Exercises.fromJson(v));
      });
    }
    _restDay = json['rest_day'];
    _id = json['_id'];
  }
  List<Exercises>? _exercises;
  bool? _restDay;
  String? _id;

  List<Exercises>? get exercises => _exercises;
  bool? get restDay => _restDay;
  String? get id => _id;
}

class Friday {
  Friday({
    List<Exercises>? exercises,
    bool? restDay,
    String? id,
  }) {
    _exercises = exercises;
    _restDay = restDay;
    _id = id;
  }

  Friday.fromJson(dynamic json) {
    if (json['exercises'] != null) {
      _exercises = [];
      json['exercises'].forEach((v) {
        _exercises?.add(Exercises.fromJson(v));
      });
    }
    _restDay = json['rest_day'];
    _id = json['_id'];
  }
  List<Exercises>? _exercises;
  bool? _restDay;
  String? _id;

  List<Exercises>? get exercises => _exercises;
  bool? get restDay => _restDay;
  String? get id => _id;
}

class Thursday {
  Thursday({
    List<Exercises>? exercises,
    bool? restDay,
    String? id,
  }) {
    _exercises = exercises;
    _restDay = restDay;
    _id = id;
  }

  Thursday.fromJson(dynamic json) {
    if (json['exercises'] != null) {
      _exercises = [];
      json['exercises'].forEach((v) {
        _exercises?.add(Exercises.fromJson(v));
      });
    }
    _restDay = json['rest_day'];
    _id = json['_id'];
  }
  List<Exercises>? _exercises;
  bool? _restDay;
  String? _id;

  List<Exercises>? get exercises => _exercises;
  bool? get restDay => _restDay;
  String? get id => _id;
}

class Wednesday {
  Wednesday({
    List<Exercises>? exercises,
    bool? restDay,
    String? id,
  }) {
    _exercises = exercises;
    _restDay = restDay;
    _id = id;
  }

  Wednesday.fromJson(dynamic json) {
    if (json['exercises'] != null) {
      _exercises = [];
      json['exercises'].forEach((v) {
        _exercises?.add(Exercises.fromJson(v));
      });
    }
    _restDay = json['rest_day'];
    _id = json['_id'];
  }
  List<Exercises>? _exercises;
  bool? _restDay;
  String? _id;

  List<Exercises>? get exercises => _exercises;
  bool? get restDay => _restDay;
  String? get id => _id;
}

class Tuesday {
  Tuesday({
    List<Exercises>? exercises,
    bool? restDay,
    String? id,
  }) {
    _exercises = exercises;
    _restDay = restDay;
    _id = id;
  }

  Tuesday.fromJson(dynamic json) {
    if (json['exercises'] != null) {
      _exercises = [];
      json['exercises'].forEach((v) {
        _exercises?.add(Exercises.fromJson(v));
      });
    }
    _restDay = json['rest_day'];
    _id = json['_id'];
  }
  List<Exercises>? _exercises;
  bool? _restDay;
  String? _id;

  List<Exercises>? get exercises => _exercises;
  bool? get restDay => _restDay;
  String? get id => _id;
}

class Monday {
  Monday({
    List<Exercises>? exercises,
    bool? restDay,
    String? id,
  }) {
    _exercises = exercises;
    _restDay = restDay;
    _id = id;
  }

  Monday.fromJson(dynamic json) {
    if (json['exercises'] != null) {
      _exercises = [];
      json['exercises'].forEach((v) {
        _exercises?.add(Exercises.fromJson(v));
      });
    }
    _restDay = json['rest_day'];
    _id = json['_id'];
  }
  List<Exercises>? _exercises;
  bool? _restDay;
  String? _id;

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
