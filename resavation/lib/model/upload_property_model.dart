import 'dart:convert';

UploadProperty uploadPropertyFromJson(String str) =>
    UploadProperty.fromJson(json.decode(str));

String uploadPropertyToJson(UploadProperty data) => json.encode(data.toJson());

class UploadProperty {
  UploadProperty({
    required this.message,
  });

  String message;

  factory UploadProperty.fromJson(Map<String, dynamic> json) => UploadProperty(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}

// To parse this JSON data, do
//
//     final propertyUpload = propertyUploadFromJson(jsonString);

PropertyUpload propertyUploadFromJson(String str) =>
    PropertyUpload.fromJson(json.decode(str));

String propertyUploadToJson(PropertyUpload data) => json.encode(data.toJson());

class PropertyUpload {
  PropertyUpload({
    required this.propertyDetails,
    required this.userDetails,
  });

  PropertyDetails propertyDetails;
  UserDetails userDetails;

  factory PropertyUpload.fromJson(Map<String, dynamic> json) => PropertyUpload(
        propertyDetails: PropertyDetails.fromJson(json["propertyDetails"]),
        userDetails: UserDetails.fromJson(json["userDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "propertyDetails": propertyDetails.toJson(),
        "userDetails": userDetails.toJson(),
      };
}

class PropertyDetails {
  PropertyDetails({
    required this.address,
    required this.amenities,
    required this.availability,
    required this.bathTubCount,
    required this.bedroomCount,
    required this.carSlots,
    required this.city,
    required this.country,
    required this.description,
    required this.imageUrl,
    required this.listingOptions,
    required this.liveInSPace,
    required this.propertyName,
    required this.propertyStatus,
    required this.propertyStyle,
    required this.propertyType,
    required this.roomType,
    required this.rules,
    required this.spaceFurnished,
    required this.spacePrice,
    required this.spaceServiced,
    required this.state,
    required this.subscription,
    required this.surfaceArea,
  });

  String address;
  List<String> amenities;
  Availability availability;
  int bathTubCount;
  int bedroomCount;
  int carSlots;
  String city;
  String country;
  String description;
  String imageUrl;
  List<String> listingOptions;
  bool liveInSPace;
  String propertyName;
  String propertyStatus;
  String propertyStyle;
  String propertyType;
  String roomType;
  List<String> rules;
  bool spaceFurnished;
  int spacePrice;
  bool spaceServiced;
  String state;
  Subscription subscription;
  double surfaceArea;

  factory PropertyDetails.fromJson(Map<String, dynamic> json) =>
      PropertyDetails(
        address: json["address"],
        amenities: List<String>.from(json["amenities"].map((x) => x)),
        availability: Availability.fromJson(json["availability"]),
        bathTubCount: json["bathTubCount"],
        bedroomCount: json["bedroomCount"],
        carSlots: json["carSlots"],
        city: json["city"],
        country: json["country"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        listingOptions: List<String>.from(json["listingOptions"].map((x) => x)),
        liveInSPace: json["liveInSPace"],
        propertyName: json["propertyName"],
        propertyStatus: json["propertyStatus"],
        propertyStyle: json["propertyStyle"],
        propertyType: json["propertyType"],
        roomType: json["roomType"],
        rules: List<String>.from(json["rules"].map((x) => x)),
        spaceFurnished: json["spaceFurnished"],
        spacePrice: json["spacePrice"],
        spaceServiced: json["spaceServiced"],
        state: json["state"],
        subscription: Subscription.fromJson(json["subscription"]),
        surfaceArea: json["surfaceArea"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "availability": availability.toJson(),
        "bathTubCount": bathTubCount,
        "bedroomCount": bedroomCount,
        "carSlots": carSlots,
        "city": city,
        "country": country,
        "description": description,
        "imageUrl": imageUrl,
        "listingOptions": List<dynamic>.from(listingOptions.map((x) => x)),
        "liveInSPace": liveInSPace,
        "propertyName": propertyName,
        "propertyStatus": propertyStatus,
        "propertyStyle": propertyStyle,
        "propertyType": propertyType,
        "roomType": roomType,
        "rules": List<dynamic>.from(rules.map((x) => x)),
        "spaceFurnished": spaceFurnished,
        "spacePrice": spacePrice,
        "spaceServiced": spaceServiced,
        "state": state,
        "subscription": subscription.toJson(),
        "surfaceArea": surfaceArea,
      };
}

class Availability {
  Availability({
    required this.from,
    required this.to,
  });

  String from;
  String to;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
      };
}

class Subscription {
  Subscription({
    required this.annualPrice,
    required this.biannualPrice,
    required this.monthlyPrice,
    required this.quarterlyPrice,
  });

  int annualPrice;
  int biannualPrice;
  int monthlyPrice;
  int quarterlyPrice;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        annualPrice: json["annualPrice"],
        biannualPrice: json["biannualPrice"],
        monthlyPrice: json["monthlyPrice"],
        quarterlyPrice: json["quarterlyPrice"],
      );

  Map<String, dynamic> toJson() => {
        "annualPrice": annualPrice,
        "biannualPrice": biannualPrice,
        "monthlyPrice": monthlyPrice,
        "quarterlyPrice": quarterlyPrice,
      };
}

class UserDetails {
  UserDetails({
    required this.address,
    required this.city,
    required this.country,
    required this.dateOfBirth,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.phoneNumber,
    required this.state,
  });

  String address;
  String city;
  String country;
  String dateOfBirth;
  String firstName;
  String gender;
  String lastName;
  String phoneNumber;
  String state;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        address: json["address"],
        city: json["city"],
        country: json["country"],
        dateOfBirth: json["dateOfBirth"],
        firstName: json["firstName"],
        gender: json["gender"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "country": country,
        "dateOfBirth": dateOfBirth,
        "firstName": firstName,
        "gender": gender,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "state": state,
      };
}
