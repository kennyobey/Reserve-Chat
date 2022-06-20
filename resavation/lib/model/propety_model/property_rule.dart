import 'dart:convert';

class PropertyRule {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? rule;

  PropertyRule({this.id, this.createdAt, this.updatedAt, this.rule});

  @override
  String toString() {
    return 'PropertyRule(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, rule: $rule)';
  }

  factory PropertyRule.fromMap(Map<String, dynamic> data) => PropertyRule(
        id: data['id'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        rule: data['rule'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'rule': rule,
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

  PropertyRule copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rule,
  }) {
    return PropertyRule(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rule: rule ?? this.rule,
    );
  }
}
