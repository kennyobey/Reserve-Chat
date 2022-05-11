import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerIdentificationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();

  String? selectedGender;
  List<String> gender = ['Male', 'Female'];

  DateTime selectedDate = DateTime.now();

  final TextEditingController userFirstNameController = TextEditingController();
  final TextEditingController userLastNameController = TextEditingController();
  final TextEditingController userPhoneNumberController =
      TextEditingController();
  final TextEditingController userStateController = TextEditingController();
  final TextEditingController userCityController = TextEditingController();
  final TextEditingController userCountryController = TextEditingController();
  final TextEditingController userGenderController = TextEditingController();
  final TextEditingController userAddressController = TextEditingController();
  final TextEditingController userDOBController = TextEditingController();

  void upoloadPropertyToServer() async {
    final String userFirstName = userFirstNameController.text;
    final String userLastName = userLastNameController.text;
    final String userPhoneNum = userPhoneNumberController.text;
    final String userState = userStateController.text;
    final String userCity = userCityController.text;

    final String userAddress = userAddressController.text;

    httpService.uploadProperty(userDetails: {
      "address": userAddress,
      "city": userCity,
      "country": selectedCountry,
      "dateOfBirth": selectedDate.toString(),
      "phoneNumber": userPhoneNum,
      "state": userState,
      "gender": selectedGender.toString(),
      "firstName": userFirstName,
      "lastName": userLastName
    });
  }

  // country picker UI logic
  String selectedCountry = "Country";
  Function(Country) onSelectCountryTap(Country country) {
    return (Country country) {
      selectedCountry = country.name.toString();
      notifyListeners();
    };
  }

  Future<void> selecStarttDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      print("The picked date of birth is $selectedDate");

      notifyListeners();
    }
  }

  void onSelectedValueChange1(value) {
    selectedGender = value as String;
  }

  void goToPropertyOwnerVerificationView() {
    _navigationService.navigateTo(Routes.propertyOwnerVerificationView);
  }
}
