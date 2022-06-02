import 'dart:convert';

import 'package:collection/collection.dart';

class PriceRange {
  final int? max;
  final int? min;

  const PriceRange({this.max, this.min});

  @override
  String toString() => 'PriceRange(max: $max, min: $min)';

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

  PriceRange copyWith({
    int? max,
    int? min,
  }) {
    return PriceRange(
      max: max ?? this.max,
      min: min ?? this.min,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PriceRange) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => max.hashCode ^ min.hashCode;
}
