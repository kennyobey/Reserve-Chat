import 'dart:convert';

import 'package:collection/collection.dart';

import 'datum.dart';

class BankDetails {
  bool? status;
  String? message;
  List<BankData>? data;

  BankDetails({this.status, this.message, this.data});

  @override
  String toString() {
    return 'BankDetails(status: $status, message: $message, data: $data)';
  }

  factory BankDetails.fromMap(Map<String, dynamic> data) => BankDetails(
        status: data['status'] as bool?,
        message: data['message'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => BankData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BankDetails].
  factory BankDetails.fromJson(String data) {
    return BankDetails.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BankDetails] to a JSON string.
  String toJson() => json.encode(toMap());

  BankDetails copyWith({
    bool? status,
    String? message,
    List<BankData>? data,
  }) {
    return BankDetails(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BankDetails) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
