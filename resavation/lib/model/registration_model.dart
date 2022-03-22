import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  RegistrationModel({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.message,
    required this.roles,
  });

  String email;
  String firstname;
  String lastname;
  String message;
  List<Role> roles;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    message: json["message"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "message": message,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}

class Role {
  Role({
    required this.id,
    required this.name,
  });

  int id;
  List<String> name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: List<String>.from(json["name"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": List<dynamic>.from(name.map((x) => x)),
  };
}