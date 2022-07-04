// To parse this JSON data, do
//
//     final bookedProperty = bookedPropertyFromJson(jsonString);

import 'dart:convert';

BookedProperty bookedPropertyFromJson(String str) =>
    BookedProperty.fromJson(json.decode(str));

String bookedPropertyToJson(BookedProperty data) => json.encode(data.toJson());

class BookedProperty {
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

  List<Content>? content;
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

  factory BookedProperty.fromJson(Map<String, dynamic> json) => BookedProperty(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        empty: json["empty"],
        first: json["first"],
        last: json["last"],
        number: json["number"],
        numberOfElements: json["numberOfElements"],
        pageable: Pageable.fromJson(json["pageable"]),
        size: json["size"],
        sort: Sort.fromJson(json["sort"]),
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
        "empty": empty,
        "first": first,
        "last": last,
        "number": number,
        "numberOfElements": numberOfElements,
        "pageable": pageable!.toJson(),
        "size": size,
        "sort": sort!.toJson(),
        "totalElements": totalElements,
        "totalPages": totalPages,
      };
}

class Content {
  Content({
    this.amount,
    this.checkInDate,
    this.createdAt,
    this.id,
    this.paymentType,
    this.property,
    this.propertyOwner,
    this.status,
    this.subCategories,
    this.updatedAt,
    this.user,
  });

  int? amount;
  String? checkInDate;
  DateTime? createdAt;
  int? id;
  String? paymentType;
  Property? property;
  PropertyOwner? propertyOwner;
  bool? status;
  String? subCategories;
  DateTime? updatedAt;
  PropertyOwner? user;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        amount: json["amount"],
        checkInDate: json["checkInDate"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        paymentType: json["paymentType"],
        property: Property.fromJson(json["property"]),
        propertyOwner: PropertyOwner.fromJson(json["propertyOwner"]),
        status: json["status"],
        subCategories: json["subCategories"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: PropertyOwner.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "checkInDate": checkInDate,
        "createdAt": createdAt!.toIso8601String(),
        "id": id,
        "paymentType": paymentType,
        "property": property!.toJson(),
        "propertyOwner": propertyOwner!.toJson(),
        "status": status,
        "subCategories": subCategories,
        "updatedAt": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
      };
}

class Property {
  Property({
    this.address,
    this.amenities,
    this.availabilityPeriods,
    this.bathTubCount,
    this.bedroomCount,
    this.carSlot,
    this.city,
    this.country,
    this.createdAt,
    this.description,
    this.favourite,
    this.id,
    this.isLiveInSPace,
    this.isSpaceFurnished,
    this.isSpaceServiced,
    this.paymentType,
    this.propertyCategory,
    this.propertyImages,
    this.propertyName,
    this.propertyRule,
    this.propertyStatus,
    this.propertyStyle,
    this.propertyType,
    this.serviceType,
    this.spacePrice,
    this.state,
    this.subscription,
    this.surfaceArea,
    this.updatedAt,
    this.user,
    this.verificationStatus,
  });

  String? address;
  List<Amenity>? amenities;
  AvailabilityPeriods? availabilityPeriods;
  int? bathTubCount;
  int? bedroomCount;
  int? carSlot;
  String? city;
  String? country;
  DateTime? createdAt;
  String? description;
  bool? favourite;
  int? id;
  String? isLiveInSPace;
  String? isSpaceFurnished;
  String? isSpaceServiced;
  String? paymentType;
  String? propertyCategory;
  List<Amenity>? propertyImages;
  String? propertyName;
  List<Amenity>? propertyRule;
  String? propertyStatus;
  String? propertyStyle;
  String? propertyType;
  String? serviceType;
  int? spacePrice;
  String? state;
  Subscription? subscription;
  int? surfaceArea;
  DateTime? updatedAt;
  PropertyOwner? user;
  String? verificationStatus;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        address: json["address"],
        amenities: List<Amenity>.from(
            json["amenities"].map((x) => Amenity.fromJson(x))),
        availabilityPeriods:
            AvailabilityPeriods.fromJson(json["availabilityPeriods"]),
        bathTubCount: json["bathTubCount"],
        bedroomCount: json["bedroomCount"],
        carSlot: json["carSlot"],
        city: json["city"],
        country: json["country"],
        createdAt: DateTime.parse(json["createdAt"]),
        description: json["description"],
        favourite: json["favourite"],
        id: json["id"],
        isLiveInSPace: json["isLiveInSPace"],
        isSpaceFurnished: json["isSpaceFurnished"],
        isSpaceServiced: json["isSpaceServiced"],
        paymentType: json["paymentType"],
        propertyCategory: json["propertyCategory"],
        propertyImages: List<Amenity>.from(
            json["propertyImages"].map((x) => Amenity.fromJson(x))),
        propertyName: json["propertyName"],
        propertyRule: List<Amenity>.from(
            json["propertyRule"].map((x) => Amenity.fromJson(x))),
        propertyStatus: json["propertyStatus"],
        propertyStyle: json["propertyStyle"],
        propertyType: json["propertyType"],
        serviceType: json["serviceType"],
        spacePrice: json["spacePrice"],
        state: json["state"],
        subscription: Subscription.fromJson(json["subscription"]),
        surfaceArea: json["surfaceArea"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: PropertyOwner.fromJson(json["user"]),
        verificationStatus: json["verificationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "amenities": List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "availabilityPeriods": availabilityPeriods!.toJson(),
        "bathTubCount": bathTubCount,
        "bedroomCount": bedroomCount,
        "carSlot": carSlot,
        "city": city,
        "country": country,
        "createdAt": createdAt!.toIso8601String(),
        "description": description,
        "favourite": favourite,
        "id": id,
        "isLiveInSPace": isLiveInSPace,
        "isSpaceFurnished": isSpaceFurnished,
        "isSpaceServiced": isSpaceServiced,
        "paymentType": paymentType,
        "propertyCategory": propertyCategory,
        "propertyImages":
            List<dynamic>.from(propertyImages!.map((x) => x.toJson())),
        "propertyName": propertyName,
        "propertyRule":
            List<dynamic>.from(propertyRule!.map((x) => x.toJson())),
        "propertyStatus": propertyStatus,
        "propertyStyle": propertyStyle,
        "propertyType": propertyType,
        "serviceType": serviceType,
        "spacePrice": spacePrice,
        "state": state,
        "subscription": subscription!.toJson(),
        "surfaceArea": surfaceArea,
        "updatedAt": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
        "verificationStatus": verificationStatus,
      };
}

class Amenity {
  Amenity({
    this.amenity,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.imageUrl,
    this.rule,
  });

