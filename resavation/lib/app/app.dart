import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/ui/views/booking_submission/booking_submission_view.dart';
import 'package:resavation/ui/views/confirmation/confirmation_view.dart';
import 'package:resavation/ui/views/date_picker/date_picker_view.dart';
import 'package:resavation/ui/views/edit_profile/edit_profile_view.dart';
import 'package:resavation/ui/views/filter/filter_view.dart';
import 'package:resavation/ui/views/login/login_view.dart';
import 'package:resavation/ui/views/main/main_view.dart';
import 'package:resavation/ui/views/map/map_view.dart';
import 'package:resavation/ui/views/messages/messages_view.dart';
import 'package:resavation/ui/views/onboarding/onboarding_view.dart';
import 'package:resavation/ui/views/payment/payment_view.dart';
import 'package:resavation/ui/views/profile_product_list/profile_product_list_view.dart';
import 'package:resavation/ui/views/property_details/property_details_view.dart';
import 'package:resavation/ui/views/property_owner_amenities/property_owner_amenities_view.dart';
import 'package:resavation/ui/views/property_owner_details/property_owner_details_view.dart';
import 'package:resavation/ui/views/property_owner_identification/property_owner_identificationView.dart';
import 'package:resavation/ui/views/property_owner_payment/property_owner_payment_view.dart';
import 'package:resavation/ui/views/property_owner_profile/property_owner_profile_view.dart';
import 'package:resavation/ui/views/property_owner_settings/property_owner_settingsView.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_view.dart';
import 'package:resavation/ui/views/property_owner_verification/property_owner_verificationView.dart';
import 'package:resavation/ui/views/rest_password/reset_password_view.dart';
import 'package:resavation/ui/views/search/search_view.dart';
import 'package:resavation/ui/views/settings/settings_view.dart';
import 'package:resavation/ui/views/signup/signup_view.dart';
import 'package:resavation/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    AdaptiveRoute(page: StartupView, initial: true),
    AdaptiveRoute(page: MainView),
    AdaptiveRoute(page: OnboardingView),
    AdaptiveRoute(page: SignUpView, ),
    AdaptiveRoute(page: LogInView),
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

    AdaptiveRoute(page: PropertyOwnerSpacetypeView),
    AdaptiveRoute(page: PropertyOwnerDetailsView),
    AdaptiveRoute(page: PropertyOwnerPaymentView),
    AdaptiveRoute(page: PropertyOwnerAmenitiesView),
    AdaptiveRoute(page: PropertyOwnerVerificationView),
    AdaptiveRoute(page: PropertyOwnerSettingsView),

  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: HttpService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: CustomSnackbarService),
  ],
  logger: StackedLogger(),
)
class AppSetup {}
