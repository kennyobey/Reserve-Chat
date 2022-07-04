// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../model/appointment.dart';
import '../model/booked_property/content.dart';
import '../model/call_model.dart';
import '../model/filter/filter.dart';
import '../model/propety_model/property_model.dart';
import '../model/propety_model/user.dart';
import '../ui/views/appointment_booking/appointment_booking.dart';
import '../ui/views/appointment_list/appointment_list_view.dart';
import '../ui/views/audio_call/audio_call_view.dart';
import '../ui/views/booked_appointment_list/bool_property_list_view.dart';
import '../ui/views/booking_submission/booking_submission_view.dart';
import '../ui/views/categories_list/categories_list_view.dart';
import '../ui/views/chat_room/chat_room_view.dart';
import '../ui/views/co_working_space_about/co_working_space_aboutView.dart';
import '../ui/views/confirmation/confirmation_view.dart';
import '../ui/views/date_picker/date_picker_view.dart';
import '../ui/views/date_picker/date_picker_viewmodel.dart';
import '../ui/views/edit_profile/edit_profile_view.dart';
import '../ui/views/filter/filter_view.dart';
import '../ui/views/filter_display/filter_display.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/main/main_view.dart';
import '../ui/views/make_payment/make_payment_view.dart';
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
import '../ui/views/property_owner_my_properties/property_owner_my_propertiesView.dart';
import '../ui/views/property_owner_payment/property_owner_payment_view.dart';
import '../ui/views/property_owner_profile/property_owner_profile_view.dart';
import '../ui/views/property_owner_settings/property_owner_settingsView.dart';
import '../ui/views/property_owner_spaceType/property_owner_spacetype_view.dart';
import '../ui/views/property_owner_tracklist/property_owner_tracklisView.dart';
import '../ui/views/property_owner_verification/property_owner_verificationView.dart';
import '../ui/views/property_verification/property_verificationView.dart';
import '../ui/views/rest_password/reset_password_view.dart';
import '../ui/views/search/search_view.dart';
import '../ui/views/settings/settings_view.dart';
import '../ui/views/sign_up_confirmation/signup_confirmation_view.dart';
import '../ui/views/signup/signup_view.dart';
import '../ui/views/startup/startup_view.dart';
import '../ui/views/states_list/states_list_view.dart';
import '../ui/views/top_items/top_item_view.dart';
import '../ui/views/user_profile/user_profile_view.dart';
import '../ui/views/user_profile_page/user_profile_pageView.dart';
import '../ui/views/verify_user_account/verify_user_account.dart';
import '../ui/views/video_call/video_call_view.dart';

class Routes {
  static const String startupView = '/';
  static const String mainView = '/main-view';
  static const String appointmentBookingPage = '/appointment-booking-page';
  static const String coWorkingSpaceAboutView = '/co-working-space-about-view';
  static const String appointmentListView = '/appointment-list-view';
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
  static const String bookedPropertyListView = '/booked-property-list-view';
  static const String videoCallView = '/video-call-view';
  static const String makePaymentView = '/make-payment-view';
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
  static const String filterDisplay = '/filter-display';
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
  static const String topItemView = '/top-item-view';
  static const String propertyOwnerSettingsView =
      '/property-owner-settings-view';
  static const String verifyUserAccount = '/verify-user-account';
  static const String signUpConfirmationView = '/sign-up-confirmation-view';
  static const String propertyOwnerMyPropertyView =
      '/property-owner-my-property-view';
  static const String propertyOwnerTrackListView =
      '/property-owner-track-list-view';
  static const String categoriesListView = '/categories-list-view';
  static const String statesListView = '/states-list-view';
  static const String userProfilePageView = '/user-Profile-page-view';
  static const String verificationPage = '/verification-page-view';
  static const String userProfileView = '/user-profile-view';

  //UserProfileView

