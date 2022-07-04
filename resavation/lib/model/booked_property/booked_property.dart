import 'dart:convert';

import 'package:resavation/model/search_model/sort.dart';

import '../top_categories_model/pageable.dart';
import 'content.dart';

class BookedProperty {
  List<BookedPropertyContent>? content;
  bool? empty;
  bool? first;
  bool? last;
  int? number;
  int? numberOfElements;
  Pageable? pageable;
  int? size;
  Sort? sort;
  int? totalElements;
  int? totalPages;

  BookedProperty({
    this.content,
    this.empty,
    this.first,
    this.last,
    this.number,
    this.numberOfElements,
    this.pageable,
    this.size,
    this.sort,
    this.totalElements,
    this.totalPages,
  });

  @override
  String toString() {
    return 'BookedProperty(content: $content, empty: $empty, first: $first, last: $last, number: $number, numberOfElements: $numberOfElements, pageable: $pageable, size: $size, sort: $sort, totalElements: $totalElements, totalPages: $totalPages)';
  }

  factory BookedProperty.fromMap(Map<String, dynamic> data) {
    return BookedProperty(
      content: (data['content'] as List<dynamic>?)
          ?.map((e) => BookedPropertyContent.fromMap(e as Map<String, dynamic>))
          .toList(),
      empty: data['empty'] as bool?,
      first: data['first'] as bool?,
      last: data['last'] as bool?,
      number: data['number'] as int?,
      numberOfElements: data['numberOfElements'] as int?,
      pageable: data['pageable'] == null
          ? null
          : Pageable.fromMap(data['pageable'] as Map<String, dynamic>),
      size: data['size'] as int?,
      sort: data['sort'] == null
          ? null
          : Sort.fromMap(data['sort'] as Map<String, dynamic>),
      totalElements: data['totalElements'] as int?,
      totalPages: data['totalPages'] as int?,
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookedProperty].
  factory BookedProperty.fromJson(String data) {
    return BookedProperty.fromMap(json.decode(data) as Map<String, dynamic>);
  }
}
