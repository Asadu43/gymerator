class UpdateUserInfoApiResponse {
  UpdateUserInfoApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  UpdateUserInfoApiResponse.fromJson(dynamic json) {
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
    Address? address,
    Location? location,
    Height? height,
    Weight? weight,
    MedicalCondition? medicalCondition,
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? activityLevel,
    String? dietType,
    int? mealFrequency,
    String? goal,
    String? workoutLevel,
    String? type,
    bool? isRequiredInfoAdded,
    List<dynamic>? favoriteProducts,
    String? createdAt,
    String? updatedAt,
    int? v,
    int? age,
    String? gender,
    int? hydrationLitersPerDay,
    int? sleepHours,
    int? targetWeightInKG,
    dynamic timelineMonths,
  }) {
    _address = address;
    _location = location;
    _height = height;
    _weight = weight;
    _medicalCondition = medicalCondition;
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _activityLevel = activityLevel;
    _dietType = dietType;
    _mealFrequency = mealFrequency;
    _goal = goal;
    _workoutLevel = workoutLevel;
    _type = type;
    _isRequiredInfoAdded = isRequiredInfoAdded;
    _favoriteProducts = favoriteProducts;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _age = age;
    _gender = gender;
    _hydrationLitersPerDay = hydrationLitersPerDay;
    _sleepHours = sleepHours;
    _targetWeightInKG = targetWeightInKG;
    _timelineMonths = timelineMonths;
  }

  Data.fromJson(dynamic json) {
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _height = json['height'] != null ? Height.fromJson(json['height']) : null;
    _weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    _medicalCondition = json['medicalCondition'] != null
        ? MedicalCondition.fromJson(json['medicalCondition'])
        : null;
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _activityLevel = json['activityLevel'];
    _dietType = json['dietType'];
    _mealFrequency = json['mealFrequency'];
    _goal = json['goal'];
    _workoutLevel = json['workoutLevel'];
    _type = json['type'];
    _isRequiredInfoAdded = json['isRequiredInfoAdded'];
    if (json['favoriteProducts'] != null) {
      _favoriteProducts = [];
      json['favoriteProducts'].forEach((v) {
        _favoriteProducts?.add(v);
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _age = json['age'];
    _gender = json['gender'];
    _hydrationLitersPerDay = json['hydrationLitersPerDay'];
    _sleepHours = json['sleepHours'];
    _targetWeightInKG = json['targetWeightInKG'];
    _timelineMonths = json['timelineMonths'];
  }

  Address? _address;
  Location? _location;
  Height? _height;
  Weight? _weight;
  MedicalCondition? _medicalCondition;
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _activityLevel;
  String? _dietType;
  int? _mealFrequency;
  String? _goal;
  String? _workoutLevel;
  String? _type;
  bool? _isRequiredInfoAdded;
  List<dynamic>? _favoriteProducts;
  String? _createdAt;
  String? _updatedAt;
  int? _v;
  int? _age;
  String? _gender;
  int? _hydrationLitersPerDay;
  int? _sleepHours;
  int? _targetWeightInKG;
  dynamic _timelineMonths;

  Address? get address => _address;

  Location? get location => _location;

  Height? get height => _height;

  Weight? get weight => _weight;

  MedicalCondition? get medicalCondition => _medicalCondition;

  String? get id => _id;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get email => _email;

  String? get activityLevel => _activityLevel;

  String? get dietType => _dietType;

  int? get mealFrequency => _mealFrequency;

  String? get goal => _goal;

  String? get workoutLevel => _workoutLevel;

  String? get type => _type;

  bool? get isRequiredInfoAdded => _isRequiredInfoAdded;

  List<dynamic>? get favoriteProducts => _favoriteProducts;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  int? get v => _v;

  int? get age => _age;

  String? get gender => _gender;

  int? get hydrationLitersPerDay => _hydrationLitersPerDay;

  int? get sleepHours => _sleepHours;

  int? get targetWeightInKG => _targetWeightInKG;

  dynamic get timelineMonths => _timelineMonths;
}

class MedicalCondition {
  MedicalCondition({
    String? condition,
    String? name,
  }) {
    _condition = condition;
    _name = name;
  }

  MedicalCondition.fromJson(dynamic json) {
    _condition = json['condition'];
    _name = json['name'];
  }

  String? _condition;
  String? _name;

  String? get condition => _condition;

  String? get name => _name;
}

class Weight {
  Weight({
    String? unit,
    double? value,
  }) {
    _unit = unit;
    _value = value;
  }

  Weight.fromJson(dynamic json) {
    _unit = json['unit'];
    _value = json['value'];
  }

  String? _unit;
  double? _value;

  String? get unit => _unit;

  double? get value => _value;
}

class Height {
  Height({
    String? unit,
    double? value,
  }) {
    _unit = unit;
    _value = value;
  }

  Height.fromJson(dynamic json) {
    _unit = json['unit'];
    _value = json['value'];
  }

  String? _unit;
  double? _value;

  String? get unit => _unit;

  double? get value => _value;
}

class Location {
  Location({
    String? latitude,
    String? longitude,
  }) {
    _latitude = latitude;
    _longitude = longitude;
  }

  Location.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  String? _latitude;
  String? _longitude;

  String? get latitude => _latitude;

  String? get longitude => _longitude;
}

class Address {
  Address({
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? country,
    String? postalCode,
  }) {
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _state = state;
    _country = country;
    _postalCode = postalCode;
  }

  Address.fromJson(dynamic json) {
    _address1 = json['address1'];
    _address2 = json['address2'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _postalCode = json['postalCode'];
  }

  String? _address1;
  String? _address2;
  String? _city;
  String? _state;
  String? _country;
  String? _postalCode;

  String? get address1 => _address1;

  String? get address2 => _address2;

  String? get city => _city;

  String? get state => _state;

  String? get country => _country;

  String? get postalCode => _postalCode;
}
