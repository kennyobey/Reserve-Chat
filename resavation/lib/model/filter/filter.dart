import 'dart:convert';

import 'amenity_count.dart';
import 'availability.dart';
import 'price_range.dart';

class Filter {
  AmenityCount? amenityCount;
  Availability? availability;
  PriceRange? priceRange;
  String? propertyType;
  double? surfaceArea;

  Filter({
    this.amenityCount,
    this.availability,
    this.priceRange,
    this.propertyType,
    this.surfaceArea,
  });

  factory Filter.fromMap(Map<String, dynamic> data) => Filter(
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
}
