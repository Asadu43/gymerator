class Product {
  Product({
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
    int? averageRating,
    List<dynamic>? relatedProducts,
    String? metaTitle,
    String? metaDescription,
    List<dynamic>? variants,
    List<dynamic>? attributes,
    List<dynamic>? reviews,
    List<dynamic>? discounts,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
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

  Product.fromJson(dynamic json) {
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
    if (json['relatedProducts'] != null) {
      _relatedProducts = [];
      json['relatedProducts'].forEach((v) {
        _relatedProducts?.add(v);
      });
    }
    _metaTitle = json['metaTitle'];
    _metaDescription = json['metaDescription'];
    if (json['variants'] != null) {
      _variants = [];
      json['variants'].forEach((v) {
        _variants?.add(v);
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
        _reviews?.add(v);
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
  int? _averageRating;
  List<dynamic>? _relatedProducts;
  String? _metaTitle;
  String? _metaDescription;
  List<dynamic>? _variants;
  List<dynamic>? _attributes;
  List<dynamic>? _reviews;
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
  int? get averageRating => _averageRating;
  List<dynamic>? get relatedProducts => _relatedProducts;
  String? get metaTitle => _metaTitle;
  String? get metaDescription => _metaDescription;
  List<dynamic>? get variants => _variants;
  List<dynamic>? get attributes => _attributes;
  List<dynamic>? get reviews => _reviews;
  List<dynamic>? get discounts => _discounts;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;
}
