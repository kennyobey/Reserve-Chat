import 'dart:convert';

import 'favourite.dart';

class User {
  String? aboutMe;
  String? address;
  String? city;
  String? country;
  DateTime? createdAt;
  String? dateOfBirth;
  String? email;
  List<Favourite>? favourites;
  String? firstName;
  String? gender;
  int? id;
  String? imageUrl;
  String? lastName;
  String? notification;
  String? occupation;
  String? phoneNumber;
  String? postalCode;
  String? state;
  DateTime? updatedAt;

  User({
    this.aboutMe,
    this.address,
    this.city,
    this.country,
    this.createdAt,
    this.dateOfBirth,
    this.email,
    this.favourites,
    this.firstName,
    this.gender,
    this.id,
    this.imageUrl,
    this.lastName,
    this.notification,
    this.occupation,
    this.phoneNumber,
    this.postalCode,
    this.state,
    this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        aboutMe: data['aboutMe'] as String?,
        address: data['address'] as String?,
        city: data['city'] as String?,
        country: data['country'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        dateOfBirth: data['dateOfBirth'] as String?,
        email: data['email'] as String?,
        favourites: (data['favourites'] as List<dynamic>?)
            ?.map((e) => Favourite.fromMap(e as Map<String, dynamic>))
            .toList(),
        firstName: data['firstName'] as String?,
        gender: data['gender'] as String?,
        id: data['id'] as int?,
        imageUrl: data['imageUrl'] as String?,
        lastName: data['lastName'] as String?,
        notification: data['notification'] as String?,
        occupation: data['occupation'] as String?,
        phoneNumber: data['phoneNumber'] as String?,
        postalCode: data['postalCode'] as String?,
        state: data['state'] as String?,
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'aboutMe': aboutMe,
        'address': address,
        'city': city,
        'country': country,
        'createdAt': createdAt?.toIso8601String(),
        'dateOfBirth': dateOfBirth,
        'email': email,
        'favourites': favourites?.map((e) => e.toMap()).toList(),
        'firstName': firstName,
        'gender': gender,
        'id': id,
        'imageUrl': imageUrl,
        'lastName': lastName,
        'notification': notification,
        'occupation': occupation,
        'phoneNumber': phoneNumber,
        'postalCode': postalCode,
        'state': state,
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
