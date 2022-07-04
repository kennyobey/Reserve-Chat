import 'dart:convert';

import 'package:resavation/model/booked_property/property_owner.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/propety_model/user.dart';

class BookedPropertyContent {
  double? amount;
  String? checkInDate;
  DateTime? createdAt;
  int? id;
  String? paymentType;
  Property? property;
  PropertyOwner? propertyOwner;
  bool? status;
  String? subCategories;
  DateTime? updatedAt;
  User? user;

  BookedPropertyContent({
    this.amount,
    this.checkInDate,
    this.createdAt,
    this.id,
    this.paymentType,
    this.property,
    this.propertyOwner,
    this.status,
    this.subCategories,
    this.updatedAt,
    this.user,
  });

  @override
  String toString() {
    return 'Content(amount: $amount, checkInDate: $checkInDate, createdAt: $createdAt, id: $id, paymentType: $paymentType, property: $property, propertyOwner: $propertyOwner, status: $status, subCategories: $subCategories, updatedAt: $updatedAt, user: $user)';
  }

  factory BookedPropertyContent.fromMap(Map<String, dynamic> data) =>
      BookedPropertyContent(
        amount: data['amount'] as double?,
        checkInDate: data['checkInDate'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        id: data['id'] as int?,
        paymentType: data['paymentType'] as String?,
        property: data['property'] == null
            ? null
            : Property.fromMap(data['property'] as Map<String, dynamic>),
        propertyOwner: data['propertyOwner'] == null
            ? null
            : PropertyOwner.fromMap(
                data['propertyOwner'] as Map<String, dynamic>),
        status: data['status'] as bool?,
        subCategories: data['subCategories'] as String?,
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookedPropertyContent].
  factory BookedPropertyContent.fromJson(String data) {
    return BookedPropertyContent.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }
}
