// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:resavation/model/call_model.dart';
import 'package:stacked/stacked.dart';

import '../model/property_model.dart';
import '../ui/views/audio_call/audio_call_view.dart';
import '../ui/views/booking_submission/booking_submission_view.dart';
import '../ui/views/chat_room/chat_room_view.dart';
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
import '../ui/views/property_owner_add_cover_photo/property_owner_add_cover_photoView.dart';
import '../ui/views/property_owner_add_photos/property_owner_add_photosView.dart';
import '../ui/views/property_owner_amenities/property_owner_amenities_view.dart';
import '../ui/views/property_owner_analyticpage/property_owner_analyticView.dart';
import '../ui/views/property_owner_datepicker/property_owner_datepickerView.dart';
import '../ui/views/property_owner_details/property_owner_details_view.dart';
import '../ui/views/property_owner_edit_profile/property_owner_edit_profileView.dart';
import '../ui/views/property_owner_homepage/property_owner_homepageView.dart';
import '../ui/views/property_owner_identification/property_owner_identificationView.dart';
import '../ui/views/property_owner_identification_verification/property_owner_identification_verificationView.dart';
import '../ui/views/property_owner_payment/property_owner_payment_view.dart';
import '../ui/views/property_owner_profile/property_owner_profile_view.dart';
import '../ui/views/property_owner_settings/property_owner_settingsView.dart';
import '../ui/views/property_owner_spaceType/property_owner_spacetype_view.dart';
import '../ui/views/property_owner_verification/property_owner_verificationView.dart';
import '../ui/views/property_verification/property_verificationView.dart';
import '../ui/views/rest_password/reset_password_view.dart';
import '../ui/views/search/search_view.dart';
import '../ui/views/settings/settings_view.dart';
import '../ui/views/signup/signup_view.dart';
import '../ui/views/startup/startup_view.dart';
import '../ui/views/video_call/video_call_view.dart';

