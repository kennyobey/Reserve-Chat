import 'dart:convert';

import 'package:collection/collection.dart';

 
class Availability {
	final bool? moreThanOneYear;
	final bool? shortLet;
	final bool? withinOneYear;
	final bool? withinSixMonth;

	const Availability({
		this.moreThanOneYear, 
		this.shortLet, 
		this.withinOneYear, 
		this.withinSixMonth, 
	});

	@override
	String toString() {
		return 'Availability(moreThanOneYear: $moreThanOneYear, shortLet: $shortLet, withinOneYear: $withinOneYear, withinSixMonth: $withinSixMonth)';
	}

	factory Availability.fromMap(Map<String, dynamic> data) => Availability(
				moreThanOneYear: data['moreThanOneYear'] as bool?,
				shortLet: data['shortLet'] as bool?,
				withinOneYear: data['withinOneYear'] as bool?,
				withinSixMonth: data['withinSixMonth'] as bool?,
			);

	Map<String, dynamic> toMap() => {
				'moreThanOneYear': moreThanOneYear,
				'shortLet': shortLet,
				'withinOneYear': withinOneYear,
				'withinSixMonth': withinSixMonth,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Availability].
	factory Availability.fromJson(String data) {
		return Availability.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Availability] to a JSON string.
	String toJson() => json.encode(toMap());

	Availability copyWith({
		bool? moreThanOneYear,
		bool? shortLet,
		bool? withinOneYear,
		bool? withinSixMonth,
	}) {
		return Availability(
			moreThanOneYear: moreThanOneYear ?? this.moreThanOneYear,
			shortLet: shortLet ?? this.shortLet,
			withinOneYear: withinOneYear ?? this.withinOneYear,
			withinSixMonth: withinSixMonth ?? this.withinSixMonth,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Availability) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			moreThanOneYear.hashCode ^
			shortLet.hashCode ^
			withinOneYear.hashCode ^
			withinSixMonth.hashCode;
}
