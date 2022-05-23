import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:resavation/model/property_model.dart';

import 'pageable.dart';
import 'sort.dart';

class PropertySearch {
  List<Property>? properties;
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

  PropertySearch({
    this.properties,
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

  @override
  String toString() {
    return 'PropertySearch(content: $properties, pageable: $pageable, last: $last, totalElements: $totalElements, totalPages: $totalPages, first: $first, sort: $sort, number: $number, numberOfElements: $numberOfElements, size: $size, empty: $empty)';
  }

  factory PropertySearch.fromMap(Map<String, dynamic> data) {
    return PropertySearch(
      properties: (data['content'] as List<dynamic>?)
          ?.map((e) => Property.fromMap(e as Map<String, dynamic>))
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

  Map<String, dynamic> toMap() => {
        'content': properties?.map((e) => e.toMap()).toList(),
        'pageable': pageable?.toMap(),
        'last': last,
        'totalElements': totalElements,
        'totalPages': totalPages,
        'first': first,
        'sort': sort?.toMap(),
        'number': number,
        'numberOfElements': numberOfElements,
        'size': size,
        'empty': empty,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PropertySearch].
  factory PropertySearch.fromJson(String data) {
    return PropertySearch.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PropertySearch] to a JSON string.
  String toJson() => json.encode(toMap());

  PropertySearch copyWith({
    List<Property>? properties,
    Pageable? pageable,
    bool? last,
    int? totalElements,
    int? totalPages,
    bool? first,
    Sort? sort,
    int? number,
    int? numberOfElements,
    int? size,
    bool? empty,
  }) {
    return PropertySearch(
      properties: properties ?? this.properties,
      pageable: pageable ?? this.pageable,
      last: last ?? this.last,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      first: first ?? this.first,
      sort: sort ?? this.sort,
      number: number ?? this.number,
      numberOfElements: numberOfElements ?? this.numberOfElements,
      size: size ?? this.size,
      empty: empty ?? this.empty,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PropertySearch) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      properties.hashCode ^
      pageable.hashCode ^
      last.hashCode ^
      totalElements.hashCode ^
      totalPages.hashCode ^
      first.hashCode ^
      sort.hashCode ^
      number.hashCode ^
      numberOfElements.hashCode ^
      size.hashCode ^
      empty.hashCode;
}
