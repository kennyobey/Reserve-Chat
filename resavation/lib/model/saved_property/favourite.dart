import 'dart:convert';

class Favourite {
  DateTime? createdAt;
  int? id;
  DateTime? updatedAt;

  Favourite({this.createdAt, this.id, this.updatedAt});

  factory Favourite.fromMap(Map<String, dynamic> data) => Favourite(
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        id: data['id'] as int?,
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt?.toIso8601String(),
        'id': id,
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Favourite].
  factory Favourite.fromJson(String data) {
    return Favourite.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Favourite] to a JSON string.
  String toJson() => json.encode(toMap());
}
