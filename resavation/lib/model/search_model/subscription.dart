import 'dart:convert';

class Subscription {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? monthlyPrice;
  double? quarterlyPrice;
  double? biannualPrice;
  double? annualPrice;

  Subscription({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.monthlyPrice,
    this.quarterlyPrice,
    this.biannualPrice,
    this.annualPrice,
  });

  @override
  String toString() {
    return 'Subscription(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, monthlyPrice: $monthlyPrice, quarterlyPrice: $quarterlyPrice, biannualPrice: $biannualPrice, annualPrice: $annualPrice)';
  }

  factory Subscription.fromMap(Map<String, dynamic> data) => Subscription(
        id: data['id'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        monthlyPrice: (data['monthlyPrice'] as num?)?.toDouble(),
        quarterlyPrice: (data['quarterlyPrice'] as num?)?.toDouble(),
        biannualPrice: (data['biannualPrice'] as num?)?.toDouble(),
        annualPrice: (data['annualPrice'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'monthlyPrice': monthlyPrice,
        'quarterlyPrice': quarterlyPrice,
        'biannualPrice': biannualPrice,
        'annualPrice': annualPrice,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Subscription].
  factory Subscription.fromJson(String data) {
    return Subscription.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Subscription] to a JSON string.
  String toJson() => json.encode(toMap());

  Subscription copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? monthlyPrice,
    double? quarterlyPrice,
    double? biannualPrice,
    double? annualPrice,
  }) {
    return Subscription(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      monthlyPrice: monthlyPrice ?? this.monthlyPrice,
      quarterlyPrice: quarterlyPrice ?? this.quarterlyPrice,
      biannualPrice: biannualPrice ?? this.biannualPrice,
      annualPrice: annualPrice ?? this.annualPrice,
    );
  }
}
