import 'dart:convert';

import 'package:collection/collection.dart';

class Sort {
	bool? sorted;
	bool? unsorted;
	bool? empty;

	Sort({this.sorted, this.unsorted, this.empty});

	@override
	String toString() {
		return 'Sort(sorted: $sorted, unsorted: $unsorted, empty: $empty)';
	}

	factory Sort.fromMap(Map<String, dynamic> data) => Sort(
				sorted: data['sorted'] as bool?,
				unsorted: data['unsorted'] as bool?,
				empty: data['empty'] as bool?,
			);

	Map<String, dynamic> toMap() => {
				'sorted': sorted,
				'unsorted': unsorted,
				'empty': empty,
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

	Sort copyWith({
		bool? sorted,
		bool? unsorted,
		bool? empty,
	}) {
		return Sort(
			sorted: sorted ?? this.sorted,
			unsorted: unsorted ?? this.unsorted,
			empty: empty ?? this.empty,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Sort) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => sorted.hashCode ^ unsorted.hashCode ^ empty.hashCode;
}
