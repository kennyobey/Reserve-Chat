import 'dart:convert';

import 'package:collection/collection.dart';

import 'content.dart';
import 'pageable.dart';
import 'sort.dart';

class TopCategoriesModel {
  List<TopCategoriesContent>? content;
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

  TopCategoriesModel({
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
    return 'TopCategoriesModel(content: $content, empty: $empty, first: $first, last: $last, number: $number, numberOfElements: $numberOfElements, pageable: $pageable, size: $size, sort: $sort, totalElements: $totalElements, totalPages: $totalPages)';
  }

  factory TopCategoriesModel.fromMap(Map<String, dynamic> data) {
    return TopCategoriesModel(
      content: (data['content'] as List<dynamic>?)
          ?.map((e) => TopCategoriesContent.fromMap(e as Map<String, dynamic>))
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

  Map<String, dynamic> toMap() => {
        'content': content?.map((e) => e.toMap()).toList(),
        'empty': empty,
        'first': first,
        'last': last,
        'number': number,
        'numberOfElements': numberOfElements,
        'pageable': pageable?.toMap(),
        'size': size,
        'sort': sort?.toMap(),
        'totalElements': totalElements,
        'totalPages': totalPages,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TopCategoriesModel].
  factory TopCategoriesModel.fromJson(String data) {
    return TopCategoriesModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopCategoriesModel] to a JSON string.
  String toJson() => json.encode(toMap());

  TopCategoriesModel copyWith({
    List<TopCategoriesContent>? content,
    bool? empty,
    bool? first,
    bool? last,
    int? number,
    int? numberOfElements,
    Pageable? pageable,
    int? size,
    Sort? sort,
    int? totalElements,
    int? totalPages,
  }) {
    return TopCategoriesModel(
      content: content ?? this.content,
      empty: empty ?? this.empty,
      first: first ?? this.first,
      last: last ?? this.last,
      number: number ?? this.number,
      numberOfElements: numberOfElements ?? this.numberOfElements,
      pageable: pageable ?? this.pageable,
      size: size ?? this.size,
      sort: sort ?? this.sort,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TopCategoriesModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      content.hashCode ^
      empty.hashCode ^
      first.hashCode ^
      last.hashCode ^
      number.hashCode ^
      numberOfElements.hashCode ^
      pageable.hashCode ^
      size.hashCode ^
      sort.hashCode ^
      totalElements.hashCode ^
      totalPages.hashCode;
}
