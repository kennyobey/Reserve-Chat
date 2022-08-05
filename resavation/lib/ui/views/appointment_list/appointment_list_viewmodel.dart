// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/appointment.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';

class AppointmentListViewModel extends BaseViewModel {
  bool isLoading = true;
  bool hasErrorOnData = false;

  final _userService = locator<UserTypeService>();

  LoginModel get userData => _userService.userData;

  String? selectedValue;

  List<Appointment> userAppointments = [];

  void getData() async {
    isLoading = true;
    hasErrorOnData = false;
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
      hasErrorOnData = false;
      notifyListeners();
    } catch (exception) {
      isLoading = false;
      hasErrorOnData = true;
      notifyListeners();
    }
  }

  void onSelectedValueChange(String? value) {
    selectedValue = value;
    notifyListeners();
  }
}
