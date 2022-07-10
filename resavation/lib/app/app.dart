import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:resavation/services/core/dojah_verification.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:resavation/services/core/upload_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:resavation/ui/views/appointment_booking/appointment_booking.dart';
import 'package:resavation/ui/views/appointment_list/appointment_list_view.dart';
import 'package:resavation/ui/views/audio_call/audio_call_view.dart';
import 'package:resavation/ui/views/booked_appointment_list/bool_property_list_view.dart';
import 'package:resavation/ui/views/booking_submission/booking_submission_view.dart';
import 'package:resavation/ui/views/categories_list/categories_list_view.dart';
import 'package:resavation/ui/views/chat_room/chat_room_view.dart';
import 'package:resavation/ui/views/co_working_space_about/co_working_space_aboutView.dart';
import 'package:resavation/ui/views/confirmation/confirmation_view.dart';
import 'package:resavation/ui/views/date_picker/date_picker_view.dart';
import 'package:resavation/ui/views/edit_profile/edit_profile_view.dart';
import 'package:resavation/ui/views/filter/filter_view.dart';
import 'package:resavation/ui/views/filter_display/filter_display.dart';
import 'package:resavation/ui/views/login/login_view.dart';
import 'package:resavation/ui/views/main/main_view.dart';
import 'package:resavation/ui/views/make_payment/make_payment_view.dart';
import 'package:resavation/ui/views/map/map_view.dart';
import 'package:resavation/ui/views/messages/messages_view.dart';
import 'package:resavation/ui/views/onboarding/onboarding_view.dart';
import 'package:resavation/ui/views/payment/payment_view.dart';
import 'package:resavation/ui/views/profile_product_list/profile_product_list_view.dart';
import 'package:resavation/ui/views/property_details/property_details_view.dart';
import 'package:resavation/ui/views/property_owner_add_cover_photo/property_owner_add_cover_photoView.dart';
import 'package:resavation/ui/views/property_owner_add_photos/property_owner_add_photosView.dart';
import 'package:resavation/ui/views/property_owner_amenities/property_owner_amenities_view.dart';
import 'package:resavation/ui/views/property_owner_analyticpage/property_owner_analyticView.dart';
import 'package:resavation/ui/views/property_owner_datepicker/property_owner_datepickerView.dart';
import 'package:resavation/ui/views/property_owner_details/property_owner_details_view.dart';
import 'package:resavation/ui/views/property_owner_edit_profile/property_owner_edit_profileView.dart';
import 'package:resavation/ui/views/property_owner_homepage/property_owner_homepageView.dart';
import 'package:resavation/ui/views/property_owner_identification/property_owner_identificationView.dart';
import 'package:resavation/ui/views/property_owner_identification_verification/property_owner_identification_verificationView.dart';
import 'package:resavation/ui/views/property_owner_my_properties/property_owner_my_propertiesView.dart';
import 'package:resavation/ui/views/property_owner_payment/property_owner_payment_view.dart';
import 'package:resavation/ui/views/property_owner_profile/property_owner_profile_view.dart';
import 'package:resavation/ui/views/property_owner_properties/property_owner_properties_view.dart';
import 'package:resavation/ui/views/property_owner_settings/property_owner_settingsView.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_view.dart';
import 'package:resavation/ui/views/property_owner_tracklist/property_owner_tracklisView.dart';
import 'package:resavation/ui/views/property_owner_verification/property_owner_verificationView.dart';
import 'package:resavation/ui/views/property_verification/property_verificationView.dart';
import 'package:resavation/ui/views/rest_password/reset_password_view.dart';
import 'package:resavation/ui/views/search/search_view.dart';
import 'package:resavation/ui/views/settings/settings_view.dart';
import 'package:resavation/ui/views/sign_up_confirmation/signup_confirmation_view.dart';
import 'package:resavation/ui/views/signup/signup_view.dart';
import 'package:resavation/ui/views/startup/startup_view.dart';
import 'package:resavation/ui/views/top_items/top_item_view.dart';
import 'package:resavation/ui/views/user_profile/user_profile_view.dart';
import 'package:resavation/ui/views/user_profile_page/user_profile_pageView.dart';
import 'package:resavation/ui/views/verify_user_account/verify_user_account.dart';
import 'package:resavation/ui/views/video_call/video_call_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/views/states_list/states_list_view.dart';

