import 'dart:convert';

class Subscription {
  double? annualPrice;
  double? biannualPrice;
  DateTime? createdAt;
  int? id;
  double? monthlyPrice;
  double? quarterlyPrice;
  DateTime? updatedAt;

  Subscription({
    this.annualPrice,
    this.biannualPrice,
    this.createdAt,
    this.id,
    this.monthlyPrice,
    this.quarterlyPrice,
    this.updatedAt,
  });

  factory Subscription.fromMap(Map<String, dynamic> data) => Subscription(
        annualPrice: (data['annualPrice'] as num?)?.toDouble(),
        biannualPrice: (data['biannualPrice'] as num?)?.toDouble(),
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        id: data['id'] as int?,
        monthlyPrice: (data['monthlyPrice'] as num?)?.toDouble(),
        quarterlyPrice: (data['quarterlyPrice'] as num?)?.toDouble(),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'annualPrice': annualPrice,
        'biannualPrice': biannualPrice,
        'createdAt': createdAt?.toIso8601String(),
        'id': id,
        'monthlyPrice': monthlyPrice,
        'quarterlyPrice': quarterlyPrice,
        'updatedAt': updatedAt?.toIso8601String(),
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
}