class Routes {
  static const String startupView = '/';
  static const String mainView = '/main-view';
  static const String onboardingView = '/onboarding-view';
  static const String signUpView = '/sign-up-view';
  static const String logInView = '/log-in-view';
  static const String chatRoomView = '/chat-room-view';
  static const String propertyOwnerIdentificationVerificationView =
      '/property-owner-identification-verification-view';
  static const String propertyOwnerHomePageView =
      '/property-owner-home-page-view';
  static const String audioCallView = '/audio-call-view';
  static const String propertyOwnerEditProfileView =
      '/property-owner-edit-profile-view';
  static const String propertyOwnerDatePickerView =
      '/property-owner-date-picker-view';
  static const String propertyOwnerAnalyticView =
      '/property-owner-analytic-view';
  static const String propertyVerificationView = '/property-verification-view';
  static const String propertyOwnerAddPhotosView =
      '/property-owner-add-photos-view';
  static const String propertyOwnerAddCoverPhotosView =
      '/property-owner-add-cover-photos-view';
  static const String videoCallView = '/video-call-view';
  static const String resetPasswordView = '/reset-password-view';
  static const String filterView = '/filter-view';
  static const String datePickerView = '/date-picker-view';
  static const String propertyDetailsView = '/property-details-view';
  static const String bookingSubmissionView = '/booking-submission-view';
  static const String settingsView = '/settings-view';
  static const String mapView = '/map-view';
  static const String paymentView = '/payment-view';
  static const String propertyOwnerProfileView = '/property-owner-profile-view';
  static const String confirmationView = '/confirmation-view';
  static const String profileProductListView = '/profile-product-list-view';
  static const String searchView = '/search-view';
  static const String editProfileView = '/edit-profile-view';
  static const String messagesView = '/messages-view';
  static const String propertyOwnerSpaceTypeView =
      '/property-owner-space-type-view';
  static const String propertyOwnerDetailsView = '/property-owner-details-view';
  static const String propertyOwnerPaymentView = '/property-owner-payment-view';
  static const String propertyOwnerAmenitiesView =
      '/property-owner-amenities-view';
  static const String propertyOwnerIdentificationView =
      '/property-owner-identification-view';
  static const String propertyOwnerVerificationView =
      '/property-owner-verification-view';
  static const String propertyOwnerSettingsView =
      '/property-owner-settings-view';
  static const all = <String>{
    startupView,
    mainView,
    onboardingView,
    signUpView,
    logInView,
    chatRoomView,
    propertyOwnerIdentificationVerificationView,
    propertyOwnerHomePageView,
    audioCallView,
    propertyOwnerEditProfileView,
    propertyOwnerDatePickerView,
    propertyOwnerAnalyticView,
    propertyVerificationView,
    propertyOwnerAddPhotosView,
    propertyOwnerAddCoverPhotosView,
    videoCallView,
    resetPasswordView,
    filterView,
    datePickerView,
    propertyDetailsView,
    bookingSubmissionView,
    settingsView,
    mapView,
    paymentView,
    propertyOwnerProfileView,
    confirmationView,
    profileProductListView,
    searchView,
    editProfileView,
    messagesView,
    propertyOwnerSpaceTypeView,
    propertyOwnerDetailsView,
    propertyOwnerPaymentView,
    propertyOwnerAmenitiesView,
    propertyOwnerIdentificationView,
    propertyOwnerVerificationView,
    propertyOwnerSettingsView,
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
    RouteDef(Routes.chatRoomView, page: ChatRoomView),
    RouteDef(Routes.propertyOwnerIdentificationVerificationView,
        page: PropertyOwnerIdentificationVerificationView),
    RouteDef(Routes.propertyOwnerHomePageView, page: PropertyOwnerHomePageView),
    RouteDef(Routes.audioCallView, page: AudioCallView),
    RouteDef(Routes.propertyOwnerEditProfileView,
        page: PropertyOwnerEditProfileView),
    RouteDef(Routes.propertyOwnerDatePickerView,
        page: PropertyOwnerDatePickerView),
    RouteDef(Routes.propertyOwnerAnalyticView, page: PropertyOwnerAnalyticView),
    RouteDef(Routes.propertyVerificationView, page: PropertyVerificationView),
    RouteDef(Routes.propertyOwnerAddPhotosView,
        page: PropertyOwnerAddPhotosView),
    RouteDef(Routes.propertyOwnerAddCoverPhotosView,
        page: PropertyOwnerAddCoverPhotosView),
    RouteDef(Routes.videoCallView, page: VideoCallView),
    RouteDef(Routes.resetPasswordView, page: ResetPasswordView),
    RouteDef(Routes.filterView, page: FilterView),
    RouteDef(Routes.datePickerView, page: DatePickerView),
    RouteDef(Routes.propertyDetailsView, page: PropertyDetailsView),
    RouteDef(Routes.bookingSubmissionView, page: BookingSubmissionView),
    RouteDef(Routes.settingsView, page: SettingsView),
    RouteDef(Routes.mapView, page: MapView),
    RouteDef(Routes.paymentView, page: PaymentView),
    RouteDef(Routes.propertyOwnerProfileView, page: PropertyOwnerProfileView),
    RouteDef(Routes.confirmationView, page: ConfirmationView),
    RouteDef(Routes.profileProductListView, page: ProfileProductListView),
    RouteDef(Routes.searchView, page: SearchView),
    RouteDef(Routes.editProfileView, page: EditProfileView),
    RouteDef(Routes.messagesView, page: MessagesView),
    RouteDef(Routes.propertyOwnerSpaceTypeView,
        page: PropertyOwnerSpaceTypeView),
    RouteDef(Routes.propertyOwnerDetailsView, page: PropertyOwnerDetailsView),
    RouteDef(Routes.propertyOwnerPaymentView, page: PropertyOwnerPaymentView),
    RouteDef(Routes.propertyOwnerAmenitiesView,
        page: PropertyOwnerAmenitiesView),
    RouteDef(Routes.propertyOwnerIdentificationView,
        page: PropertyOwnerIdentificationView),
    RouteDef(Routes.propertyOwnerVerificationView,
        page: PropertyOwnerVerificationView),
    RouteDef(Routes.propertyOwnerSettingsView, page: PropertyOwnerSettingsView),
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
    ChatRoomView: (data) {
      final ChatModel? chatModel = data.arguments as ChatModel?;
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ChatRoomView(
          chatModel: chatModel,
        ),
        settings: data,
      );
    },
    PropertyOwnerIdentificationVerificationView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) =>
            const PropertyOwnerIdentificationVerificationView(),
        settings: data,
      );
    },
    PropertyOwnerHomePageView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerHomePageView(),
        settings: data,
      );
    },
    AudioCallView: (data) {
      final CallModel? call = data.arguments as CallModel?;
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AudioCallView(
          call: call,
        ),
        settings: data,
      );
    },
    PropertyOwnerEditProfileView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerEditProfileView(),
        settings: data,
      );
    },
    PropertyOwnerDatePickerView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerDatePickerView(),
        settings: data,
      );
    },
    PropertyOwnerAnalyticView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerAnalyticView(),
        settings: data,
      );
    },
    PropertyVerificationView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyVerificationView(),
        settings: data,
      );
    },
    PropertyOwnerAddPhotosView: (data) {
      var args = data.getArgs<PropertyOwnerAddPhotosViewArguments>(
        orElse: () => PropertyOwnerAddPhotosViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PropertyOwnerAddPhotosView(key: args.key),
        settings: data,
      );
    },
    PropertyOwnerAddCoverPhotosView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerAddCoverPhotosView(),
        settings: data,
      );
    },
    VideoCallView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const VideoCallView(),
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
      final Property? property = data.arguments as Property?;
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DatePickerView(property: property),
        settings: data,
      );
    },
    PropertyDetailsView: (data) {
      final Property? property = data.arguments as Property?;
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PropertyDetailsView(property: property),
        settings: data,
      );
    },
    BookingSubmissionView: (data) {
      final Map<String, dynamic>? bookingData =
          data.arguments as Map<String, dynamic>?;
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => BookingSubmissionView(
          bookingData: bookingData,
        ),
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
        builder: (context) => const PaymentView(),
        settings: data,
      );
    },
    PropertyOwnerProfileView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerProfileView(),
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
    PropertyOwnerSpaceTypeView: (data) {
      var args = data.getArgs<PropertyOwnerSpaceTypeViewArguments>(
        orElse: () => PropertyOwnerSpaceTypeViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PropertyOwnerSpaceTypeView(key: args.key),
        settings: data,
      );
    },
    PropertyOwnerDetailsView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerDetailsView(
          isFurnished: false,
          isServiced: false,
          leaveHere: false,
        ),
        settings: data,
      );
    },
    PropertyOwnerPaymentView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerPaymentView(),
        settings: data,
      );
    },
    PropertyOwnerAmenitiesView: (data) {
      var args = data.getArgs<PropertyOwnerAmenitiesViewArguments>(
        orElse: () => PropertyOwnerAmenitiesViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PropertyOwnerAmenitiesView(key: args.key),
        settings: data,
      );
    },
    PropertyOwnerIdentificationView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerIdentificationView(),
        settings: data,
      );
    },
    PropertyOwnerVerificationView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerVerificationView(),
        settings: data,
      );
    },
    PropertyOwnerSettingsView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerSettingsView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PropertyOwnerAddPhotosView arguments holder class
class PropertyOwnerAddPhotosViewArguments {
  final Key? key;
  PropertyOwnerAddPhotosViewArguments({this.key});
}

/// ProfileProductListView arguments holder class
class ProfileProductListViewArguments {
  final Key? key;
  final void Function()? onSortByTap;
  ProfileProductListViewArguments({this.key, this.onSortByTap});
}

/// PropertyOwnerSpaceTypeView arguments holder class
class PropertyOwnerSpaceTypeViewArguments {
  final Key? key;
  PropertyOwnerSpaceTypeViewArguments({this.key});
}

/// PropertyOwnerAmenitiesView arguments holder class
class PropertyOwnerAmenitiesViewArguments {
  final Key? key;
  PropertyOwnerAmenitiesViewArguments({this.key});
}