@StackedApp(
  routes: [
    AdaptiveRoute(page: StartupView, initial: true),
    AdaptiveRoute(page: MainView),
    AdaptiveRoute(page: AppointmentBookingPage),
    AdaptiveRoute(page: CoWorkingSpaceAboutView),
    AdaptiveRoute(page: AppointmentListView),
    AdaptiveRoute(page: OnboardingView),
    AdaptiveRoute(
      page: SignUpView,
    ),
    AdaptiveRoute(page: LogInView),
    //
    AdaptiveRoute(page: ChatRoomView),
    AdaptiveRoute(page: PropertyOwnerIdentificationVerificationView),
    AdaptiveRoute(page: PropertyOwnerHomePageView),
    AdaptiveRoute(page: AudioCallView),
    AdaptiveRoute(page: PropertyOwnerEditProfileView),
    AdaptiveRoute(page: PropertyOwnerDatePickerView),
    AdaptiveRoute(page: PropertyOwnerAnalyticView),
    AdaptiveRoute(page: PropertyVerificationView),
    AdaptiveRoute(page: PropertyOwnerAddPhotosView),
    AdaptiveRoute(page: PropertyOwnerAddCoverPhotosView),
    AdaptiveRoute(page: BookedPropertyListView),
    AdaptiveRoute(page: VideoCallView),
    AdaptiveRoute(page: MakePaymentView),
    AdaptiveRoute(page: UserProfileView),
    AdaptiveRoute(page: VerificationPage),
    AdaptiveRoute(page: UserProfilePageView),
    AdaptiveRoute(page: PropertyOwnerPropertiesView),

    ///
    AdaptiveRoute(page: ResetPasswordView),
    AdaptiveRoute(page: FilterView),
    AdaptiveRoute(page: DatePickerView),
    AdaptiveRoute(page: PropertyDetailsView),
    AdaptiveRoute(page: BookingSubmissionView),
    AdaptiveRoute(page: SettingsView),
    AdaptiveRoute(page: MapView),
    AdaptiveRoute(page: PaymentView),
    AdaptiveRoute(page: PropertyOwnerProfileView),
    AdaptiveRoute(page: ConfirmationView),
    AdaptiveRoute(page: ProfileProductListView),
    AdaptiveRoute(page: SearchView),
    AdaptiveRoute(page: EditProfileView),
    AdaptiveRoute(page: MessagesView),
    AdaptiveRoute(page: FilterDisplay),
    AdaptiveRoute(page: PropertyOwnerSpaceTypeView),
    AdaptiveRoute(page: PropertyOwnerDetailsView),
    AdaptiveRoute(page: PropertyOwnerPaymentView),
    AdaptiveRoute(page: PropertyOwnerAmenitiesView),
    AdaptiveRoute(page: PropertyOwnerIdentificationView),
    AdaptiveRoute(page: PropertyOwnerVerificationView),
    AdaptiveRoute(page: TopItemView),
    AdaptiveRoute(page: PropertyOwnerSettingsView),
    AdaptiveRoute(page: VerifyUserAccount),
    AdaptiveRoute(page: SignUpConfirmationView),
    AdaptiveRoute(page: PropertyOwnerMyPropertyView),
    AdaptiveRoute(page: PropertyOwnerTrackListView),
    AdaptiveRoute(page: CategoriesListView),
    AdaptiveRoute(page: StatesListView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: HttpService),
    LazySingleton(classType: UploadService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: CustomSnackbarService),
    LazySingleton(classType: UserTypeService),
    LazySingleton(classType: ImagePickerService),
  ],
  logger: StackedLogger(),
)
class AppSetup {}
