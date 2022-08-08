import 'dart:convert';

class Sort {
  bool? sorted;
  bool? empty;
  bool? unsorted;

  Sort({this.sorted, this.empty, this.unsorted});

  factory Sort.fromMap(Map<String, dynamic> data) => Sort(
        sorted: data['sorted'] as bool?,
        empty: data['empty'] as bool?,
        unsorted: data['unsorted'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'sorted': sorted,
        'empty': empty,
        'unsorted': unsorted,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Sort].
  factory Sort.fromJson(String data) {
    return Sort.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Sort] to a JSON string.
  String toJson() => json.encode(toMap());
}
