class GetDataResponse {
  GetDataResponse({
    required this.message,
    required this.response,
  });

  String message;
  Response response;

  factory GetDataResponse.fromJson(Map<String, dynamic> json) => GetDataResponse(
    message: json["message"],
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "response": response.toJson(),
  };
}

class Response {
  Response({
    required this.bannerList,
    required this.categoryList,
    required this.recommndedList,
    required this.offerList,
    required this.vendorLat,
    required this.vendorLng,
    required this.searchTags,
    required this.whatsNew,
    required this.whatsnewList,
  });

  List<dynamic> bannerList;
  List<CategoryList> categoryList;
  List<dynamic> recommndedList;
  List<dynamic> offerList;
  double vendorLat;
  double vendorLng;
  List<dynamic> searchTags;
  List<dynamic> whatsNew;
  List<WhatsnewList> whatsnewList;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    bannerList: List<dynamic>.from(json["bannerList"].map((x) => x)),
    categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
    recommndedList: List<dynamic>.from(json["recommndedList"].map((x) => x)),
    offerList: List<dynamic>.from(json["offerList"].map((x) => x)),
    vendorLat: json["vendorLat"].toDouble(),
    vendorLng: json["vendorLng"].toDouble(),
    searchTags: List<dynamic>.from(json["search_tags"].map((x) => x)),
    whatsNew: List<dynamic>.from(json["whats_new"].map((x) => x)),
    whatsnewList: List<WhatsnewList>.from(json["whatsnewList"].map((x) => WhatsnewList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bannerList": List<dynamic>.from(bannerList.map((x) => x)),
    "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
    "recommndedList": List<dynamic>.from(recommndedList.map((x) => x)),
    "offerList": List<dynamic>.from(offerList.map((x) => x)),
    "vendorLat": vendorLat,
    "vendorLng": vendorLng,
    "search_tags": List<dynamic>.from(searchTags.map((x) => x)),
    "whats_new": List<dynamic>.from(whatsNew.map((x) => x)),
    "whatsnewList": List<dynamic>.from(whatsnewList.map((x) => x.toJson())),
  };
}

class CategoryList {
  CategoryList({
    required this.id,
    required this.category,
    required this.imageUrl,
  });

  String id;
  String category;
  String imageUrl;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    id: json["_id"],
    category: json["category"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
    "image_url": imageUrl,
  };
}

class WhatsnewList {
  WhatsnewList({
    required this.id,
    required this.createdOn,
    required this.size,
    required this.productImage,
    required this.countryOrigin,
    required this.actualExpiryDate,
    required this.productName,
    required this.productDescription,
    required this.mainPrice,
    required this.cost,
    required this.specialPrice,
    required this.discount,
    required this.discountPercent,
    required this.totalQuantity,
    required this.categoryId,
    required this.subCategory,
  });

  String id;
  DateTime createdOn;
  String size;
  List<String> productImage;
  String countryOrigin;
  String actualExpiryDate;
  String productName;
  String productDescription;
  int mainPrice;
  double cost;
  int specialPrice;
  int discount;
  int discountPercent;
  int totalQuantity;
  String categoryId;
  List<dynamic> subCategory;

  factory WhatsnewList.fromJson(Map<String, dynamic> json) =>
      WhatsnewList(
        id: json["_id"],
        createdOn: DateTime.parse(json["created_on"]),
        size: json["size"],
        productImage: List<String>.from(json["product_image"].map((x) => x)),
        countryOrigin: json["country_origin"],
        actualExpiryDate: json["actual_expiry_date"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        mainPrice: json["main_price"],
        cost: json["cost"].toDouble(),
        specialPrice: json["special_price"],
        discount: json["discount"],
        discountPercent: json["discount_percent"],
        totalQuantity: json["total_quantity"],
        categoryId: json["category_id"],
        subCategory: List<dynamic>.from(json["sub_category"].map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "created_on": createdOn.toIso8601String(),
        "size": size,
        "product_image": List<dynamic>.from(productImage.map((x) => x)),
        "country_origin": countryOrigin,
        "actual_expiry_date": actualExpiryDate,
        "product_name": productName,
        "product_description": productDescription,
        "main_price": mainPrice,
        "cost": cost,
        "special_price": specialPrice,
        "discount": discount,
        "discount_percent": discountPercent,
        "total_quantity": totalQuantity,
        "category_id": categoryId,
        "sub_category": List<dynamic>.from(subCategory.map((x) => x)),
      };
}