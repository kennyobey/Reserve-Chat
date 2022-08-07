import 'dart:convert';

import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/propety_model/user.dart';

import 'property_owner.dart';

class TenantBookedPropertyContent {
  double? amount;
  String? checkInDate;
  DateTime? createdAt;
  int? id;
  String? paymentCycle;
  Property? property;
  PropertyOwner? propertyOwner;
  bool? status;
  bool? hasTenantPaid;
  String? subCategories;
  DateTime? updatedAt;
  User? user;
  TenantBookedPropertyContent({
    this.amount,
    this.checkInDate,
    this.createdAt,
    this.id,
    this.paymentCycle,
    this.property,
    this.propertyOwner,
    this.status,
    this.hasTenantPaid,
    this.subCategories,
    this.updatedAt,
    this.user,
  });

  @override
  String toString() {
    return 'Content(amount: $amount, checkInDate: $checkInDate, createdAt: $createdAt, id: $id, paymentType: $paymentCycle, property: $property, propertyOwner: $propertyOwner, status: $status, subCategories: $subCategories, updatedAt: $updatedAt, user: $user)';
  }

  factory TenantBookedPropertyContent.fromMap(Map<String, dynamic> data) =>
      TenantBookedPropertyContent(
        amount: data['amount'] as double?,
        checkInDate: data['checkInDate'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        id: data['id'] as int?,
        paymentCycle: data['paymentCycle'] as String?,
        property: data['property'] == null
            ? null
            : Property.fromMap(data['property'] as Map<String, dynamic>),
        propertyOwner: data['propertyOwner'] == null
            ? null
            : PropertyOwner.fromMap(
                data['propertyOwner'] as Map<String, dynamic>),
        status: data['status'] as bool?,
        hasTenantPaid: data['hasTenantPaid'] as bool?,
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
  /// Parses the string and returns the resulting Json object as [TenantBookedPropertyContent].
  factory TenantBookedPropertyContent.fromJson(String data) {
    return TenantBookedPropertyContent.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }
}
