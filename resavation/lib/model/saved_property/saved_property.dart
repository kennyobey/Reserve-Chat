import 'dart:convert';

import 'amenity.dart';
import 'availability_periods.dart';
import 'property_image.dart';
import 'property_rule.dart';
import 'subscription.dart';
import 'user.dart';

class SavedProperty {
  String? address;
  String? roomType;
  List<Amenity>? amenities;
  AvailabilityPeriods? availabilityPeriods;
  int? bathTubCount;
  int? bedroomCount;
  int? carSlot;
  String? city;
  String? country;
  DateTime? createdAt;
  String? description;
  bool? favourite;
  int? id;
  String? isLiveInSPace;
  String? isSpaceFurnished;
  String? isSpaceServiced;
  String? paymentType;
  String? propertyCategory;
  List<PropertyImage>? propertyImages;
  String? propertyName;
  List<PropertyRule>? propertyRule;
  String? propertyStatus;
  String? propertyStyle;
  String? propertyType;
  String? serviceType;
  double? spacePrice;
  String? state;
  Subscription? subscription;
  double? surfaceArea;
  DateTime? updatedAt;
  String? uploadStatus;
  User? user;
  String? verificationStatus;

  SavedProperty({
    this.address,
    this.amenities,
    this.availabilityPeriods,
    this.bathTubCount,
    this.bedroomCount,
    this.carSlot,
    this.city,
    this.country,
    this.createdAt,
    this.description,
    this.favourite,
    this.id,
    this.isLiveInSPace,
    this.roomType,
    this.isSpaceFurnished,
    this.isSpaceServiced,
    this.paymentType,
    this.propertyCategory,
    this.propertyImages,
    this.propertyName,
    this.propertyRule,
    this.propertyStatus,
    this.propertyStyle,
    this.propertyType,
    this.serviceType,
    this.spacePrice,
    this.state,
    this.subscription,
    this.surfaceArea,
    this.updatedAt,
    this.uploadStatus,
    this.user,
    this.verificationStatus,
  });

  factory SavedProperty.fromMap(Map<String, dynamic> data) => SavedProperty(
        address: data['address'] as String?,
        roomType: data['roomType'] as String?,
        amenities: (data['amenities'] as List<dynamic>?)
            ?.map((e) => Amenity.fromMap(e as Map<String, dynamic>))
            .toList(),
        availabilityPeriods: data['availabilityPeriods'] == null
            ? null
            : AvailabilityPeriods.fromMap(
                data['availabilityPeriods'] as Map<String, dynamic>),
        bathTubCount: data['bathTubCount'] as int?,
        bedroomCount: data['bedroomCount'] as int?,
        carSlot: data['carSlot'] as int?,
        city: data['city'] as String?,
        country: data['country'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        description: data['description'] as String?,
        favourite: data['favourite'] as bool?,
        id: data['id'] as int?,
        isLiveInSPace: data['isLiveInSPace'] as String?,
        isSpaceFurnished: data['isSpaceFurnished'] as String?,
        isSpaceServiced: data['isSpaceServiced'] as String?,
        paymentType: data['paymentType'] as String?,
        propertyCategory: data['propertyCategory'] as String?,
        propertyImages: (data['propertyImages'] as List<dynamic>?)
            ?.map((e) => PropertyImage.fromMap(e as Map<String, dynamic>))
            .toList(),
        propertyName: data['propertyName'] as String?,
        propertyRule: (data['propertyRule'] as List<dynamic>?)
            ?.map((e) => PropertyRule.fromMap(e as Map<String, dynamic>))
            .toList(),
        propertyStatus: data['propertyStatus'] as String?,
        propertyStyle: data['propertyStyle'] as String?,
        propertyType: data['propertyType'] as String?,
        serviceType: data['serviceType'] as String?,
        spacePrice: (data['spacePrice'] as num?)?.toDouble(),
        state: data['state'] as String?,
        subscription: data['subscription'] == null
            ? null
            : Subscription.fromMap(
                data['subscription'] as Map<String, dynamic>),
        surfaceArea: (data['surfaceArea'] as num?)?.toDouble(),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        uploadStatus: data['uploadStatus'] as String?,
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        verificationStatus: data['verificationStatus'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SavedProperty].
  factory SavedProperty.fromJson(String data) {
    return SavedProperty.fromMap(json.decode(data) as Map<String, dynamic>);
  }
}
