import 'dart:convert';

class AvailabilityPeriods {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? startDate;
  String? endDate;

  AvailabilityPeriods({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.startDate,
    this.endDate,
  });

  @override
  String toString() {
    return 'AvailabilityPeriods(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, startDate: $startDate, endDate: $endDate)';
  }

  factory AvailabilityPeriods.fromMap(Map<String, dynamic> data) {
    return AvailabilityPeriods(
      id: data['id'] as int?,
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] == null
          ? null
          : DateTime.parse(data['updatedAt'] as String),
      startDate: data['startDate'] as String?,
      endDate: data['endDate'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'startDate': startDate,
        'endDate': endDate,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AvailabilityPeriods].
  factory AvailabilityPeriods.fromJson(String data) {
    return AvailabilityPeriods.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AvailabilityPeriods] to a JSON string.
  String toJson() => json.encode(toMap());

  AvailabilityPeriods copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? startDate,
    String? endDate,
  }) {
    return AvailabilityPeriods(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
