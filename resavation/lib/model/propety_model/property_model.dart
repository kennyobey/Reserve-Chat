import 'dart:convert';

import '../search_model/subscription.dart';
import 'amenity.dart';
import 'availability_periods.dart';
import 'property_image.dart';
import 'property_rule.dart';
import 'user.dart';

class Property {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  String? propertyType;
  String? propertyStyle;
  String? propertyStatus;
  String? isSpaceServiced;
  String? isSpaceFurnished;
  String? isLiveInSPace;
  int? bedroomCount;
  int? bathTubCount;
  int? carSlot;
  String? propertyName;
  String? description;
  String? country;
  String? state;
  String? city;
  String? address;
  String? serviceType;
  dynamic paymentType;
  String? roomType;
  int? unit;
  double? surfaceArea;
  double? spacePrice;
  String? verificationStatus;
  String? propertyCategory;
  List<PropertyRule>? propertyRule;
  List<PropertyImage>? propertyImages;
  List<Amenity>? amenities;
  AvailabilityPeriods? availabilityPeriods;
  Subscription? subscription;
  bool? favourite;

  Property({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.propertyType,
    this.propertyStyle,
    this.propertyStatus,
    this.isSpaceServiced,
    this.isSpaceFurnished,
    this.isLiveInSPace,
    this.bedroomCount,
    this.bathTubCount,
    this.roomType,
    this.unit,
    this.carSlot,
    this.propertyName,
    this.description,
    this.country,
    this.state,
    this.city,
    this.address,
    this.serviceType,
    this.paymentType,
    this.surfaceArea,
    this.spacePrice,
    this.verificationStatus,
    this.propertyCategory,
    this.propertyRule,
    this.propertyImages,
    this.amenities,
    this.availabilityPeriods,
    this.subscription,
    this.favourite,
  });

  @override
  String toString() {
    return 'Content(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, propertyType: $propertyType, propertyStyle: $propertyStyle, propertyStatus: $propertyStatus, isSpaceServiced: $isSpaceServiced, isSpaceFurnished: $isSpaceFurnished, isLiveInSPace: $isLiveInSPace, bedroomCount: $bedroomCount, bathTubCount: $bathTubCount, carSlot: $carSlot, propertyName: $propertyName, description: $description, country: $country, state: $state, city: $city, address: $address, serviceType: $serviceType, paymentType: $paymentType, surfaceArea: $surfaceArea, spacePrice: $spacePrice, verificationStatus: $verificationStatus, propertyCategory: $propertyCategory, propertyRule: $propertyRule, propertyImages: $propertyImages, amenities: $amenities, availabilityPeriods: $availabilityPeriods, subscription: $subscription, favourite: $favourite)';
  }

  factory Property.fromMap(Map<String, dynamic> data) => Property(
        id: data['id'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        propertyType: data['propertyType'] as String?,
        propertyStyle: data['propertyStyle'] as String?,
        propertyStatus: data['propertyStatus'] as String?,
        isSpaceServiced: data['isSpaceServiced'] as String?,
        isSpaceFurnished: data['isSpaceFurnished'] as String?,
        isLiveInSPace: data['isLiveInSPace'] as String?,
        bedroomCount: data['bedroomCount'] as int?,
        bathTubCount: data['bathTubCount'] as int?,
        carSlot: data['carSlot'] as int?,
        propertyName: data['propertyName'] as String?,
        description: data['description'] as String?,
        country: data['country'] as String?,
        state: data['state'] as String?,
        city: data['city'] as String?,
        address: data['address'] as String?,
        serviceType: data['serviceType'] as String?,
        unit: data['unit'] as int?,
        roomType: data['roomType'] as String?,
        paymentType: data['paymentType'] as dynamic,
        surfaceArea: (data['surfaceArea'] as num?)?.toDouble(),
        spacePrice: (data['spacePrice'] as num?)?.toDouble(),
        verificationStatus: data['verificationStatus'] as String?,
        propertyCategory: data['propertyCategory'] as String?,
        propertyRule: (data['propertyRule'] as List<dynamic>?)
            ?.map((e) => PropertyRule.fromMap(e as Map<String, dynamic>))
            .toList(),
        propertyImages: (data['propertyImages'] as List<dynamic>?)
            ?.map((e) => PropertyImage.fromMap(e as Map<String, dynamic>))
            .toList(),
        amenities: (data['amenities'] as List<dynamic>?)
            ?.map((e) => Amenity.fromMap(e as Map<String, dynamic>))
            .toList(),
        availabilityPeriods: data['availabilityPeriods'] == null
            ? null
            : AvailabilityPeriods.fromMap(
                data['availabilityPeriods'] as Map<String, dynamic>),
        subscription: data['subscription'] == null
            ? null
            : Subscription.fromMap(
                data['subscription'] as Map<String, dynamic>),
        favourite: data['favourite'] as bool?,
      );

  factory Property.fromJson(String data) {
    return Property.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  Property copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? propertyType,
    String? propertyStyle,
    String? propertyStatus,
    String? isSpaceServiced,
    String? isSpaceFurnished,
    String? isLiveInSPace,
    int? bedroomCount,
    int? bathTubCount,
    int? carSlot,
    int? unit,
    String? roomType,
    String? propertyName,
    String? description,
    String? country,
    String? state,
    String? city,
    String? address,
    String? serviceType,
    dynamic paymentType,
    double? surfaceArea,
    double? spacePrice,
    String? verificationStatus,
    String? propertyCategory,
    List<PropertyRule>? propertyRule,
    List<PropertyImage>? propertyImages,
    List<Amenity>? amenities,
    AvailabilityPeriods? availabilityPeriods,
    Subscription? subscription,
    bool? favourite,
  }) {
    return Property(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      propertyType: propertyType ?? this.propertyType,
      propertyStyle: propertyStyle ?? this.propertyStyle,
      propertyStatus: propertyStatus ?? this.propertyStatus,
      isSpaceServiced: isSpaceServiced ?? this.isSpaceServiced,
      unit: unit ?? this.unit,
      roomType: roomType ?? this.roomType,
      isSpaceFurnished: isSpaceFurnished ?? this.isSpaceFurnished,
      isLiveInSPace: isLiveInSPace ?? this.isLiveInSPace,
      bedroomCount: bedroomCount ?? this.bedroomCount,
      bathTubCount: bathTubCount ?? this.bathTubCount,
      carSlot: carSlot ?? this.carSlot,
      propertyName: propertyName ?? this.propertyName,
      description: description ?? this.description,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      address: address ?? this.address,
      serviceType: serviceType ?? this.serviceType,
      paymentType: paymentType ?? this.paymentType,
      surfaceArea: surfaceArea ?? this.surfaceArea,
      spacePrice: spacePrice ?? this.spacePrice,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      propertyRule: propertyRule ?? this.propertyRule,
      propertyImages: propertyImages ?? this.propertyImages,
      amenities: amenities ?? this.amenities,
      availabilityPeriods: availabilityPeriods ?? this.availabilityPeriods,
      subscription: subscription ?? this.subscription,
      favourite: favourite ?? this.favourite,
    );
  }
}
