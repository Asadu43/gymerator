class GetAllFavoriteProductApiResponse {
  GetAllFavoriteProductApiResponse({
      Data? data, 
      String? message, 
      dynamic error,}){
    _data = data;
    _message = message;
    _error = error;
}

  GetAllFavoriteProductApiResponse.fromJson(dynamic json) {
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
      String? password, 
      String? goal, 
      String? workoutLevel, 
      String? type, 
      bool? isRequiredInfoAdded, 
      List<FavoriteProducts>? favoriteProducts, 
      String? createdAt, 
      String? updatedAt, 
      int? v, 
      int? age, 
      String? gender,}){
    _address = address;
    _location = location;
    _height = height;
    _weight = weight;
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
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
}

  Data.fromJson(dynamic json) {
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _height = json['height'] != null ? Height.fromJson(json['height']) : null;
    _weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _password = json['password'];
    _goal = json['goal'];
    _workoutLevel = json['workoutLevel'];
    _type = json['type'];
    _isRequiredInfoAdded = json['isRequiredInfoAdded'];
    if (json['favoriteProducts'] != null) {
      _favoriteProducts = [];
      json['favoriteProducts'].forEach((v) {
        _favoriteProducts?.add(FavoriteProducts.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _age = json['age'];
    _gender = json['gender'];
  }
  Address? _address;
  Location? _location;
  Height? _height;
  Weight? _weight;
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _goal;
  String? _workoutLevel;
  String? _type;
  bool? _isRequiredInfoAdded;
  List<FavoriteProducts>? _favoriteProducts;
  String? _createdAt;
  String? _updatedAt;
  int? _v;
  int? _age;
  String? _gender;

  Address? get address => _address;
  Location? get location => _location;
  Height? get height => _height;
  Weight? get weight => _weight;
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get password => _password;
  String? get goal => _goal;
  String? get workoutLevel => _workoutLevel;
  String? get type => _type;
  bool? get isRequiredInfoAdded => _isRequiredInfoAdded;
  List<FavoriteProducts>? get favoriteProducts => _favoriteProducts;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;
  int? get age => _age;
  String? get gender => _gender;


}

class FavoriteProducts {
  FavoriteProducts({
      String? id, 
      String? name, 
      String? description, 
      int? price, 
      String? sku, 
      int? stock, 
      bool? isAvailable, 
      String? category, 
      List<String>? tags, 
      List<String>? images, 
      double? averageRating, 
      List<String>? relatedProducts, 
      String? metaTitle, 
      String? metaDescription, 
      List<Variants>? variants, 
      List<dynamic>? attributes, 
      List<Reviews>? reviews, 
      List<dynamic>? discounts, 
      String? createdAt, 
      String? updatedAt, 
      int? v,}){
    _id = id;
    _name = name;
    _description = description;
    _price = price;
    _sku = sku;
    _stock = stock;
    _isAvailable = isAvailable;
    _category = category;
    _tags = tags;
    _images = images;
    _averageRating = averageRating;
    _relatedProducts = relatedProducts;
    _metaTitle = metaTitle;
    _metaDescription = metaDescription;
    _variants = variants;
    _attributes = attributes;
    _reviews = reviews;
    _discounts = discounts;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  FavoriteProducts.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _sku = json['sku'];
    _stock = json['stock'];
    _isAvailable = json['isAvailable'];
    _category = json['category'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _averageRating = json['averageRating'];
    _relatedProducts = json['relatedProducts'] != null ? json['relatedProducts'].cast<String>() : [];
    _metaTitle = json['metaTitle'];
    _metaDescription = json['metaDescription'];
    if (json['variants'] != null) {
      _variants = [];
      json['variants'].forEach((v) {
        _variants?.add(Variants.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(v);
      });
    }
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
    if (json['discounts'] != null) {
      _discounts = [];
      json['discounts'].forEach((v) {
        _discounts?.add(v);
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _description;
  int? _price;
  String? _sku;
  int? _stock;
  bool? _isAvailable;
  String? _category;
  List<String>? _tags;
  List<String>? _images;
  double? _averageRating;
  List<String>? _relatedProducts;
  String? _metaTitle;
  String? _metaDescription;
  List<Variants>? _variants;
  List<dynamic>? _attributes;
  List<Reviews>? _reviews;
  List<dynamic>? _discounts;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  int? get price => _price;
  String? get sku => _sku;
  int? get stock => _stock;
  bool? get isAvailable => _isAvailable;
  String? get category => _category;
  List<String>? get tags => _tags;
  List<String>? get images => _images;
  double? get averageRating => _averageRating;
  List<String>? get relatedProducts => _relatedProducts;
  String? get metaTitle => _metaTitle;
  String? get metaDescription => _metaDescription;
  List<Variants>? get variants => _variants;
  List<dynamic>? get attributes => _attributes;
  List<Reviews>? get reviews => _reviews;
  List<dynamic>? get discounts => _discounts;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;


}

class Reviews {
  Reviews({
      String? userId, 
      double? rating, 
      String? review, 
      String? id,}){
    _userId = userId;
    _rating = rating;
    _review = review;
    _id = id;
}

  Reviews.fromJson(dynamic json) {
    _userId = json['userId'];
    _rating = json['rating'];
    _review = json['review'];
    _id = json['_id'];
  }
  String? _userId;
  double? _rating;
  String? _review;
  String? _id;

  String? get userId => _userId;
  double? get rating => _rating;
  String? get review => _review;
  String? get id => _id;


}

class Variants {
  Variants({
      String? name, 
      List<String>? values, 
      String? id,}){
    _name = name;
    _values = values;
    _id = id;
}

  Variants.fromJson(dynamic json) {
    _name = json['name'];
    _values = json['values'] != null ? json['values'].cast<String>() : [];
    _id = json['_id'];
  }
  String? _name;
  List<String>? _values;
  String? _id;

  String? get name => _name;
  List<String>? get values => _values;
  String? get id => _id;


}

class Weight {
  Weight({
      String? unit, 
      double? value,}){
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
      double? value,}){
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
      String? longitude,}){
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
      String? postalCode,}){
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