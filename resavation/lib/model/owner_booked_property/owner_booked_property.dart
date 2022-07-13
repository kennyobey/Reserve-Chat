import 'dart:convert';

import 'content.dart';
import 'package:resavation/model/search_model/sort.dart';

import '../top_categories_model/pageable.dart';

class OwnerBookedProperty {
  List<OwnerBookedPropertyContent>? content;
  Pageable? pageable;
  bool? last;
  int? totalElements;
  int? totalPages;
  bool? first;
  Sort? sort;
  int? number;
  int? numberOfElements;
  int? size;
  bool? empty;

  OwnerBookedProperty({
    this.content,
    this.pageable,
    this.last,
    this.totalElements,
    this.totalPages,
    this.first,
    this.sort,
    this.number,
    this.numberOfElements,
    this.size,
    this.empty,
  });

  factory OwnerBookedProperty.fromMap(Map<String, dynamic> data) {
    return OwnerBookedProperty(
      content: (data['content'] as List<dynamic>?)
          ?.map((e) =>
              OwnerBookedPropertyContent.fromMap(e as Map<String, dynamic>))
          .toList(),
      pageable: data['pageable'] == null
          ? null
          : Pageable.fromMap(data['pageable'] as Map<String, dynamic>),
      last: data['last'] as bool?,
      totalElements: data['totalElements'] as int?,
      totalPages: data['totalPages'] as int?,
      first: data['first'] as bool?,
      sort: data['sort'] == null
          ? null
          : Sort.fromMap(data['sort'] as Map<String, dynamic>),
      number: data['number'] as int?,
      numberOfElements: data['numberOfElements'] as int?,
      size: data['size'] as int?,
      empty: data['empty'] as bool?,
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OwnerBookedProperty].
  factory OwnerBookedProperty.fromJson(String data) {
    return OwnerBookedProperty.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }
}
