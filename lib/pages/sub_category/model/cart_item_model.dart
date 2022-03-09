// To parse this JSON data, do
//
//     final CartItemModel = CartItemModelFromJson(jsonString);

import 'dart:convert';

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  CartItemModel({
    this.category = -1,
    this.item = -1,
    this.cart = -1,
    this.description = "",
    this.name = "",
    this.image = "",
    this.price = -1,
  });

  int category;

  int item;
  int cart;
  String description;
  String name;
  String image;
  double price;

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        category: json["item__service__category"] ?? -1,
        item: json["item"] ?? -1,
        cart: json["cart"] ?? -1,
        description: json["item__service__description"] ?? "",
        name: json["item__service__name"] ?? "",
        image: json["item__service__image"] ?? "",
        price: json["item__price"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "item__service__category": category,
        "item": item,
        "cart": cart,
        "item__service__description": description,
        "item__service__name": name,
        "item__service__image": image,
        "item__price": price,
      };
}
