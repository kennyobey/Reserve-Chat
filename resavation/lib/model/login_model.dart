import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));
LoginModel loginFromOldModel(String str, LoginModel loginModel) =>
    LoginModel.fromOldModel(json.decode(str), loginModel);

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.accessToken = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.imageUrl = '',
    this.id = -1,
    this.accessRoles = const [],
    this.tokenType = '',
    this.role = '',
  });

  String accessToken;
  String email;
  String imageUrl;
  int id;
  List<String> accessRoles;
  String tokenType;
  String role;
  String firstName;
  String lastName;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final token = json["accessToken"] ?? '';

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return LoginModel(
      accessToken: token,
      email: json["email"] ?? '',
      firstName: decodedToken["firstname"] ?? '',
      role: decodedToken["role"] ?? '',
      lastName: decodedToken["lastname"] ?? '',
      imageUrl: decodedToken["imageUrl"] ?? '',
      id: json["id"] ?? '',
      accessRoles: List<String>.from(json["roles"].map((x) => x)),
      tokenType: json["tokenType"] ?? '',
    );
  }

  factory LoginModel.fromOldModel(
      Map<String, dynamic> json, final LoginModel loginModel) {
    final token = json["token"] ?? '';

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return LoginModel(
      accessToken: token,
      email: loginModel.email,
      firstName: decodedToken["firstname"] ?? '',
      role: decodedToken["role"] ?? '',
      lastName: decodedToken["lastname"] ?? '',
      imageUrl: decodedToken["imageUrl"] ?? '',
      id: loginModel.id,
      accessRoles: loginModel.accessRoles,
      tokenType: json["tokenType"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "email": email,
        "id": id,
        "role": role,
        "firstName": firstName,
        "lastName": lastName,
        "roles": List<dynamic>.from(accessRoles.map((x) => x)),
        "tokenType": tokenType,
      };
}