  static const all = <String>{
    startupView,
    mainView,
    appointmentBookingPage,
    coWorkingSpaceAboutView,
    appointmentListView,
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
    bookedPropertyListView,
    videoCallView,
    makePaymentView,
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
    filterDisplay,
    propertyOwnerSpaceTypeView,
    propertyOwnerDetailsView,
    propertyOwnerPaymentView,
    propertyOwnerAmenitiesView,
    propertyOwnerIdentificationView,
    propertyOwnerVerificationView,
    topItemView,
    propertyOwnerSettingsView,
    verifyUserAccount,
    signUpConfirmationView,
    propertyOwnerMyPropertyView,
    propertyOwnerTrackListView,
    categoriesListView,
    statesListView,
    userProfilePageView,
    verificationPage,
    userProfileView
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.mainView, page: MainView),
    RouteDef(Routes.appointmentBookingPage, page: AppointmentBookingPage),
    RouteDef(Routes.coWorkingSpaceAboutView, page: CoWorkingSpaceAboutView),
    RouteDef(Routes.appointmentListView, page: AppointmentListView),
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
    RouteDef(Routes.bookedPropertyListView, page: BookedPropertyListView),
    RouteDef(Routes.videoCallView, page: VideoCallView),
    RouteDef(Routes.makePaymentView, page: MakePaymentView),
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
    RouteDef(Routes.filterDisplay, page: FilterDisplay),
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
    RouteDef(Routes.topItemView, page: TopItemView),
    RouteDef(Routes.propertyOwnerSettingsView, page: PropertyOwnerSettingsView),
    RouteDef(Routes.verifyUserAccount, page: VerifyUserAccount),
    RouteDef(Routes.signUpConfirmationView, page: SignUpConfirmationView),
    RouteDef(Routes.propertyOwnerMyPropertyView,
        page: PropertyOwnerMyPropertyView),
    RouteDef(Routes.propertyOwnerTrackListView,
        page: PropertyOwnerTrackListView),
    RouteDef(Routes.categoriesListView, page: CategoriesListView),
    RouteDef(Routes.statesListView, page: StatesListView),
    RouteDef(Routes.userProfilePageView, page: UserProfilePageView),
    RouteDef(Routes.verificationPage, page: VerificationPage),
    RouteDef(Routes.userProfileView, page: UserProfileView),
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
    AppointmentBookingPage: (data) {
      var args = data.getArgs<AppointmentBookingPageArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AppointmentBookingPage(
          key: args.key,
          appointmentBookingDetails: args.appointmentBookingDetails,
        ),
        settings: data,
      );
    },
    CoWorkingSpaceAboutView: (data) {
      var args = data.getArgs<CoWorkingSpaceAboutViewArguments>(
        orElse: () => CoWorkingSpaceAboutViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => CoWorkingSpaceAboutView(key: args.key),
        settings: data,
      );
    },
    AppointmentListView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const AppointmentListView(),
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
      var args = data.getArgs<ChatRoomViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ChatRoomView(
          chatModel: args.chatModel,
          key: args.key,
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
      var args = data.getArgs<AudioCallViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AudioCallView(
          key: args.key,
          call: args.call,
          reciever: args.reciever,
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
      var args = data.getArgs<PropertyOwnerAddCoverPhotosViewArguments>(
        orElse: () => PropertyOwnerAddCoverPhotosViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PropertyOwnerAddCoverPhotosView(key: args.key),
        settings: data,
      );
    },
    BookedPropertyListView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const BookedPropertyListView(),
        settings: data,
      );
    },
    VideoCallView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const VideoCallView(),
        settings: data,
      );
    },
    MakePaymentView: (data) {
      var args = data.getArgs<MakePaymentViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => MakePaymentView(
          key: args.key,
          planAmount: args.planAmount,
          subscriptionCode: args.subscriptionCode,
        ),
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
      var args = data.getArgs<DatePickerViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DatePickerView(
          key: args.key,
          property: args.property,
        ),
        settings: data,
      );
    },
    PropertyDetailsView: (data) {
      var args = data.getArgs<PropertyDetailsViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PropertyDetailsView(
          key: args.key,
          passedProperty: args.passedProperty,
          propertyContent: args.propertyContent,
        ),
        settings: data,
      );
    },
    BookingSubmissionView: (data) {
      var args = data.getArgs<BookingSubmissionViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => BookingSubmissionView(
          key: args.key,
          property: args.property,
          startDate: args.startDate,
          choiceOfPayment: args.choiceOfPayment,
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
      var args = data.getArgs<PropertyOwnerProfileViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PropertyOwnerProfileView(
          key: args.key,
          user: args.user,
          propertyId: args.propertyId,
        ),
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
    FilterDisplay: (data) {
      var args = data.getArgs<FilterDisplayArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => FilterDisplay(
          key: args.key,
          filter: args.filter,
        ),
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
        builder: (context) => const PropertyOwnerDetailsView(),
        settings: data,
      );
    },
    PropertyOwnerPaymentView: (data) {
      var args = data.getArgs<PropertyOwnerPaymentViewArguments>(
        orElse: () => PropertyOwnerPaymentViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PropertyOwnerPaymentView(key: args.key),
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
    TopItemView: (data) {
      var args = data.getArgs<TopItemViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TopItemView(
          key: args.key,
          itemName: args.itemName,
          isStates: args.isStates,
        ),
        settings: data,
      );
    },
    PropertyOwnerSettingsView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerSettingsView(),
        settings: data,
      );
    },
    VerifyUserAccount: (data) {
      var args = data.getArgs<VerifyUserAccountArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => VerifyUserAccount(
          key: args.key,
          email: args.email,
        ),
        settings: data,
      );
    },
    SignUpConfirmationView: (data) {
      var args = data.getArgs<SignUpConfirmationViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SignUpConfirmationView(
          key: args.key,
          email: args.email,
        ),
        settings: data,
      );
    },
    PropertyOwnerMyPropertyView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerMyPropertyView(),
        settings: data,
      );
    },
    PropertyOwnerTrackListView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const PropertyOwnerTrackListView(),
        settings: data,
      );
    },
    CategoriesListView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const CategoriesListView(),
        settings: data,
      );
    },
    StatesListView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const StatesListView(),
        settings: data,
      );
    },
    UserProfilePageView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const UserProfilePageView(),
        settings: data,
      );
    },
    VerificationPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const VerificationPage(),
        settings: data,
      );
    },
    UserProfileView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const UserProfileView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AppointmentBookingPage arguments holder class
