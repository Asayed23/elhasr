// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

// List<Product> productFromJson(String str) =>
//     List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

// String productToJson(List<Product> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User(
      {this.accountId = -1,
      this.id = -1,
      this.username = "",
      this.password = "",
      this.email = "",
      this.phoneNumber = "",
      this.fullName = "",
      this.city = "",
      this.country = "",
      this.image = "",
      this.accountType = "",
      this.caneditContact = false,
      this.canshowcontact = false,
      this.token = "",
      this.playerId = -1,
      this.membership = "Free",
      this.memberShipExpireDate = "1/1/2090",
      this.accountToken = "",
      this.showbalance = 0,
      this.videobalance = 0,
      this.adsbalance = 0,
      this.playerbalance = 0,
      this.profileBalance = 0,
      this.showType = ""});

  int id;
  String username;
  String email;
  String password;
  String phoneNumber;
  String fullName;
  String city;
  String country;
  String image;
  String accountType;
  String token;
  int playerId;
  String membership;
  String memberShipExpireDate;
  int accountId;
  String accountToken;
  int showbalance;
  int videobalance;
  int adsbalance;
  int playerbalance;
  String showType;
  bool caneditContact;
  bool canshowcontact;
  int profileBalance;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        fullName: json["fullName"],
        // city: json["city"],
        // country: json["country"],
        // image: json["image"],
        accountType: json["accountType"],
        playerId: json["playerId"] ?? -1,
        token: json["token"],
        membership: json['membership'] ?? "free",
        memberShipExpireDate: json['memberShipExpireDate'] ?? "1/1/2090",
        accountId: json['accountId'] ?? -1,
        accountToken: json['accountToken'] ?? "",
        showbalance: json["showbalance"] ?? 0,
        videobalance: json["videobalance"] ?? 0,
        adsbalance: json["adsbalance"] ?? 0,
        playerbalance: json["playerbalance"] ?? 0,
        showType: json["showType"] ?? "",
        profileBalance: json["profileBalance"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phoneNumber": phoneNumber,
        "accountType": accountType,
        "playerId": playerId,
        "token": token,
        "membership": membership,
        "memberShipExpireDate": memberShipExpireDate,
        "accountId": accountId,
        "accountToken": accountToken,
        "showType": showType,
        "fullName": fullName,
        "profileBalance": profileBalance,
      };
}
