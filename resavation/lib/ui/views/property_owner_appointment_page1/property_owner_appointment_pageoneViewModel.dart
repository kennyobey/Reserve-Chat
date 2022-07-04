import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/appointment.dart';
import 'package:resavation/model/login_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/user_type_service.dart';

class PropertyOwnerAppointmentPageoneViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserTypeService>();

  LoginModel get userData => _userService.userData;

  final pageController = PageController();

  int currentTabPosition = 0;

  onTabItemPressed(int tab) {
    pageController.animateToPage(
      tab,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  PageController get getPageController {
    return pageController;
  }

  void onPageChanged(int tab) {
    currentTabPosition = tab;
    notifyListeners();
  }

  void goToPropertyOwnerHomePageView() {
    _navigationService.navigateTo(Routes.propertyOwnerHomePageView);
  }

  void goToDatePickerView() {
    _navigationService.navigateTo(Routes.datePickerView);
  }

  void acceptDeclineAppointment(
      Appointment oldAppointment, AppointmentStatus appointmentStatus) {
    final appointment = Appointment();

    appointment.appointmentDate = oldAppointment.appointmentDate;
    appointment.appointmentStartTime = oldAppointment.appointmentStartTime;
    appointment.appointmentEndTime = oldAppointment.appointmentEndTime;
    appointment.propertyName = oldAppointment.propertyName;
    appointment.landOwnerMail = oldAppointment.landOwnerMail;
    appointment.status = appointmentStatus;
    appointment.tenantImage = oldAppointment.tenantImage;
    appointment.tenantMail = oldAppointment.tenantMail;
    appointment.landOwnerName = oldAppointment.landOwnerName;
    appointment.tenantName = oldAppointment.tenantName;
    appointment.location = oldAppointment.location;

    setAppointmentStatus(appointment);
  }
}
