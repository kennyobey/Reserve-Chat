// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.accessToken,
    this.email,
    this.id,
    this.roles,
    this.tokenType,
  });

  String? accessToken;
  String? email;
  int? id;
  List<String>? roles;
  String? tokenType;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    accessToken: json["accessToken"],
    email: json["email"],
    id: json["id"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    tokenType: json["tokenType"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "email": email,
    "id": id,
    "roles": List<dynamic>.from(roles!.map((x) => x)),
    "tokenType": tokenType,
  };
}
