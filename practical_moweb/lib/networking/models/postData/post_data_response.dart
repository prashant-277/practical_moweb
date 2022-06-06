// To parse this JSON data, do
//
//     final postDataResponse = postDataResponseFromJson(jsonString);

import 'dart:convert';

PostDataResponse postDataResponseFromJson(String str) => PostDataResponse.fromJson(json.decode(str));

String postDataResponseToJson(PostDataResponse data) => json.encode(data.toJson());

class PostDataResponse {
  PostDataResponse({
    required this.statusCode,
    required this.message,
    required this.response,
    required this.cartQuantity,
  });

  int statusCode;
  String message;
  List<PDResponse> response;
  int cartQuantity;

  factory PostDataResponse.fromJson(Map<String, dynamic> json) => PostDataResponse(
    statusCode: json["status_code"],
    message: json["message"],
    response: List<PDResponse>.from(json["response"].map((x) => PDResponse.fromJson(x))),
    cartQuantity: json["cart_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
    "cart_quantity": cartQuantity,
  };
}

class PDResponse {
  PDResponse({
    required this.id,
    required this.size,
    required this.productImage,
    required this.productName,
    required this.productDescription,
    required this.mainPrice,
    required this.cost,
    required this.specialPrice,
    required this.discount,
    required this.discountPercent,
    required this.totalQuantity,
    required this.subCategory,
    required this.actualExpiryDate,
    required this.countryOrigin,
    required this.isAdded
  });

  String id;
  String size;
  List<String> productImage;
  String productName;
  String productDescription;
  int mainPrice;
  double cost;
  int specialPrice;
  int discount;
  int discountPercent;
  int totalQuantity;
  List<dynamic> subCategory;
  String actualExpiryDate;
  String countryOrigin;
  bool isAdded = false;

  factory PDResponse.fromJson(Map<String, dynamic> json) => PDResponse(
    id: json["_id"],
    size: json["size"],
    productImage: List<String>.from(json["product_image"].map((x) => x)),
    productName: json["product_name"],
    productDescription: json["product_description"],
    mainPrice: json["main_price"],
    cost: json["cost"].toDouble(),
    specialPrice: json["special_price"],
    discount: json["discount"],
    discountPercent: json["discount_percent"],
    totalQuantity: json["total_quantity"],
    subCategory: List<dynamic>.from(json["sub_category"].map((x) => x)),
    actualExpiryDate: json["actual_expiry_date"],
    countryOrigin: json["country_origin"],
    isAdded: false,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "size": size,
    "product_image": List<dynamic>.from(productImage.map((x) => x)),
    "product_name": productName,
    "product_description": productDescription,
    "main_price": mainPrice,
    "cost": cost,
    "special_price": specialPrice,
    "discount": discount,
    "discount_percent": discountPercent,
    "total_quantity": totalQuantity,
    "sub_category": List<dynamic>.from(subCategory.map((x) => x)),
    "actual_expiry_date": actualExpiryDate,
    "country_origin": countryOrigin,
  };
}