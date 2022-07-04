import 'dart:convert';

import 'package:collection/collection.dart';

class BankData {
  String? name;
  String? slug;
  String? code;
  String? longcode;
  dynamic gateway;
  bool? payWithBank;
  bool? active;
  bool? isDeleted;
  String? country;
  String? currency;
  String? type;
  int? id;
  String? createdAt;
  String? updatedAt;

  BankData({
    this.name,
    this.slug,
    this.code,
    this.longcode,
    this.gateway,
    this.payWithBank,
    this.active,
    this.isDeleted,
    this.country,
    this.currency,
    this.type,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Datum(name: $name, slug: $slug, code: $code, longcode: $longcode, gateway: $gateway, payWithBank: $payWithBank, active: $active, isDeleted: $isDeleted, country: $country, currency: $currency, type: $type, id: $id, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory BankData.fromMap(Map<String, dynamic> data) => BankData(
        name: data['name'] as String?,
        slug: data['slug'] as String?,
        code: data['code'] as String?,
        longcode: data['longcode'] as String?,
        gateway: data['gateway'] as dynamic,
        payWithBank: data['pay_with_bank'] as bool?,
        active: data['active'] as bool?,
        isDeleted: data['is_deleted'] as bool?,
        country: data['country'] as String?,
        currency: data['currency'] as String?,
        type: data['type'] as String?,
        id: data['id'] as int?,
        createdAt: data['createdAt'] as String?,
        updatedAt: data['updatedAt'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'slug': slug,
        'code': code,
        'longcode': longcode,
        'gateway': gateway,
        'pay_with_bank': payWithBank,
        'active': active,
        'is_deleted': isDeleted,
        'country': country,
        'currency': currency,
        'type': type,
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BankData].
  factory BankData.fromJson(String data) {
    return BankData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BankData] to a JSON string.
  String toJson() => json.encode(toMap());

  BankData copyWith({
    String? name,
    String? slug,
    String? code,
    String? longcode,
    dynamic gateway,
    bool? payWithBank,
    bool? active,
    bool? isDeleted,
    String? country,
    String? currency,
    String? type,
    int? id,
    String? createdAt,
    String? updatedAt,
  }) {
    return BankData(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      code: code ?? this.code,
      longcode: longcode ?? this.longcode,
      gateway: gateway ?? this.gateway,
      payWithBank: payWithBank ?? this.payWithBank,
      active: active ?? this.active,
      isDeleted: isDeleted ?? this.isDeleted,
      country: country ?? this.country,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BankData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      slug.hashCode ^
      code.hashCode ^
      longcode.hashCode ^
      gateway.hashCode ^
      payWithBank.hashCode ^
      active.hashCode ^
      isDeleted.hashCode ^
      country.hashCode ^
      currency.hashCode ^
      type.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
