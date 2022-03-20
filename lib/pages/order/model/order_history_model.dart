// To parse this JSON data, do
//
//     final OrderHistoryModel = OrderHistoryModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  OrderHistoryModel({
    this.id = -1,
    this.user_id = -1,
    this.coupon_used_id = -1,
    this.status = "",
    this.user_comment = "",
    this.owner_comment = "",
    this.final_price = -1,
    this.requested_date = "",
    this.loading = false,
    this.modified_date = "",
  });

  int id;

  int user_id;
  int coupon_used_id;
  String status;
  String user_comment;
  String owner_comment;
  double final_price;
  bool loading;
  String requested_date;
  String modified_date;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        id: json["id"] ?? -1,
        user_id: json["user_id"] ?? -1,
        coupon_used_id: json["coupon_used_id"] ?? -1,
        status: json["status"] ?? "",
        user_comment: json["user_comment"] ?? "",
        owner_comment: json["owner_comment"] ?? "",
        final_price: json["final_price"] ?? -1,
        requested_date: json["requested_date"] ?? "",
        modified_date: json["modified_date"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,
        "coupon_used_id": coupon_used_id,
        "status": status,
        "user_comment": user_comment,
        "owner_comment": owner_comment,
        "final_price": final_price,
        "requested_date": requested_date,
        "modified_date": modified_date,
      };
}
