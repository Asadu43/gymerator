class LoginWithGoogleApiResponse {
  LoginWithGoogleApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  LoginWithGoogleApiResponse.fromJson(dynamic json) {
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
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? goal,
    String? workoutLevel,
    String? type,
    bool? isRequiredInfoAdded,
    bool? isAccepted,
    List<dynamic>? favoriteProducts,
    String? createdAt,
    String? updatedAt,
    int? v,
    String? profile,
    int? age,
    String? gender,
    String? walletAddress,
  }) {
    _address = address;
    _location = location;
    _height = height;
    _weight = weight;
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobileNumber = mobileNumber;
    _goal = goal;
    _workoutLevel = workoutLevel;
    _type = type;
    _isRequiredInfoAdded = isRequiredInfoAdded;
    _isAccepted = isAccepted;
    _favoriteProducts = favoriteProducts;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _profile = profile;
    _age = age;
    _gender = gender;
    _walletAddress = walletAddress;
  }

  Data.fromJson(dynamic json) {
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _height = json['height'] != null ? Height.fromJson(json['height']) : null;
    _weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _mobileNumber = json['mobileNumber'];
    _goal = json['goal'];
    _workoutLevel = json['workoutLevel'];
    _type = json['type'];
    _isRequiredInfoAdded = json['isRequiredInfoAdded'];
    _isAccepted = json['isAccepted'];
    if (json['favoriteProducts'] != null) {
      _favoriteProducts = [];
      json['favoriteProducts'].forEach((v) {
        _favoriteProducts?.add(v);
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _profile = json['profile'];
    _age = json['age'];
    _gender = json['gender'];
    _walletAddress = json['walletAddress'];
  }

  Address? _address;
  Location? _location;
  Height? _height;
  Weight? _weight;
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobileNumber;
  String? _goal;
  String? _workoutLevel;
  String? _type;
  bool? _isRequiredInfoAdded;
  bool? _isAccepted;
  List<dynamic>? _favoriteProducts;
  String? _createdAt;
  String? _updatedAt;
  int? _v;
  String? _profile;
  int? _age;
  String? _gender;
  String? _walletAddress;

  Address? get address => _address;

  Location? get location => _location;

  Height? get height => _height;

  Weight? get weight => _weight;

  String? get id => _id;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get email => _email;

  String? get mobileNumber => _mobileNumber;

  String? get goal => _goal;

  String? get workoutLevel => _workoutLevel;

  String? get type => _type;

  bool? get isRequiredInfoAdded => _isRequiredInfoAdded;

  bool? get isAccepted => _isAccepted;

  List<dynamic>? get favoriteProducts => _favoriteProducts;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  int? get v => _v;

  String? get profile => _profile;

  int? get age => _age;

  String? get gender => _gender;

  String? get walletAddress => _walletAddress;
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
    _value = _convertToDouble(json['value']);
  }

  // Method to convert a dynamic value to a double
  static double? _convertToDouble(dynamic val) {
    if (val == null) {
      return null;
    }
    if (val is int) {
      return val.toDouble();
    } else if (val is double) {
      return val;
    } else if (val is String) {
      return double.tryParse(val);
    } else {
      throw ArgumentError('Unsupported type: ${val.runtimeType}');
    }
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
    _value = _convertToDouble(json['value']);
  }

  // Method to convert a dynamic value to a double
  static double? _convertToDouble(dynamic val) {
    if (val == null) {
      return null;
    }
    if (val is int) {
      return val.toDouble();
    } else if (val is double) {
      return val;
    } else if (val is String) {
      return double.tryParse(val);
    } else {
      throw ArgumentError('Unsupported type: ${val.runtimeType}');
    }
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
    String? country,
    String? postalCode,
    String? state,
  }) {
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _country = country;
    _postalCode = postalCode;
    _state = state;
  }

  Address.fromJson(dynamic json) {
    _address1 = json['address1'];
    _address2 = json['address2'];
    _city = json['city'];
    _country = json['country'];
    _postalCode = json['postalCode'];
    _state = json['state'];
  }

  String? _address1;
  String? _address2;
  String? _city;
  String? _country;
  String? _postalCode;
  String? _state;

  String? get address1 => _address1;

  String? get address2 => _address2;

  String? get city => _city;

  String? get country => _country;

  String? get postalCode => _postalCode;

  String? get state => _state;
}