  String? amenity;
  DateTime? createdAt;
  int? id;
  DateTime? updatedAt;
  String? imageUrl;
  String? rule;

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        amenity: json["amenity"] == null ? null : json["amenity"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        rule: json["rule"] == null ? null : json["rule"],
      );

  Map<String, dynamic> toJson() => {
        "amenity": amenity == null ? null : amenity,
        "createdAt": createdAt!.toIso8601String(),
        "id": id,
        "updatedAt": updatedAt!.toIso8601String(),
        "imageUrl": imageUrl == null ? null : imageUrl,
        "rule": rule == null ? null : rule,
      };
}

class AvailabilityPeriods {
  AvailabilityPeriods({
    this.createdAt,
    this.endDate,
    this.id,
    this.startDate,
    this.updatedAt,
  });

  DateTime? createdAt;
  String? endDate;
  int? id;
  String? startDate;
  DateTime? updatedAt;

  factory AvailabilityPeriods.fromJson(Map<String, dynamic> json) =>
      AvailabilityPeriods(
        createdAt: DateTime.parse(json["createdAt"]),
        endDate: json["endDate"],
        id: json["id"],
        startDate: json["startDate"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt!.toIso8601String(),
        "endDate": endDate,
        "id": id,
        "startDate": startDate,
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Subscription {
  Subscription({
    this.annualPrice,
    this.biannualPrice,
    this.createdAt,
    this.id,
    this.monthlyPrice,
    this.quarterlyPrice,
    this.updatedAt,
  });

  int? annualPrice;
  int? biannualPrice;
  DateTime? createdAt;
  int? id;
  int? monthlyPrice;
  int? quarterlyPrice;
  DateTime? updatedAt;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        annualPrice: json["annualPrice"],
        biannualPrice: json["biannualPrice"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        monthlyPrice: json["monthlyPrice"],
        quarterlyPrice: json["quarterlyPrice"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "annualPrice": annualPrice,
        "biannualPrice": biannualPrice,
        "createdAt": createdAt!.toIso8601String(),
        "id": id,
        "monthlyPrice": monthlyPrice,
        "quarterlyPrice": quarterlyPrice,
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class PropertyOwner {
  PropertyOwner({
    this.createdAt,
    this.email,
    this.favourites,
    this.firstName,
    this.id,
    this.imageUrl,
    this.lastName,
    this.notification,
    this.updatedAt,
  });

  DateTime? createdAt;
  String? email;
  List<Amenity>? favourites;
  String? firstName;
  int? id;
  String? imageUrl;
  String? lastName;
  String? notification;
  DateTime? updatedAt;

  factory PropertyOwner.fromJson(Map<String, dynamic> json) => PropertyOwner(
        createdAt: DateTime.parse(json["createdAt"]),
        email: json["email"],
        favourites: List<Amenity>.from(
            json["favourites"].map((x) => Amenity.fromJson(x))),
        firstName: json["firstName"],
        id: json["id"],
        imageUrl: json["imageUrl"],
        lastName: json["lastName"],
        notification: json["notification"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt!.toIso8601String(),
        "email": email,
        "favourites": List<dynamic>.from(favourites!.map((x) => x.toJson())),
        "firstName": firstName,
        "id": id,
        "imageUrl": imageUrl,
        "lastName": lastName,
        "notification": notification,
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Pageable {
  Pageable({
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.sort,
    this.unpaged,
  });

  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  Sort? sort;
  bool? unpaged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        paged: json["paged"],
        sort: Sort.fromJson(json["sort"]),
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "paged": paged,
        "sort": sort!.toJson(),
        "unpaged": unpaged,
      };
}

class Sort {
  Sort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  bool? empty;
  bool? sorted;
  bool? unsorted;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
      );

  Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
      };
}
