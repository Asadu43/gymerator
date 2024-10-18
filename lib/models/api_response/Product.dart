class Product {
  Product({
    Specifications? specifications,
    Discount? discount,
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
    List<Variants>? variants,
    int? averageRating,
    List<dynamic>? relatedProducts,
    String? metaTitle,
    String? metaDescription,
    List<dynamic>? reviews,
    String? createdAt,
    String? updatedAt,
    int? v,
    bool? isFavorite,
  }) {
    _specifications = specifications;
    _discount = discount;
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
    _variants = variants;
    _averageRating = averageRating;
    _relatedProducts = relatedProducts;
    _metaTitle = metaTitle;
    _metaDescription = metaDescription;
    _reviews = reviews;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _isFavorite = isFavorite;
  }

  Product.fromJson(dynamic json) {
    _specifications = json['specifications'] != null
        ? Specifications.fromJson(json['specifications'])
        : null;
    _discount =
        json['discount'] != null ? Discount.fromJson(json['discount']) : null;
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
    if (json['variants'] != null) {
      _variants = [];
      json['variants'].forEach((v) {
        _variants?.add(Variants.fromJson(v));
      });
    }
    _averageRating = json['averageRating'];
    if (json['relatedProducts'] != null) {
      _relatedProducts = [];
      json['relatedProducts'].forEach((v) {
        _relatedProducts?.add(v);
      });
    }
    _metaTitle = json['metaTitle'];
    _metaDescription = json['metaDescription'];
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(v);
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _isFavorite = json['isFavorite'];
  }

  Specifications? _specifications;
  Discount? _discount;
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
  List<Variants>? _variants;
  int? _averageRating;
  List<dynamic>? _relatedProducts;
  String? _metaTitle;
  String? _metaDescription;
  List<dynamic>? _reviews;
  String? _createdAt;
  String? _updatedAt;
  int? _v;
  bool? _isFavorite;

  Specifications? get specifications => _specifications;

  Discount? get discount => _discount;

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

  List<Variants>? get variants => _variants;

  int? get averageRating => _averageRating;

  List<dynamic>? get relatedProducts => _relatedProducts;

  String? get metaTitle => _metaTitle;

  String? get metaDescription => _metaDescription;

  List<dynamic>? get reviews => _reviews;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  int? get v => _v;

  bool? get isFavorite => _isFavorite;
}

class Variants {
  Variants({
    String? id,
    String? variantType,
    String? variant,
  }) {
    _id = id;
    _variantType = variantType;
    _variant = variant;
  }

  Variants.fromJson(dynamic json) {
    _id = json['_id'];
    _variantType = json['variantType'];
    _variant = json['variant'];
  }

  String? _id;
  String? _variantType;
  String? _variant;

  String? get id => _id;

  String? get variantType => _variantType;

  String? get variant => _variant;
}

class Discount {
  Discount({
    int? percentage,
    bool? valid,
  }) {
    _percentage = percentage;
    _valid = valid;
  }

  Discount.fromJson(dynamic json) {
    _percentage = json['percentage'];
    _valid = json['valid'];
  }

  int? _percentage;
  bool? _valid;

  int? get percentage => _percentage;

  bool? get valid => _valid;
}

class Specifications {
  Specifications({
    String? brand,
    String? modelNumber,
  }) {
    _brand = brand;
    _modelNumber = modelNumber;
  }

  Specifications.fromJson(dynamic json) {
    _brand = json['brand'];
    _modelNumber = json['modelNumber'];
  }

  String? _brand;
  String? _modelNumber;

  String? get brand => _brand;

  String? get modelNumber => _modelNumber;
}

class RelatedProducts {
  RelatedProducts({
    String? id,
    String? name,
    String? description,
    int? stock,
    String? category,
    List<String>? images,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _stock = stock;
    _category = category;
    _images = images;
  }

  RelatedProducts.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _stock = json['stock'];
    _category = json['category'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }

  String? _id;
  String? _name;
  String? _description;
  int? _stock;
  String? _category;
  List<String>? _images;

  String? get id => _id;

  String? get name => _name;

  String? get description => _description;

  int? get stock => _stock;

  String? get category => _category;

  List<String>? get images => _images;
}
