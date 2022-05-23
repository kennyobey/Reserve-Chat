import 'dart:convert';

import 'package:collection/collection.dart';

class TopCitiesContent {
  String? cityName;
  String? createdAt;
  int? id;
  int? numberOfProperties;
  String? updatedAt;

  TopCitiesContent({
    this.cityName,
    this.createdAt,
    this.id,
    this.numberOfProperties,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Content(cityName: $cityName, createdAt: $createdAt, id: $id, numberOfProperties: $numberOfProperties, updatedAt: $updatedAt)';
  }

  factory TopCitiesContent.fromMap(Map<String, dynamic> data) =>
      TopCitiesContent(
        cityName: data['cityName'] as String?,
        createdAt: data['createdAt'] as String?,
        id: data['id'] as int?,
        numberOfProperties: data['numberOfProperties'] as int?,
        updatedAt: data['updatedAt'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'cityName': cityName,
        'createdAt': createdAt,
        'id': id,
        'numberOfProperties': numberOfProperties,
        'updatedAt': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TopCitiesContent].
  factory TopCitiesContent.fromJson(String data) {
    return TopCitiesContent.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopCitiesContent] to a JSON string.
  String toJson() => json.encode(toMap());

  TopCitiesContent copyWith({
    String? cityName,
    String? createdAt,
    int? id,
    int? numberOfProperties,
    String? updatedAt,
  }) {
    return TopCitiesContent(
      cityName: cityName ?? this.cityName,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      numberOfProperties: numberOfProperties ?? this.numberOfProperties,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TopCitiesContent) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      cityName.hashCode ^
      createdAt.hashCode ^
      id.hashCode ^
      numberOfProperties.hashCode ^
      updatedAt.hashCode;
}
