import 'dart:convert';

import 'package:collection/collection.dart';

List<Property> propertyFromJson(String str) {
  final data = json.decode(str);

  if (data['property'] != null) {
    return (data['property'] as List<dynamic>)
        .map((data) => Property.fromJson(data))
        .toList();
  } else {
    return [];
  }
}

class Property {
  int? id;
  String? createdAt;

  String? updatedAt;
  String? spaceType;
  String? propertyStyle;
  String? propertyStatus;
  String? isSpaceServiced;
  String? isSpaceFurnished;
  String? isLiveInSPace;
  int? bedroomCount;
  int? bathTubCount;
  int? carSlot;
  String? imageUrl;
  String? propertyName;
  String? description;
  String? country;
  String? state;
  String? city;
  String? address;
  dynamic paymentType;
  double? surfaceArea;

  int? spacePrice;
  String? verificationStatus;
  String? propertyCategory;
  bool? favourite;

  Property({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.spaceType,
    this.propertyStyle,
    this.propertyStatus,
    this.isSpaceServiced,
    this.isSpaceFurnished,
    this.isLiveInSPace,
    this.bedroomCount,
    this.bathTubCount,
    this.carSlot,
    this.imageUrl,
    this.propertyName,
    this.description,
    this.country,
    this.state,
    this.city,
    this.address,
    this.paymentType,
    this.surfaceArea,
    this.spacePrice,
    this.verificationStatus,
    this.propertyCategory,
    this.favourite,
  });

  @override
  String toString() {
    return 'Property(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, spaceType: $spaceType, propertyStyle: $propertyStyle, propertyStatus: $propertyStatus, isSpaceServiced: $isSpaceServiced, isSpaceFurnished: $isSpaceFurnished, isLiveInSPace: $isLiveInSPace, bedroomCount: $bedroomCount, bathTubCount: $bathTubCount, carSlot: $carSlot, imageUrl: $imageUrl, propertyName: $propertyName, description: $description, country: $country, state: $state, city: $city, address: $address, paymentType: $paymentType, surfaceArea: $surfaceArea, spacePrice: $spacePrice, verificationStatus: $verificationStatus, propertyCategory: $propertyCategory, favourite: $favourite)';
  }

  factory Property.fromMap(Map<String, dynamic> data) => Property(
        id: data['id'] as int?,
        createdAt: data['createdAt'] as String?,
        updatedAt: data['updatedAt'] as String?,
        spaceType: data['spaceType'] as String?,
        propertyStyle: data['propertyStyle'] as String?,
        propertyStatus: data['propertyStatus'] as String?,
        isSpaceServiced: data['isSpaceServiced'] as String?,
        isSpaceFurnished: data['isSpaceFurnished'] as String?,
        isLiveInSPace: data['isLiveInSPace'] as String?,
        bedroomCount: data['bedroomCount'] as int?,
        bathTubCount: data['bathTubCount'] as int?,
        carSlot: data['carSlot'] as int?,
        imageUrl: data['imageUrl'] as String?,
        propertyName: data['propertyName'] as String?,
        description: data['description'] as String?,
        country: data['country'] as String?,
        state: data['state'] as String?,
        city: data['city'] as String?,
        address: data['address'] as String?,
        paymentType: data['paymentType'] as dynamic,
        surfaceArea: data['surfaceArea'] as double?,
        //todo spacePrice: data['spacePrice'] as int?,
        spacePrice: 50000,
        verificationStatus: data['verificationStatus'] as String?,
        propertyCategory: data['propertyCategory'] as String?,
        favourite: data['favourite'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'spaceType': spaceType,
        'propertyStyle': propertyStyle,
        'propertyStatus': propertyStatus,
        'isSpaceServiced': isSpaceServiced,
        'isSpaceFurnished': isSpaceFurnished,
        'isLiveInSPace': isLiveInSPace,
        'bedroomCount': bedroomCount,
        'bathTubCount': bathTubCount,
        'carSlot': carSlot,
        'imageUrl': imageUrl,
        'propertyName': propertyName,
        'description': description,
        'country': country,
        'state': state,
        'city': city,
        'address': address,
        'paymentType': paymentType,
        'surfaceArea': surfaceArea,
        'spacePrice': spacePrice,
        'verificationStatus': verificationStatus,
        'propertyCategory': propertyCategory,
        'favourite': favourite,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Property].
  factory Property.fromJson(String data) {
    return Property.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Property] to a JSON string.
  String toJson() => json.encode(toMap());

  Property copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? spaceType,
    String? propertyStyle,
    String? propertyStatus,
    String? isSpaceServiced,
    String? isSpaceFurnished,
    String? isLiveInSPace,
    int? bedroomCount,
    int? bathTubCount,
    int? carSlot,
    String? imageUrl,
    String? propertyName,
    String? description,
    String? country,
    String? state,
    String? city,
    String? address,
    dynamic paymentType,
    double? surfaceArea,
    int? spacePrice,
    String? verificationStatus,
    String? propertyCategory,
    bool? favourite,
  }) {
    return Property(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      spaceType: spaceType ?? this.spaceType,
      propertyStyle: propertyStyle ?? this.propertyStyle,
      propertyStatus: propertyStatus ?? this.propertyStatus,
      isSpaceServiced: isSpaceServiced ?? this.isSpaceServiced,
      isSpaceFurnished: isSpaceFurnished ?? this.isSpaceFurnished,
      isLiveInSPace: isLiveInSPace ?? this.isLiveInSPace,
      bedroomCount: bedroomCount ?? this.bedroomCount,
      bathTubCount: bathTubCount ?? this.bathTubCount,
      carSlot: carSlot ?? this.carSlot,
      imageUrl: imageUrl ?? this.imageUrl,
      propertyName: propertyName ?? this.propertyName,
      description: description ?? this.description,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      address: address ?? this.address,
      paymentType: paymentType ?? this.paymentType,
      surfaceArea: surfaceArea ?? this.surfaceArea,
      spacePrice: spacePrice ?? this.spacePrice,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      favourite: favourite ?? this.favourite,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Property) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      spaceType.hashCode ^
      propertyStyle.hashCode ^
      propertyStatus.hashCode ^
      isSpaceServiced.hashCode ^
      isSpaceFurnished.hashCode ^
      isLiveInSPace.hashCode ^
      bedroomCount.hashCode ^
      bathTubCount.hashCode ^
      carSlot.hashCode ^
      imageUrl.hashCode ^
      propertyName.hashCode ^
      description.hashCode ^
      country.hashCode ^
      state.hashCode ^
      city.hashCode ^
      address.hashCode ^
      paymentType.hashCode ^
      surfaceArea.hashCode ^
      spacePrice.hashCode ^
      verificationStatus.hashCode ^
      propertyCategory.hashCode ^
      favourite.hashCode;
}
