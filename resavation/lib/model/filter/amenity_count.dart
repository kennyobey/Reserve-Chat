import 'dart:convert';

class AmenityCount {
  int? bathTubCount;
  int? bedRoomCount;
  int? carSlotCount;

  AmenityCount({this.bathTubCount, this.bedRoomCount, this.carSlotCount});

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
}
