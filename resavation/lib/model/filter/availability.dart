import 'dart:convert';

class Availability {
  bool? moreThanOneYear;
  bool? shortLet;
  bool? withinOneYear;
  bool? withinSixMonth;

  Availability({
    this.moreThanOneYear,
    this.shortLet,
    this.withinOneYear,
    this.withinSixMonth,
  });

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
}
