class SignupApiResponse {
  SignupApiResponse({
    Data? data,
    String? message,
    dynamic error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  SignupApiResponse.fromJson(dynamic json) {
    // _data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    Address? address,
    Location? location,
    String? goal,
    String? type,
    String? id,
    int? v,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
    _address = address;
    _location = location;
    _goal = goal;
    _type = type;
    _id = id;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _password = json['password'];
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _goal = json['goal'];
    _type = json['type'];
    _id = json['_id'];
    _v = json['__v'];
  }
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  Address? _address;
  Location? _location;
  String? _goal;
  String? _type;
  String? _id;
  int? _v;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get password => _password;
  Address? get address => _address;
  Location? get location => _location;
  String? get goal => _goal;
  String? get type => _type;
  String? get id => _id;
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
