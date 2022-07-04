import 'dart:convert';

import 'package:collection/collection.dart';

class TopStatesContent {
  String? cityName;
  String? state;
  String? createdAt;
  int? id;
  int? numberOfProperties;
  String? updatedAt;

  TopStatesContent({
    this.cityName,
    this.state,
    this.createdAt,
    this.id,
    this.numberOfProperties,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Content(cityName: $cityName, createdAt: $createdAt, id: $id, numberOfProperties: $numberOfProperties, updatedAt: $updatedAt)';
  }

  factory TopStatesContent.fromMap(Map<String, dynamic> data) =>
      TopStatesContent(
        cityName: data['cityName'] as String?,
        createdAt: data['createdAt'] as String?,
        state: data['state'] as String?,
        id: data['id'] as int?,
        numberOfProperties: data['numberOfProperties'] as int?,
        updatedAt: data['updatedAt'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'cityName': cityName,
        'createdAt': createdAt,
        'state': state,
        'id': id,
        'numberOfProperties': numberOfProperties,
        'updatedAt': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TopStatesContent].
  factory TopStatesContent.fromJson(String data) {
    return TopStatesContent.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopStatesContent] to a JSON string.
  String toJson() => json.encode(toMap());

  TopStatesContent copyWith({
    String? cityName,
    String? state,
    String? createdAt,
    int? id,
    int? numberOfProperties,
    String? updatedAt,
  }) {
    return TopStatesContent(
      cityName: cityName ?? this.cityName,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      numberOfProperties: numberOfProperties ?? this.numberOfProperties,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TopStatesContent) return false;
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
