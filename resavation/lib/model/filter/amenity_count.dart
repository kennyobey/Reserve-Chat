import 'dart:convert';

import 'package:collection/collection.dart';

class AmenityCount {
  final int? bathTubCount;
  final int? bedRoomCount;
  final int? carSlotCount;

  const AmenityCount({
    this.bathTubCount,
    this.bedRoomCount,
    this.carSlotCount,
  });

  @override
  String toString() {
    return 'AmenityCount(bathTubCount: $bathTubCount, bedRoomCount: $bedRoomCount, carSlotCount: $carSlotCount)';
  }

  factory AmenityCount.fromMap(Map<String, dynamic> data) => AmenityCount(
        bathTubCount: data['bathTubCount'] as int?,
        bedRoomCount: data['bedRoomCount'] as int?,
        carSlotCount: data['carSlotCount'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'bathTubCount': bathTubCount,
        'bedRoomCount': bedRoomCount,
        'carSlotCount': carSlotCount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AmenityCount].
  factory AmenityCount.fromJson(String data) {
    return AmenityCount.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AmenityCount] to a JSON string.
  String toJson() => json.encode(toMap());

  AmenityCount copyWith({
    int? bathTubCount,
    int? bedRoomCount,
    int? carSlotCount,
  }) {
    return AmenityCount(
      bathTubCount: bathTubCount ?? this.bathTubCount,
      bedRoomCount: bedRoomCount ?? this.bedRoomCount,
      carSlotCount: carSlotCount ?? this.carSlotCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AmenityCount) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      bathTubCount.hashCode ^ bedRoomCount.hashCode ^ carSlotCount.hashCode;
}
