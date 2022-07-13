import 'package:resavation/model/saved_property/saved_property.dart';

class UploadService {
  ///stage 1 data
  String? propertyStatus;
  String? propertyCategory;
  String? commercialPropertyType;
  String? retailPropertyType;
  String? industrialPropertyType;
  String? residentialPropertyType;

  String? spaceType;
  bool? isSpaceServiced;
  bool? isSpaceFurnished;
  String? propertyStyle;
  bool? liveInSpace;
  int noOfBedroom = 0;
  int noOfBathroom = 0;
  int numberOfCarSLot = 0;

  ///stage 2 data
  String? propertyName;
  String? propertyDescription;
  String? state;
  String? city;
  String? address;
  double? surfaceArea;

  //add stage 3 data here
  List<dynamic>? selectedImages;

  //Stage 4 data
  int? spacePrice;
  int? annualPrice;
  int? biannualPrice;
  int? monthlyPrice;
  int? quarterlyPrice;
  DateTime? startDate;
  DateTime? endDate;
  //Stage 5 data
  List<String> amenities = [];

  List<String> rules = [];

  bool verifyStage1() {
    return (propertyStatus != null) &&
        (propertyCategory != null) &&
        (commercialPropertyType != null ||
            retailPropertyType != null ||
            industrialPropertyType != null ||
            residentialPropertyType != null) &&
        (spaceType != null) &&
        (isSpaceServiced != null) &&
        (isSpaceFurnished != null) &&
        (propertyStyle != null) &&
        (liveInSpace != null);
  }

  clearStage1() {
    propertyStatus = null;
    propertyCategory = null;
    commercialPropertyType = null;
    retailPropertyType = null;
    industrialPropertyType = null;
    residentialPropertyType = null;
    spaceType = null;
    isSpaceFurnished = null;
    isSpaceServiced = null;
    propertyStyle = null;
    liveInSpace = null;
    noOfBathroom = 0;
    noOfBedroom = 0;
    numberOfCarSLot = 0;

    clearStage2();
  }

  setUpStage1(SavedProperty savedProperty) {
    final propertyCategories = [
      "Residential",
      "Commercial",
      "Industrial",
      "Retail",
    ];
    propertyStatus = savedProperty.propertyStatus;
    propertyCategory = savedProperty.propertyCategory;

    spaceType = savedProperty.roomType;

    if (propertyCategory == propertyCategories[0]) {
      residentialPropertyType = savedProperty.propertyType;
    } else if (propertyCategory == propertyCategories[1]) {
      commercialPropertyType = savedProperty.propertyType;
    } else if (propertyCategory == propertyCategories[2]) {
      industrialPropertyType = savedProperty.propertyType;
    } else if (propertyCategory == propertyCategories[3]) {
      retailPropertyType = savedProperty.propertyType;
    }

    isSpaceFurnished = savedProperty.isSpaceFurnished == null
        ? null
        : savedProperty.isSpaceFurnished == 'YES'
            ? true
            : false;
    isSpaceServiced = savedProperty.isSpaceServiced == null
        ? null
        : savedProperty.isSpaceServiced == 'YES'
            ? true
            : false;

    liveInSpace = savedProperty.isLiveInSPace == null
        ? null
        : savedProperty.isLiveInSPace == 'YES'
            ? true
            : false;

    propertyStyle = savedProperty.propertyStyle;
    noOfBathroom = savedProperty.bathTubCount ?? 0;
    noOfBedroom = savedProperty.bedroomCount ?? 0;
    numberOfCarSLot = savedProperty.carSlot ?? 0;
  }

  clearStage2() {
    propertyName = null;
    propertyDescription = null;

    state = null;
    city = null;
    address = null;
    clearStage3();
  }

  setUpStage2(SavedProperty savedProperty) {
    propertyName = savedProperty.propertyName;
    propertyDescription = savedProperty.description;
    surfaceArea = savedProperty.surfaceArea;
    state = savedProperty.state;
    city = savedProperty.city;
    address = savedProperty.address;
  }

  clearStage3() {
    selectedImages = null;
    clearStage4();
  }

  setUpStage3(SavedProperty savedProperty) {
    selectedImages = (savedProperty.propertyImages ?? [])
        .map((e) => e.imageUrl ?? '')
        .toList();
  }

  clearStage4() {
    spacePrice = null;
    annualPrice = null;
    biannualPrice = null;
    monthlyPrice = null;
    quarterlyPrice = null;
    startDate = null;
    endDate = null;
    clearStage5();
  }

  setUpStage4(SavedProperty savedProperty) {
    spacePrice = savedProperty.spacePrice?.toInt();
    annualPrice = savedProperty.subscription?.annualPrice?.toInt();
    biannualPrice = savedProperty.subscription?.biannualPrice?.toInt();
    monthlyPrice = savedProperty.subscription?.monthlyPrice?.toInt();
    quarterlyPrice = savedProperty.subscription?.quarterlyPrice?.toInt();
    startDate = savedProperty.availabilityPeriods?.startDate;
    endDate = savedProperty.availabilityPeriods?.endDate;
  }

  clearStage5() {
    amenities = [];
    rules = [];
  }

  setUpStage5(SavedProperty savedProperty) {
    amenities =
        (savedProperty.amenities ?? []).map((e) => e.amenity ?? '').toList();
    rules =
        (savedProperty.propertyRule ?? []).map((e) => e.rule ?? '').toList();
  }

  bool isRestoringData = false;

  void setUpData(SavedProperty savedProperty) {
    setUpStage1(savedProperty);
    setUpStage2(savedProperty);
    setUpStage3(savedProperty);
    setUpStage4(savedProperty);
    setUpStage5(savedProperty);
  }
}
