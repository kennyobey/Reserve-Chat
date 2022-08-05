import 'dart:convert';

class Filter {
  int? bathrooms;
  int? bathtubs;
  int? maxPrice;
  int? minPrice;
  int? packingSpace;
  String? propertyStatus;
  String? propertyType;
  double? surfaceArea;

  Filter({
    this.bathrooms,
    this.bathtubs,
    this.maxPrice,
    this.minPrice,
    this.packingSpace,
    this.propertyStatus,
    this.propertyType,
    this.surfaceArea,
  });

  factory Filter.fromMap(Map<String, dynamic> data) => Filter(
        bathrooms: data['bathrooms'] as int?,
        bathtubs: data['bathtubs'] as int?,
        maxPrice: data['maxPrice'] as int?,
        minPrice: data['minPrice'] as int?,
        packingSpace: data['packingSpace'] as int?,
        propertyStatus: data['propertyStatus'] as String?,
        propertyType: data['propertyType'] as String?,
        surfaceArea: data['surfaceArea'] as double?,
      );

  Map<String, dynamic> toMap() => {
        'bathrooms': bathrooms,
        'bathtubs': bathtubs,
        'maxPrice': maxPrice,
        'minPrice': minPrice,
        'packingSpace': packingSpace,
        'propertyStatus': propertyStatus,
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
