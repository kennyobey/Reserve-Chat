import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.accessToken = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.imageUrl = '',
    this.id = -1,
    this.roles = const [],
    this.tokenType = '',
  });

  String accessToken;
  String email;
  String imageUrl;
  int id;
  List<String> roles;
  String tokenType;
  String firstName;
  String lastName;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final token = json["accessToken"] ?? '';

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return LoginModel(
      accessToken: token,
      email: json["email"] ?? '',
      firstName: decodedToken["firstname"] ?? '',
      lastName: decodedToken["lastname"] ?? '',
      imageUrl: decodedToken["imageUrl"] ?? '',
      id: json["id"] ?? '',
      roles: List<String>.from(json["roles"].map((x) => x)),
      tokenType: json["tokenType"] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "email": email,
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "tokenType": tokenType,
      };
}
