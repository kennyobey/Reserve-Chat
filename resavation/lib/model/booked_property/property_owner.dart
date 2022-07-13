import 'dart:convert';

import 'favourite.dart';

class PropertyOwner {
  DateTime? createdAt;
  String? email;
  List<Favourite>? favourites;
  String? firstName;
  int? id;
  String? imageUrl;
  String? lastName;
  String? notification;
  DateTime? updatedAt;

  PropertyOwner({
    this.createdAt,
    this.email,
    this.favourites,
    this.firstName,
    this.id,
    this.imageUrl,
    this.lastName,
    this.notification,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'PropertyOwner(createdAt: $createdAt, email: $email, favourites: $favourites, firstName: $firstName, id: $id, imageUrl: $imageUrl, lastName: $lastName, notification: $notification, updatedAt: $updatedAt)';
  }

  factory PropertyOwner.fromMap(Map<String, dynamic> data) => PropertyOwner(
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        email: data['email'] as String?,
        favourites: (data['favourites'] as List<dynamic>?)
            ?.map((e) => Favourite.fromMap(e as Map<String, dynamic>))
            .toList(),
        firstName: data['firstName'] as String?,
        id: data['id'] as int?,
        imageUrl: data['imageUrl'] as String?,
        lastName: data['lastName'] as String?,
        notification: data['notification'] as String?,
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt?.toIso8601String(),
        'email': email,
        'favourites': favourites?.map((e) => e.toMap()).toList(),
        'firstName': firstName,
        'id': id,
        'imageUrl': imageUrl,
        'lastName': lastName,
        'notification': notification,
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PropertyOwner].
  factory PropertyOwner.fromJson(String data) {
    return PropertyOwner.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PropertyOwner] to a JSON string.
  String toJson() => json.encode(toMap());
}
