// To parse this JSON data, do
//
//     final CartItemModel = CartItemModelFromJson(jsonString);

import 'dart:convert';

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  CartItemModel({
    this.id = -1,
    this.item = -1,
    this.cart = -1,
  });

  int id;

  int item;
  int cart;

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json["id"] ?? -1,
        item: json["item"] ?? -1,
        cart: json["cart"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": item,
        "cart": cart,
      };
}
