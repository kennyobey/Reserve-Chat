import 'dart:convert';

class PriceRange {
  int? max;
  int? min;

  PriceRange({this.max, this.min});

  factory PriceRange.fromMap(Map<String, dynamic> data) => PriceRange(
        max: data['max'] as int?,
        min: data['min'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'max': max,
        'min': min,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PriceRange].
  factory PriceRange.fromJson(String data) {
    return PriceRange.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PriceRange] to a JSON string.
  String toJson() => json.encode(toMap());
}
