import 'dart:convert';

import 'package:collection/collection.dart';

class TopCategoriesContent {
  String? createdAt;
  int? id;
  int? numberOfProperties;
  String? propertyCategory;
  String? updatedAt;

  TopCategoriesContent({
    this.createdAt,
    this.id,
    this.numberOfProperties,
    this.propertyCategory,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Content(createdAt: $createdAt, id: $id, numberOfProperties: $numberOfProperties, propertyCategory: $propertyCategory, updatedAt: $updatedAt)';
  }

  factory TopCategoriesContent.fromMap(Map<String, dynamic> data) =>
      TopCategoriesContent(
        createdAt: data['createdAt'] as String?,
        id: data['id'] as int?,
        numberOfProperties: data['numberOfProperties'] as int?,
        propertyCategory: data['propertyCategory'] as String?,
        updatedAt: data['updatedAt'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt,
        'id': id,
        'numberOfProperties': numberOfProperties,
        'propertyCategory': propertyCategory,
        'updatedAt': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TopCategoriesContent].
  factory TopCategoriesContent.fromJson(String data) {
    return TopCategoriesContent.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopCategoriesContent] to a JSON string.
  String toJson() => json.encode(toMap());

  TopCategoriesContent copyWith({
    String? createdAt,
    int? id,
    int? numberOfProperties,
    String? propertyCategory,
    String? updatedAt,
  }) {
    return TopCategoriesContent(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      numberOfProperties: numberOfProperties ?? this.numberOfProperties,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TopCategoriesContent) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      createdAt.hashCode ^
      id.hashCode ^
      numberOfProperties.hashCode ^
      propertyCategory.hashCode ^
      updatedAt.hashCode;
}
