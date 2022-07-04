import 'dart:convert';

import 'sort.dart';

class Pageable {
  Sort? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable({
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.offset,
    this.paged,
    this.unpaged,
  });

  @override
  String toString() {
    return 'Pageable(sort: $sort, pageNumber: $pageNumber, pageSize: $pageSize, offset: $offset, paged: $paged, unpaged: $unpaged)';
  }

  factory Pageable.fromMap(Map<String, dynamic> data) => Pageable(
        sort: data['sort'] == null
            ? null
            : Sort.fromMap(data['sort'] as Map<String, dynamic>),
        pageNumber: data['pageNumber'] as int?,
        pageSize: data['pageSize'] as int?,
        offset: data['offset'] as int?,
        paged: data['paged'] as bool?,
        unpaged: data['unpaged'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'sort': sort?.toMap(),
        'pageNumber': pageNumber,
        'pageSize': pageSize,
        'offset': offset,
        'paged': paged,
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
    Sort? sort,
    int? pageNumber,
    int? pageSize,
    int? offset,
    bool? paged,
    bool? unpaged,
  }) {
    return Pageable(
      sort: sort ?? this.sort,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      offset: offset ?? this.offset,
      paged: paged ?? this.paged,
      unpaged: unpaged ?? this.unpaged,
    );
  }
}
