import 'dart:convert';

class PropertyRule {
  DateTime? createdAt;
  int? id;
  String? rule;
  DateTime? updatedAt;

  PropertyRule({this.createdAt, this.id, this.rule, this.updatedAt});

  factory PropertyRule.fromMap(Map<String, dynamic> data) => PropertyRule(
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        id: data['id'] as int?,
        rule: data['rule'] as String?,
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt?.toIso8601String(),
        'id': id,
        'rule': rule,
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PropertyRule].
  factory PropertyRule.fromJson(String data) {
    return PropertyRule.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PropertyRule] to a JSON string.
  String toJson() => json.encode(toMap());
}
