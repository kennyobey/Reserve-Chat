import 'dart:convert';

import '../propety_model/property_model.dart';
import 'pageable.dart';
import 'sort.dart';

class SearchModel {
  List<Property>? properties;
  Pageable? pageable;
  bool? last;
  int? totalElements;
  int? totalPages;
  Sort? sort;
  bool? first;
  int? number;
  int? numberOfElements;
  int? size;
  bool? empty;

  SearchModel({
    this.properties,
    this.pageable,
    this.last,
    this.totalElements,
    this.totalPages,
    this.sort,
    this.first,
    this.number,
    this.numberOfElements,
    this.size,
    this.empty,
  });

  @override
  String toString() {
    return 'SearchModel(content: $properties, pageable: $pageable, last: $last, totalElements: $totalElements, totalPages: $totalPages, sort: $sort, first: $first, number: $number, numberOfElements: $numberOfElements, size: $size, empty: $empty)';
  }

  factory SearchModel.fromMap(Map<String, dynamic> data) => SearchModel(
        properties: (data['content'] as List<dynamic>?)
            ?.map((e) => Property.fromMap(e as Map<String, dynamic>))
            .toList(),
        pageable: data['pageable'] == null
            ? null
            : Pageable.fromMap(data['pageable'] as Map<String, dynamic>),
        last: data['last'] as bool?,
        totalElements: data['totalElements'] as int?,
        totalPages: data['totalPages'] as int?,
        sort: data['sort'] == null
            ? null
            : Sort.fromMap(data['sort'] as Map<String, dynamic>),
        first: data['first'] as bool?,
        number: data['number'] as int?,
        numberOfElements: data['numberOfElements'] as int?,
        size: data['size'] as int?,
        empty: data['empty'] as bool?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SearchModel].
  factory SearchModel.fromJson(String data) {
    return SearchModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  SearchModel copyWith({
    List<Property>? content,
    Pageable? pageable,
    bool? last,
    int? totalElements,
    int? totalPages,
    Sort? sort,
    bool? first,
    int? number,
    int? numberOfElements,
    int? size,
    bool? empty,
  }) {
    return SearchModel(
      properties: content ?? this.properties,
      pageable: pageable ?? this.pageable,
      last: last ?? this.last,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      sort: sort ?? this.sort,
      first: first ?? this.first,
      number: number ?? this.number,
      numberOfElements: numberOfElements ?? this.numberOfElements,
      size: size ?? this.size,
      empty: empty ?? this.empty,
    );
  }
}
