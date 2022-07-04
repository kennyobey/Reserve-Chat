import 'dart:convert';

class PropertyImage {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  PropertyImage({this.id, this.createdAt, this.updatedAt, this.imageUrl});

  @override
  String toString() {
    return 'PropertyImage(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, imageUrl: $imageUrl)';
  }

  factory PropertyImage.fromMap(Map<String, dynamic> data) => PropertyImage(
        id: data['id'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        imageUrl: data['imageUrl'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'imageUrl': imageUrl,
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

  PropertyImage copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
  }) {
    return PropertyImage(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
