// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);

import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) =>
    EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) =>
    json.encode(data.toJson());

class EditProfileModel {
  EditProfileModel({
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.country,
    this.state,
    this.city,
    this.address,
    this.postalCode,
    this.aboutMe,
    this.occupation,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  String? phoneNumber;
  String? gender;
  DateTime? dateOfBirth;
  //String? dateOfBirth;
  String? country;
  String? state;
  String? city;
  String? address;
  String? postalCode;
  String? aboutMe;
  String? occupation;

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      EditProfileModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        phoneNumber: json["phoneNumber"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        //dateOfBirth: json["dateOfBirth"],
        state: json["state"],
        city: json["city"],
        address: json["address"],
        postalCode: json["postalCode"],
        aboutMe: json["aboutMe"],
        occupation: json["occupation"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "imageUrl": imageUrl,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "dateOfBirth":
            "${dateOfBirth!.toIso8601String()}-${dateOfBirth!.toIso8601String}-${dateOfBirth!.toIso8601String}",
        "country": country,
        "state": state,
        "city": city,
        "address": address,
        "postalCode": postalCode,
        "aboutMe": aboutMe,
        "occupation": occupation,
      };
}
