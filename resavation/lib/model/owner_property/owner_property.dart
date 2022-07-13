import 'dart:convert';

import '../propety_model/property_model.dart';
import 'pageable.dart';
import 'sort.dart';

class OwnerPropertyModel {
  List<Property>? properties;
  Pageable? pageable;
  bool? last;
  int? totalElements;
  int? totalPages;
  bool? first;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? empty;

  OwnerPropertyModel({
    this.properties,
    this.pageable,
    this.last,
    this.totalElements,
    this.totalPages,
    this.first,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.empty,
  });

  factory OwnerPropertyModel.fromMap(Map<String, dynamic> data) =>
      OwnerPropertyModel(
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
        size: data['size'] as int?,
        number: data['number'] as int?,
        sort: data['sort'] == null
            ? null
            : Sort.fromMap(data['sort'] as Map<String, dynamic>),
        numberOfElements: data['numberOfElements'] as int?,
        empty: data['empty'] as bool?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OwnerPropertyModel].
  factory OwnerPropertyModel.fromJson(String data) {
    return OwnerPropertyModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }
}
