class FeaturedProductApiResponse {
  FeaturedProductApiResponse({
    this.data,
    this.message,
    this.error,
  });

  FeaturedProductApiResponse.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'];
  }
  Data? data;
  String? message;
  dynamic error;
}

class Data {
  Data({
    this.featuredProducts,
    this.hotProducts,
  });

  Data.fromJson(dynamic json) {
    if (json['featuredProducts'] != null) {
      featuredProducts = [];
      json['featuredProducts'].forEach((v) {
        featuredProducts?.add(v);
      });
    }
    if (json['hotProducts'] != null) {
      hotProducts = [];
      json['hotProducts'].forEach((v) {
        hotProducts?.add(v);
      });
    }
  }
  List<FeaturedProducts>? featuredProducts;
  List<HotProducts>? hotProducts;
}

class HotProducts {
  HotProducts({
    this.id,
    this.name,
    this.description,
    this.price,
    this.sku,
    this.stock,
    this.isAvailable,
    this.category,
    this.tags,
    this.images,
    this.averageRating,
    this.relatedProducts,
    this.metaTitle,
    this.metaDescription,
    this.variants,
    this.attributes,
    this.reviews,
    this.discounts,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  HotProducts.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    sku = json['sku'];
    stock = json['stock'];
    isAvailable = json['isAvailable'];
    category = json['category'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    averageRating = json['averageRating'];
    if (json['relatedProducts'] != null) {
      relatedProducts = [];
      json['relatedProducts'].forEach((v) {
        relatedProducts?.add(v);
      });
    }
    metaTitle = json['metaTitle'];
    metaDescription = json['metaDescription'];
    if (json['variants'] != null) {
      variants = [];
      json['variants'].forEach((v) {
        variants?.add(v);
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(v);
      });
    }
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(v);
      });
    }
    if (json['discounts'] != null) {
      discounts = [];
      json['discounts'].forEach((v) {
        discounts?.add(v);
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? description;
  num? price;
  String? sku;
  num? stock;
  bool? isAvailable;
  String? category;
  List<String>? tags;
  List<String>? images;
  num? averageRating;
  List<dynamic>? relatedProducts;
  String? metaTitle;
  String? metaDescription;
  List<dynamic>? variants;
  List<dynamic>? attributes;
  List<dynamic>? reviews;
  List<dynamic>? discounts;
  String? createdAt;
  String? updatedAt;
  num? v;
}

class FeaturedProducts {
  FeaturedProducts({
    this.id,
    this.name,
    this.description,
    this.price,
    this.sku,
    this.stock,
    this.isAvailable,
    this.category,
    this.tags,
    this.images,
    this.averageRating,
    this.relatedProducts,
    this.metaTitle,
    this.metaDescription,
    this.variants,
    this.attributes,
    this.reviews,
    this.discounts,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  FeaturedProducts.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    sku = json['sku'];
    stock = json['stock'];
    isAvailable = json['isAvailable'];
    category = json['category'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    averageRating = json['averageRating'];
    if (json['relatedProducts'] != null) {
      relatedProducts = [];
      json['relatedProducts'].forEach((v) {
        relatedProducts?.add(v);
      });
    }
    metaTitle = json['metaTitle'];
    metaDescription = json['metaDescription'];
    if (json['variants'] != null) {
      variants = [];
      json['variants'].forEach((v) {
        variants?.add(v);
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(v);
      });
    }
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(v);
      });
    }
    if (json['discounts'] != null) {
      discounts = [];
      json['discounts'].forEach((v) {
        discounts?.add(v);
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? description;
  num? price;
  String? sku;
  num? stock;
  bool? isAvailable;
  String? category;
  List<String>? tags;
  List<String>? images;
  num? averageRating;
  List<dynamic>? relatedProducts;
  String? metaTitle;
  String? metaDescription;
  List<dynamic>? variants;
  List<dynamic>? attributes;
  List<dynamic>? reviews;
  List<dynamic>? discounts;
  String? createdAt;
  String? updatedAt;
  num? v;
}
