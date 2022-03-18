// To parse this JSON data, do
//
//     final CartModel = CartModelFromJson(jsonString);

import 'dart:convert';

import 'package:elhasr/pages/sub_category/model/cart_item_model.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

List<CartItemModel> fillCartItemFromjson(responseData) {
  List<CartItemModel> _listitems = [];
  responseData.forEach((_itemdata) {
    final CartItemModel _item = CartItemModel.fromJson(_itemdata);
    _listitems.add(_item);
  });

  return _listitems;
}

class CartModel {
  CartModel({
    this.id = -1,
    this.user = -1,
    this.date_created = "",
    this.total_price = 0.0,
    this.coupon_code = "",
    this.discount_percent = 0,
    this.cartItems = const [],
  });

  int id;

  String date_created;
  int user;
  double total_price;
  double discount_percent;
  String coupon_code;
  List<CartItemModel> cartItems;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"] ?? -1,
        date_created: json["date_created"] ?? "",
        user: json["user"] ?? -1,
        total_price: json["total_price"] ?? 0.0,
        coupon_code: json["coupon_code"] ?? "",
        discount_percent: json["discount_percent"] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": date_created,
        "user": user,
        "total_price": total_price,
      };
}
