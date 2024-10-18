class UpdateCartItemApiResponse {
  UpdateCartItemApiResponse({
    this.data,
    this.message,
    this.error,
  });

  UpdateCartItemApiResponse.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'];
  }

  Data? data;
  String? message;
  dynamic error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    map['error'] = error;
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.user,
    this.v,
    this.createdAt,
    this.discount,
    this.items,
    this.subTotal,
    this.tax,
    this.total,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    v = json['__v'];
    createdAt = json['createdAt'];
    discount = json['discount'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    subTotal = json['subTotal'];
    tax = json['tax'];
    total = json['total'];
    updatedAt = json['updatedAt'];
  }

  String? id;
  String? user;
  num? v;
  String? createdAt;
  num? discount;
  List<Items>? items;
  num? subTotal;
  num? tax;
  num? total;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    map['__v'] = v;
    map['createdAt'] = createdAt;
    map['discount'] = discount;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['subTotal'] = subTotal;
    map['tax'] = tax;
    map['total'] = total;
    map['updatedAt'] = updatedAt;
    return map;
  }
}

class Items {
  Items({
    this.product,
    this.quantity,
    this.unitPrice,
    this.total,
    this.id,
  });

  Items.fromJson(dynamic json) {
    product = json['product'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    total = json['total'];
    id = json['_id'];
  }

  String? product;
  num? quantity;
  num? unitPrice;
  num? total;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product'] = product;
    map['quantity'] = quantity;
    map['unitPrice'] = unitPrice;
    map['total'] = total;
    map['_id'] = id;
    return map;
  }
}
