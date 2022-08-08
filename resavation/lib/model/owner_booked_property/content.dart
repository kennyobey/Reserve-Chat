import 'dart:convert';
import 'package:resavation/model/propety_model/user.dart';
import 'property_owner.dart';
import 'package:resavation/model/propety_model/property_model.dart';

class OwnerBookedPropertyContent {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  PropertyOwner? propertyOwner;
  User? user;
  Property? property;
  String? checkInDate;
  String? paymentCycle;
  double? amount;
  String? subCategories;
  bool? status;

  OwnerBookedPropertyContent({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.propertyOwner,
    this.user,
    this.property,
    this.checkInDate,
    this.paymentCycle,
    this.amount,
    this.subCategories,
    this.status,
  });

  factory OwnerBookedPropertyContent.fromMap(Map<String, dynamic> data) =>
      OwnerBookedPropertyContent(
        id: data['id'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        propertyOwner: data['propertyOwner'] == null
            ? null
            : PropertyOwner.fromMap(
                data['propertyOwner'] as Map<String, dynamic>),
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        property: data['property'] == null
            ? null
            : Property.fromMap(data['property'] as Map<String, dynamic>),
        checkInDate: data['checkInDate'] as String?,
        paymentCycle: data['paymentCycle'] as String?,
        amount: data['amount'] as double?,
        subCategories: data['subCategories'] as String?,
        status: data['status'] as bool?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OwnerBookedPropertyContent].
  factory OwnerBookedPropertyContent.fromJson(String data) {
    return OwnerBookedPropertyContent.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }
}
