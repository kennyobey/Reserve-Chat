import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) =>
    EditProfileModel.fromJson(str);

String editProfileModelToJson(EditProfileModel data) =>
    json.encode(data.toJson());

class EditProfileModel {
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  String? phoneNumber;
  String? gender;
  DateTime? dateOfBirth;
  String? country;
  String? state;
  String? city;
  String? address;
  String? postalCode;
  String? aboutMe;
  String? occupation;

  EditProfileModel({
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.country,
    this.state,
    this.city,
    this.address,
    this.postalCode,
    this.aboutMe,
    this.occupation,
  });

  @override
  String toString() {
    return 'EditProfileModel(firstName: $firstName, lastName: $lastName, email: $email, imageUrl: $imageUrl, phoneNumber: $phoneNumber, gender: $gender, dateOfBirth: $dateOfBirth, country: $country, state: $state, city: $city, address: $address, postalCode: $postalCode, aboutMe: $aboutMe, occupation: $occupation)';
  }

  factory EditProfileModel.fromMap(Map<String, dynamic> data) {
    return EditProfileModel(
      firstName: data['firstName'] as String?,
      lastName: data['lastName'] as String?,
      email: data['email'] as String?,
      imageUrl: data['imageUrl'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      gender: data['gender'] as String?,
      dateOfBirth: data['dateOfBirth'] == null
          ? null
          : DateTime.parse(data['dateOfBirth'] as String),
      country: data['country'] as String?,
      state: data['state'] as String?,
      city: data['city'] as String?,
      address: data['address'] as String?,
      postalCode: data['postalCode'] as String?,
      aboutMe: data['aboutMe'] as String?,
      occupation: data['occupation'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'imageUrl': imageUrl,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'country': country,
        'state': state,
        'city': city,
        'address': address,
        'postalCode': postalCode,
        'aboutMe': aboutMe,
        'occupation': occupation,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EditProfileModel].
  factory EditProfileModel.fromJson(String data) {
    return EditProfileModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EditProfileModel] to a JSON string.
  String toJson() => json.encode(toMap());

  EditProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    String? gender,
    DateTime? dateOfBirth,
    String? country,
    String? state,
    String? city,
    String? address,
    String? postalCode,
    String? aboutMe,
    String? occupation,
  }) {
    return EditProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      aboutMe: aboutMe ?? this.aboutMe,
      occupation: occupation ?? this.occupation,
    );
  }
}
