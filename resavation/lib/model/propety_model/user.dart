import 'dart:convert';

class User {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phoneNumber;
  dynamic gender;
  dynamic dateOfBirth;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic address;
  dynamic postalCode;
  String? aboutMe;
  dynamic occupation;
  String? imageUrl;
  dynamic notification;
  List<dynamic>? favourites;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.email,
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
    this.imageUrl,
    this.notification,
    this.favourites,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        firstName: data['firstName'] as String?,
        lastName: data['lastName'] as String?,
        email: data['email'] as String?,
        phoneNumber: data['phoneNumber'] as dynamic,
        gender: data['gender'] as dynamic,
        dateOfBirth: data['dateOfBirth'] as dynamic,
        country: data['country'] as dynamic,
        state: data['state'] as dynamic,
        city: data['city'] as dynamic,
        address: data['address'] as dynamic,
        postalCode: data['postalCode'] as dynamic,
        aboutMe: data['aboutMe'] as String?,
        occupation: data['occupation'] as dynamic,
        imageUrl: data['imageUrl'] as String?,
        notification: data['notification'] as dynamic,
        favourites: data['favourites'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'country': country,
        'state': state,
        'city': city,
        'address': address,
        'postalCode': postalCode,
        'aboutMe': aboutMe,
        'occupation': occupation,
        'imageUrl': imageUrl,
        'notification': notification,
        'favourites': favourites,
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
