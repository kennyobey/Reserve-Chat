import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/upload_property_model.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/core/http_service.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class PropertyOwnerPaymentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  final PropertyOwnerUploadModel propertyOwnerUploadModel =
      PropertyOwnerUploadModel();

  bool hasWifi = false;

  get selectedAnimals => "Subscription";

  void onHasWifiChange(bool? value) {
    hasWifi = value!;
    notifyListeners();
  }

  final TextEditingController propertySubscriptionController =
      TextEditingController();
  final TextEditingController propertyannualPriceController =
      TextEditingController();
  final TextEditingController propertybiannualPriceController =
      TextEditingController();
  final TextEditingController propertymonthlyPriceController =
      TextEditingController();
  final TextEditingController propertyquaterlylPriceController =
      TextEditingController();

  void upoloadPropertyToServer() async {
    var annualPrice = propertyannualPriceController.text;
    final String biannualPrice = propertybiannualPriceController.text;
    final String monthlylPrice = propertymonthlyPriceController.text;
    final String quaterlylPrice = propertyquaterlylPriceController.text;

    httpService.uploadProperty(subscription: {
      annualPrice: 0,
      biannualPrice: 0,
      quaterlylPrice: 0,
      monthlylPrice: 0
    });
  }

  void incrementPrice({required String input}) {
    propertyquaterlylPriceController.text = (int.parse(input) * 4).toString();
    propertybiannualPriceController.text = (int.parse(input) * 6).toString();
    propertyannualPriceController.text = (int.parse(input) * 12).toString();
    notifyListeners();
  }

// drop-down button UI logic for spaceType
  String? selectedValue1;
  List<Object>? subscriptionType = [
    'Monthly',
    'Quarterly',
    'Biannually',
    'Annually'
  ];
  bool _hasHairDryer = false;
  bool get hasHairDryer => _hasHairDryer;

  void onCheckChanged5(bool? value) {
    _hasHairDryer = value ?? false;
    notifyListeners();
  }

  String isServiced = "";

  Future<void> selecStarttDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      print("The picked date for date 1 is $selectedDate");
      propertyOwnerUploadModel.from = selectedDate as String?;
      notifyListeners();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate2) {
      selectedDate2 = picked;
      print("The picked date for date 2 is $selectedDate2");
      propertyOwnerUploadModel.from = selectedDate2 as String?;
      notifyListeners();
    }
  }

  void onSelectedValueChange1(value) {
    selectedValue1 = value as String;

    notifyListeners();
  }

  void goToPropertyOwnerAmenitiesView() {
    propertyOwnerUploadModel.annualPrice =
        propertyannualPriceController.text as int?;
    propertyOwnerUploadModel.biannualPrice =
        propertybiannualPriceController.text as int?;
    propertyOwnerUploadModel.quarterlyPrice =
        propertyquaterlylPriceController.text as int?;
    propertyOwnerUploadModel.monthlyPrice =
        propertymonthlyPriceController.text as int?;

    _navigationService.navigateTo(Routes.propertyOwnerAmenitiesView,
        arguments: propertyOwnerUploadModel);
  }

  void goToPropertyOwnerDatePickerView() {
    _navigationService.navigateTo(Routes.propertyOwnerDatePickerView);
  }

  List<SubType>? subTypes = [
    SubType(id: 1, name: "Monthly"),
    SubType(id: 2, name: "Quarterly"),
    SubType(id: 3, name: "Biannully"),
    SubType(id: 4, name: "Anually"),
  ];
  late final items = subTypes
      ?.map((subscription) =>
          MultiSelectItem<SubType>(subscription, subscription.name))
      .toList();

  List<SubType>? selectedSub = [];

  void onSelectedSubChange1(value) {
    selectedSub = subTypes;

    notifyListeners();
  }

  // void showMultiSelect(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (ctx) {
  //       return MultiSelectDialog(
  //         items: items,
  //         initialValue: selectedAnimals,
  //         onConfirm: (values) {
  //           selectedSub = subTypes;
  //         },
  //       );
  //     },
  //   );
  // }
}

class SubType {
  final int id;
  final String name;

  SubType({
    required this.id,
    required this.name,
  });
}
