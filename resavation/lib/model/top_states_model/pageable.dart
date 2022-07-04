import 'dart:convert';

import 'package:collection/collection.dart';

import 'sort.dart';

class Pageable {
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  Sort? sort;
  bool? unpaged;

  Pageable({
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.sort,
    this.unpaged,
  });

  @override
  String toString() {
    return 'Pageable(offset: $offset, pageNumber: $pageNumber, pageSize: $pageSize, paged: $paged, sort: $sort, unpaged: $unpaged)';
  }

  factory Pageable.fromMap(Map<String, dynamic> data) => Pageable(
        offset: data['offset'] as int?,
        pageNumber: data['pageNumber'] as int?,
        pageSize: data['pageSize'] as int?,
        paged: data['paged'] as bool?,
        sort: data['sort'] == null
            ? null
            : Sort.fromMap(data['sort'] as Map<String, dynamic>),
        unpaged: data['unpaged'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'offset': offset,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
        'paged': paged,
        'sort': sort?.toMap(),
        'unpaged': unpaged,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pageable].
  factory Pageable.fromJson(String data) {
    return Pageable.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pageable] to a JSON string.
  String toJson() => json.encode(toMap());

  Pageable copyWith({
    int? offset,
    int? pageNumber,
    int? pageSize,
    bool? paged,
    Sort? sort,
    bool? unpaged,
  }) {
    return Pageable(
      offset: offset ?? this.offset,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      paged: paged ?? this.paged,
      sort: sort ?? this.sort,
      unpaged: unpaged ?? this.unpaged,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Pageable) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      offset.hashCode ^
      pageNumber.hashCode ^
      pageSize.hashCode ^
      paged.hashCode ^
      sort.hashCode ^
      unpaged.hashCode;
}
