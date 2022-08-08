import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/amenities_model.dart';
import 'package:resavation/model/appointment.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/propety_model/user.dart';
import 'package:resavation/model/tenant_booked_property/content.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:resavation/ui/views/messages/messages_viewmodel.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyDetailsTenantViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final userService = locator<UserTypeService>();
  final _snackbarService = locator<CustomSnackbarService>();
  int _pagePosition = 0;
  int get pagePosition => _pagePosition;
  Property? property;

  PropertyDetailsTenantViewModel(Property? property) {
    this.property = property;
    notifyListeners();
  }

  Property getProperty() {
    return _navigationService.currentArguments;
  }

  void onPageChanged(int index) {
    _pagePosition = index;
    notifyListeners();
  }

  // List<Property> get properties => listOfProperties;
  List<Property> get properties => [];
  List<Amenity> get amenities => ListOfAmenities;

  void navigateBack() {
    _navigationService.back();
  }

  onFavouriteTap() async {
    try {
      if (property == null ||
          property!.id == null ||
          property!.favourite == null) {
        return;
      }

      property = property?.copyWith(favourite: !(property!.favourite!));

      notifyListeners();

      /// toggling the property
      await httpService.togglePropertyAsFavourite(
          propertyId: property?.id ?? -1);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToDatePickerView() {
    if (property != null) {
      _navigationService.navigateTo(Routes.datePickerView,
          arguments: DatePickerViewArguments(property: property!));
    }
  }

  Future<bool> gotToChatRoomView() async {
    if (userService.userData.email == (property?.user?.email ?? '-')) {
      return true;
    } else {
      final chatModel = await MessagesViewModel.createChat(
        property?.user?.email?.trim() ?? '-',
        (property?.user?.firstName?.trim() ?? '') +
            ' ' +
            (property?.user?.lastName?.trim() ?? ''),
        property?.user?.imageUrl?.trim() ?? '',
      );
      _navigationService.navigateTo(Routes.chatRoomView,
          arguments: ChatRoomViewArguments(chatModel: chatModel));
      return false;
    }
  }

  void goToPropertyOwnersProfileView(User? user) {
    if (user != null) {
      _navigationService.navigateTo(
        Routes.propertyOwnerProfileView,
        arguments: PropertyOwnerProfileViewArguments(
          user: user,
        ),
      );
    }
  }

  goToBookAppointmentPage() {
    final appointmentBookingDetails = AppointmentBookingDetails(
        ownerEmail: property?.user?.email ?? '-',
        propertyName: property?.propertyName ?? '',
        ownerName: (property?.user?.firstName ?? '') +
            ' ' +
            (property?.user?.lastName ?? ''),
        location: property?.address ?? '');
    _navigationService.navigateTo(
      Routes.appointmentBookingPage,
      arguments: AppointmentBookingPageArguments(
          appointmentBookingDetails: appointmentBookingDetails),
    );
  }

  //Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }

  /* void goToMakePayment(TenantBookedPropertyContent? propertyContent) {
    final planAmount = propertyContent?.amount ?? 0;
    final subscriptionCode = '--';
    _navigationService.navigateTo(Routes.makePaymentView,
        arguments: MakePaymentViewArguments(
          planAmount: planAmount,
          subscriptionCode: subscriptionCode,
        ));
        
  }
 */
  Future<String> chargeUser(TenantBookedPropertyContent? propertyContent,
      BuildContext context) async {
    final planAmount = propertyContent?.amount ?? 0;
    final plugin = PaystackPlugin();
    await plugin.initialize(
        publicKey: 'pk_test_e16fa6551c9df39291ec9a0d69efed432d1a6cb3');

    final email = userService.userData.email;

    String platform;
    if (Platform.isIOS) {
      platform = 'Ios';
    } else {
      platform = 'Android';
    }

    final reference =
        'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';

    final logo = Container(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/icons/app_icon.png',
        width: 80,
        height: 80,
        fit: BoxFit.fitWidth,
      ),
    );
    Charge charge = Charge()
      ..amount = (planAmount.toInt() * 100)
      ..reference = reference
      ..email = email
      ..card = PaymentCard(
        number: null,
        cvc: null,
        expiryMonth: null,
        expiryYear: null,
      );

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: true,
        logo: logo,
      );

      final reference = response.reference;

      if (response.status) {
        final response = await httpService.verifiyPayment(
          reference: reference ?? '',
          propertyId: propertyContent?.property?.id ?? -1,
          interval: propertyContent?.paymentCycle ?? '',
        );
        return response;
      }

      if (response.verify) {
        final response = await httpService.verifiyPayment(
          reference: reference ?? '',
          propertyId: propertyContent?.property?.id ?? -1,
          interval: propertyContent?.paymentCycle ?? '',
        );
        return response;
      } else {
        return Future.error(response.message);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
