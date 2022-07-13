import 'dart:convert';

class AvailabilityPeriods {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? startDate;
  DateTime? endDate;

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
      startDate: data['startDate'] == null
          ? null
          : DateTime.parse(data['startDate'] as String),
      endDate: data['endDate'] == null
          ? null
          : DateTime.parse(data['endDate'] as String),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AvailabilityPeriods].
  factory AvailabilityPeriods.fromJson(String data) {
    return AvailabilityPeriods.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  AvailabilityPeriods copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startDate,
    DateTime? endDate,
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
