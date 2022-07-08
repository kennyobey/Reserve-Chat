import 'dart:convert';

class PropertyImage {
  DateTime? createdAt;
  int? id;
  String? imageUrl;
  DateTime? updatedAt;

  PropertyImage({this.createdAt, this.id, this.imageUrl, this.updatedAt});

  factory PropertyImage.fromMap(Map<String, dynamic> data) => PropertyImage(
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        id: data['id'] as int?,
        imageUrl: data['imageUrl'] as String?,
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt?.toIso8601String(),
        'id': id,
        'imageUrl': imageUrl,
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PropertyImage].
  factory PropertyImage.fromJson(String data) {
    return PropertyImage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PropertyImage] to a JSON string.
  String toJson() => json.encode(toMap());
}
