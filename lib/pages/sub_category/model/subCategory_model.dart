// To parse this JSON data, do
//
//     final SubCategoryModel = SubCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    this.service_id = -1,
    this.name = "",
    this.image = "",
    this.category = -1,
    this.description = "",
    this.price = 0.0,
    this.itemloading = false,
  });

  int service_id;
  String name;
  String image;
  String description;
  int category;
  double price;
  bool itemloading;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        service_id: json["service_id"] ?? -1,
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        description: json["description"] ?? "",
        category: json["category"] ?? -1,
        price: json["price"] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "service_id": service_id,
        "name": name,
        "image": image,
        "description": description,
        "category": category,
        "price": price,
      };
}