class AppointmentBookingPageArguments {
  final Key? key;
  final AppointmentBookingDetails appointmentBookingDetails;
  AppointmentBookingPageArguments(
      {this.key, required this.appointmentBookingDetails});
}

/// CoWorkingSpaceAboutView arguments holder class
class CoWorkingSpaceAboutViewArguments {
  final Key? key;
  CoWorkingSpaceAboutViewArguments({this.key});
}

/// ChatRoomView arguments holder class
class ChatRoomViewArguments {
  final ChatModel? chatModel;
  final Key? key;
  ChatRoomViewArguments({required this.chatModel, this.key});
}

/// AudioCallView arguments holder class
class AudioCallViewArguments {
  final Key? key;
  final CallModel? call;
  final bool reciever;
  AudioCallViewArguments({this.key, required this.call, this.reciever = false});
}

/// PropertyOwnerAddPhotosView arguments holder class
class PropertyOwnerAddPhotosViewArguments {
  final Key? key;
  PropertyOwnerAddPhotosViewArguments({this.key});
}

/// PropertyOwnerAddCoverPhotosView arguments holder class
class PropertyOwnerAddCoverPhotosViewArguments {
  final Key? key;
  PropertyOwnerAddCoverPhotosViewArguments({this.key});
}

/// MakePaymentView arguments holder class
class MakePaymentViewArguments {
  final Key? key;
  final double planAmount;
  final String subscriptionCode;
  MakePaymentViewArguments(
      {this.key, required this.planAmount, required this.subscriptionCode});
}

/// DatePickerView arguments holder class
class DatePickerViewArguments {
  final Key? key;
  final Property property;
  DatePickerViewArguments({this.key, required this.property});
}

/// PropertyDetailsView arguments holder class
class PropertyDetailsViewArguments {
  final Key? key;
  final Property? passedProperty;
  final BookedPropertyContent? propertyContent;
  PropertyDetailsViewArguments(
      {this.key, required this.passedProperty, this.propertyContent});
}

/// BookingSubmissionView arguments holder class
class BookingSubmissionViewArguments {
  final Key? key;
  final Property property;
  final DateTime startDate;
  final ChoiceOfPayment choiceOfPayment;
  BookingSubmissionViewArguments(
      {this.key,
      required this.property,
      required this.startDate,
      required this.choiceOfPayment});
}

/// PropertyOwnerProfileView arguments holder class
class PropertyOwnerProfileViewArguments {
  final Key? key;
  final User user;
  final int propertyId;
  PropertyOwnerProfileViewArguments(
      {this.key, required this.user, required this.propertyId});
}

/// ProfileProductListView arguments holder class
class ProfileProductListViewArguments {
  final Key? key;
  final void Function()? onSortByTap;
  ProfileProductListViewArguments({this.key, this.onSortByTap});
}

/// FilterDisplay arguments holder class
class FilterDisplayArguments {
  final Key? key;
  final Filter filter;
  FilterDisplayArguments({this.key, required this.filter});
}

/// PropertyOwnerSpaceTypeView arguments holder class
class PropertyOwnerSpaceTypeViewArguments {
  final Key? key;
  PropertyOwnerSpaceTypeViewArguments({this.key});
}

/// PropertyOwnerPaymentView arguments holder class
class PropertyOwnerPaymentViewArguments {
  final Key? key;
  PropertyOwnerPaymentViewArguments({this.key});
}

/// PropertyOwnerAmenitiesView arguments holder class
class PropertyOwnerAmenitiesViewArguments {
  final Key? key;
  PropertyOwnerAmenitiesViewArguments({this.key});
}

/// TopItemView arguments holder class
class TopItemViewArguments {
  final Key? key;
  final String itemName;
  final bool isStates;
  TopItemViewArguments(
      {this.key, required this.itemName, required this.isStates});
}

/// VerifyUserAccount arguments holder class
class VerifyUserAccountArguments {
  final Key? key;
  final String email;
  VerifyUserAccountArguments({this.key, required this.email});
}

/// SignUpConfirmationView arguments holder class
class SignUpConfirmationViewArguments {
  final Key? key;
  final String email;
  SignUpConfirmationViewArguments({this.key, required this.email});
}
