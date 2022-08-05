import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:resavation/utility/app_preferences.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));
LoginModel loginFromOldModel(String str, LoginModel loginModel) =>
    LoginModel.fromOldModel(json.decode(str), loginModel);
LoginModel loginFromRefreshToken(String str) =>
    LoginModel.fromRefreshToken(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.accessToken = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.tokenExpiry = 0,
    this.imageUrl = '',
    this.refreshToken = '',
    this.id = -1,
    this.accessRoles = const [],
    this.tokenType = '',
    this.role = '',
  });
  String refreshToken;
  String accessToken;
  String email;
  String imageUrl;
  int id;
  List<String> accessRoles;
  String tokenType;
  int tokenExpiry;
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
      tokenExpiry: decodedToken["exp"] ?? 0,
      id: json["id"] ?? -1,
      refreshToken: json["refreshToken"] ?? '',
      tokenType: json["tokenType"] ?? '',
      accessRoles: List<String>.from(
        json["roles"].map((x) => x),
      ),
    );
  }

  factory LoginModel.fromOldModel(
      Map<String, dynamic> json, final LoginModel loginModel) {
    final token = json["token"] ?? '';

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return LoginModel(
      accessToken: token,
      email: loginModel.email,
      refreshToken: json["refreshToken"] ?? '',
      firstName: decodedToken["firstname"] ?? '',
      tokenExpiry: decodedToken["exp"] ?? 0,
      role: decodedToken["role"] ?? '',
      lastName: decodedToken["lastname"] ?? '',
      imageUrl: decodedToken["imageUrl"] ?? '',
      id: loginModel.id,
      accessRoles: loginModel.accessRoles,
      tokenType: json["tokenType"] ?? '',
    );
  }

  factory LoginModel.fromRefreshToken(Map<String, dynamic> json) {
    final token = json["accessToken"] ?? '';

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return LoginModel(
      accessToken: token,
      email: decodedToken["email"] ?? '',
      refreshToken: json["refreshToken"] ?? '',
      firstName: decodedToken["firstname"] ?? '',
      tokenExpiry: decodedToken["exp"] ?? 0,
      role: decodedToken["role"] ?? '',
      lastName: decodedToken["lastname"] ?? '',
      imageUrl: decodedToken["imageUrl"] ?? '',
      id: decodedToken["id"] ?? -1,
      accessRoles: AppPreferences.getAccessRoles,
      tokenType: AppPreferences.getTokenType,
    );
  }

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "email": email,
        "refreshToken": refreshToken,
        "id": id,
        "role": role,
        "firstName": firstName,
        "exp": tokenExpiry,
        "lastName": lastName,
        "roles": List<dynamic>.from(accessRoles.map((x) => x)),
        "tokenType": tokenType,
      };
}
