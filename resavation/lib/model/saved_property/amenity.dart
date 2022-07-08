import 'dart:convert';

class Amenity {
  String? amenity;
  DateTime? createdAt;
  int? id;
  DateTime? updatedAt;

  Amenity({this.amenity, this.createdAt, this.id, this.updatedAt});

  factory Amenity.fromMap(Map<String, dynamic> data) => Amenity(
        amenity: data['amenity'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        id: data['id'] as int?,
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'amenity': amenity,
        'createdAt': createdAt?.toIso8601String(),
        'id': id,
        'updatedAt': updatedAt?.toIso8601String(),
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
}
