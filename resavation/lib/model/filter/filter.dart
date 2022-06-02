import 'dart:convert';

import 'package:collection/collection.dart';

import 'amenity_count.dart';
import 'availability.dart';
import 'price_range.dart';

class Filter {
  final String? amenity;
  final AmenityCount? amenityCount;
  final Availability? availability;
  final PriceRange? priceRange;
  final String? propertyType;
  final double? surfaceArea;

  const Filter({
    this.amenity,
    this.amenityCount,
    this.availability,
    this.priceRange,
    this.propertyType,
    this.surfaceArea,
  });

  @override
  String toString() {
    return 'Filter(amenity: $amenity, amenityCount: $amenityCount, availability: $availability, priceRange: $priceRange, propertyType: $propertyType, surfaceArea: $surfaceArea)';
  }

  factory Filter.fromMap(Map<String, dynamic> data) => Filter(
        amenity: data['amenity'] as String?,
        amenityCount: data['amenityCount'] == null
            ? null
            : AmenityCount.fromMap(
                data['amenityCount'] as Map<String, dynamic>),
        availability: data['availability'] == null
            ? null
            : Availability.fromMap(
                data['availability'] as Map<String, dynamic>),
        priceRange: data['priceRange'] == null
            ? null
            : PriceRange.fromMap(data['priceRange'] as Map<String, dynamic>),
        propertyType: data['propertyType'] as String?,
        surfaceArea: data['surfaceArea'] as double?,
      );

  Map<String, dynamic> toMap() => {
        'amenity': amenity,
        'amenityCount': amenityCount?.toMap(),
        'availability': availability?.toMap(),
        'priceRange': priceRange?.toMap(),
        'propertyType': propertyType,
        'surfaceArea': surfaceArea,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Filter].
  factory Filter.fromJson(String data) {
    return Filter.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Filter] to a JSON string.
  String toJson() => json.encode(toMap());

  Filter copyWith({
    String? amenity,
    AmenityCount? amenityCount,
    Availability? availability,
    PriceRange? priceRange,
    String? propertyType,
    double? surfaceArea,
  }) {
    return Filter(
      amenity: amenity ?? this.amenity,
      amenityCount: amenityCount ?? this.amenityCount,
      availability: availability ?? this.availability,
      priceRange: priceRange ?? this.priceRange,
      propertyType: propertyType ?? this.propertyType,
      surfaceArea: surfaceArea ?? this.surfaceArea,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Filter) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      amenity.hashCode ^
      amenityCount.hashCode ^
      availability.hashCode ^
      priceRange.hashCode ^
      propertyType.hashCode ^
      surfaceArea.hashCode;
}
