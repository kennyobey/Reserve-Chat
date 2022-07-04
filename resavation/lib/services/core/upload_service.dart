import 'package:image_picker/image_picker.dart';

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
  List<XFile>? selectedImages;

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

  clearStage2() {
    propertyName = null;
    propertyDescription = null;

    state = null;
    city = null;
    address = null;
    clearStage3();
  }

  clearStage3() {
    selectedImages = null;
    clearStage4();
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

  clearStage5() {
    amenities = [];
    rules = [];
  }

  bool isRestoringData = false;
}
