// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/appointment.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';

class AppointmentListViewModel extends BaseViewModel {
  bool isLoading = false;
  bool hasError = false;

  final _userService = locator<UserTypeService>();

  LoginModel get userData => _userService.userData;

  String? selectedValue;

  List<Appointment> userAppointments = [];

  AppointmentListViewModel() {
    getData();
  }

  void getData() async {
    isLoading = true;
    hasError = false;
    notifyListeners();
    try {
      final queryData = await getTenantAppointments(userData.email, limit: 30);

      userAppointments = queryData.docs
          .map(
            (documentSnapshot) => Appointment.fromMap(
              documentSnapshot.data(),
            ),
          )
          .toList();

      isLoading = false;
      hasError = false;
      notifyListeners();
    } catch (exception) {
      isLoading = false;
      hasError = true;
      notifyListeners();
    }
  }

  void onSelectedValueChange(String? value) {
    selectedValue = value;
    notifyListeners();
  }
}
