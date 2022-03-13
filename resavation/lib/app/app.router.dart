// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:resavation/ui/views/audio_call/audio_call_view.dart';
import 'package:resavation/ui/views/chat_room/chat_room_view.dart';
import 'package:resavation/ui/views/property_owner_identification/property_owner_identificationView.dart';
import 'package:resavation/ui/views/video_call/video_call_view.dart';
import 'package:stacked/stacked.dart';

import '../ui/views/booking_submission/booking_submission_view.dart';
import '../ui/views/confirmation/confirmation_view.dart';
import '../ui/views/date_picker/date_picker_view.dart';
import '../ui/views/edit_profile/edit_profile_view.dart';
import '../ui/views/filter/filter_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/main/main_view.dart';
import '../ui/views/map/map_view.dart';
import '../ui/views/messages/messages_view.dart';
import '../ui/views/onboarding/onboarding_view.dart';
import '../ui/views/payment/payment_view.dart';
import '../ui/views/profile_product_list/profile_product_list_view.dart';
import '../ui/views/property_details/property_details_view.dart';
import '../ui/views/property_owner_profile/property_owner_profile_view.dart';
import '../ui/views/rest_password/reset_password_view.dart';
import '../ui/views/search/search_view.dart';
import '../ui/views/settings/settings_view.dart';
import '../ui/views/signup/signup_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String mainView = '/main-view';
  static const String onboardingView = '/onboarding-view';
  static const String signUpView = '/sign-up-view';
  static const String logInView = '/log-in-view';
  static const String resetPasswordView = '/reset-password-view';
  static const String filterView = '/filter-view';
  static const String datePickerView = '/date-picker-view';
  static const String propertyDetailsView = '/property-details-view';
  static const String bookingSubmissionView = '/booking-submission-view';
  static const String settingsView = '/settings-view';
  static const String mapView = '/map-view';
  static const String paymentView = '/payment-view';
  static const String propertyOwnerProfileView = '/property-owner-profile-view';
  static const String propertyOwnerIdentificationView = '/property-owner-identification-view';
  static const String confirmationView = '/confirmation-view';
  static const String propertyOwnerStep1View = '/property-owner-step1-view';
  static const String profileProductListView = '/profile-product-list-view';
  static const String searchView = '/search-view';
  static const String editProfileView = '/edit-profile-view';
  static const String messagesView = '/messages-view';
  static const String chatRoomView = '/chat-room-view';
  static const String videoCallView = '/video-call-view';
  static const String audioCallView = '/audio-call-view';




  static const all = <String>{
    startupView,
    mainView,
    onboardingView,
    signUpView,
    logInView,
    resetPasswordView,
    filterView,
    datePickerView,
    propertyDetailsView,
    bookingSubmissionView,
    settingsView,
    mapView,
    paymentView,
    propertyOwnerProfileView,
    propertyOwnerIdentificationView,
    confirmationView,
    propertyOwnerStep1View,
    profileProductListView,
    searchView,
    editProfileView,
    messagesView,
    chatRoomView,
    videoCallView,
    audioCallView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.mainView, page: MainView),
    RouteDef(Routes.onboardingView, page: OnboardingView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.logInView, page: LogInView),
    RouteDef(Routes.resetPasswordView, page: ResetPasswordView),
    RouteDef(Routes.filterView, page: FilterView),
    RouteDef(Routes.datePickerView, page: DatePickerView),
    RouteDef(Routes.propertyDetailsView, page: PropertyDetailsView),
    RouteDef(Routes.bookingSubmissionView, page: BookingSubmissionView),
    RouteDef(Routes.settingsView, page: SettingsView),
    RouteDef(Routes.mapView, page: MapView),
    RouteDef(Routes.paymentView, page: PaymentView),
    RouteDef(Routes.propertyOwnerProfileView, page: PropertyOwnerProfileView),
    RouteDef(Routes.propertyOwnerIdentificationView, page: PropertyOwnerIdentificationView),
    RouteDef(Routes.confirmationView, page: ConfirmationView),
    RouteDef(Routes.profileProductListView, page: ProfileProductListView),
    RouteDef(Routes.searchView, page: SearchView),
    RouteDef(Routes.editProfileView, page: EditProfileView),
    RouteDef(Routes.messagesView, page: MessagesView),
    RouteDef(Routes.chatRoomView, page: ChatRoomView),
    RouteDef(Routes.videoCallView, page: VideoCallView),
    RouteDef(Routes.audioCallView, page: AudioCallView),

  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    MainView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const MainView(),
        settings: data,
      );
    },
    OnboardingView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const OnboardingView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const SignUpView(),
        settings: data,
      );
    },
    LogInView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const LogInView(),
        settings: data,
      );
    },
    ResetPasswordView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const ResetPasswordView(),
        settings: data,
      );
    },
    FilterView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const FilterView(),
        settings: data,
      );
    },
    DatePickerView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const DatePickerView(),
        settings: data,
      );
    },
    PropertyDetailsView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyDetailsView(),
        settings: data,
      );
    },
    BookingSubmissionView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const BookingSubmissionView(),
        settings: data,
      );
    },
    SettingsView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const SettingsView(),
        settings: data,
      );
    },
    MapView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const MapView(),
        settings: data,
      );
    },
    PaymentView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) =>  PaymentView(),
        settings: data,
      );
    },
    PropertyOwnerProfileView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerProfileView(),
        settings: data,
      );
    },

    PropertyOwnerIdentificationView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerIdentificationView(),
        settings: data,
      );
    },

    ConfirmationView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const ConfirmationView(),
        settings: data,
      );
    },
    ProfileProductListView: (data) {
      var args = data.getArgs<ProfileProductListViewArguments>(
        orElse: () => ProfileProductListViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ProfileProductListView(
          key: args.key,
          onSortByTap: args.onSortByTap,
        ),
        settings: data,
      );
    },
    SearchView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const SearchView(),
        settings: data,
      );
    },
    EditProfileView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const EditProfileView(),
        settings: data,
      );
    },
    MessagesView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const MessagesView(),
        settings: data,
      );
    },
    ChatRoomView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) =>  ChatRoomView(),
        settings: data,
      );
    },
    VideoCallView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) =>  VideoCallView(),
        settings: data,
      );
    },
    AudioCallView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) =>  AudioCallView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ProfileProductListView arguments holder class
class ProfileProductListViewArguments {
  final Key? key;
  final void Function()? onSortByTap;
  ProfileProductListViewArguments({this.key, this.onSortByTap});
}
