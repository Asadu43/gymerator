class SignInApiResponse {
  SignInApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  SignInApiResponse.fromJson(dynamic json) {
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
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
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
  }) {
    _address = address;
    _location = location;
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
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
  }

  Data.fromJson(dynamic json) {
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _password = json['password'];
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
  }
  Address? _address;
  Location? _location;
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
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

  Address? get address => _address;
  Location? get location => _location;
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get password => _password;
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
