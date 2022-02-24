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
    this.id = -1,
    this.name = "",
    this.image = "",
    this.category = -1,
    this.description = "",
  });

  int id;
  String name;
  String image;
  String description;
  int category;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        id: json["id"] ?? -1,
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        description: json["description"] ?? "",
        category: json["category"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "category": category,
      };
}
