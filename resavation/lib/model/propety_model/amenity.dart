import 'dart:convert';

class Amenity {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? amenity;

  Amenity({this.id, this.createdAt, this.updatedAt, this.amenity});

  @override
  String toString() {
    return 'Amenity(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, amenity: $amenity)';
  }

  factory Amenity.fromMap(Map<String, dynamic> data) => Amenity(
        id: data['id'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        amenity: data['amenity'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'amenity': amenity,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Amenity].
  factory Amenity.fromJson(String data) {
    return Amenity.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Amenity] to a JSON string.
  String toJson() => json.encode(toMap());

  Amenity copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? amenity,
  }) {
    return Amenity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      amenity: amenity ?? this.amenity,
    );
  }
}
