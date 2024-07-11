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
    bool? isRequiredInfoAdded,
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? goal,
    String? type,
    int? v,
    int? otp,
    String? gender,
    String? updatedAt,
    String? workoutLevel,
  }) {
    _address = address;
    _location = location;
    _height = height;
    _weight = weight;
    _isRequiredInfoAdded = isRequiredInfoAdded;
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
    _goal = goal;
    _type = type;
    _v = v;
    _otp = otp;
    _gender = gender;
    _updatedAt = updatedAt;
    _workoutLevel = workoutLevel;
  }

  Data.fromJson(dynamic json) {
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _height = json['height'] != null ? Height.fromJson(json['height']) : null;
    _weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    _isRequiredInfoAdded = json['isRequiredInfoAdded'];
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _password = json['password'];
    _goal = json['goal'];
    _type = json['type'];
    _v = json['__v'];
    _otp = json['otp'];
    _gender = json['gender'];
    _updatedAt = json['updatedAt'];
    _workoutLevel = json['workoutLevel'];
  }
  Address? _address;
  Location? _location;
  Height? _height;
  Weight? _weight;
  bool? _isRequiredInfoAdded;
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _goal;
  String? _type;
  int? _v;
  int? _otp;
  String? _gender;
  String? _updatedAt;
  String? _workoutLevel;

  Address? get address => _address;
  Location? get location => _location;
  Height? get height => _height;
  Weight? get weight => _weight;
  bool? get isRequiredInfoAdded => _isRequiredInfoAdded;
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get password => _password;
  String? get goal => _goal;
  String? get type => _type;
  int? get v => _v;
  int? get otp => _otp;
  String? get gender => _gender;
  String? get updatedAt => _updatedAt;
  String? get workoutLevel => _workoutLevel;
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
