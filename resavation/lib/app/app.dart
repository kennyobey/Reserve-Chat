import 'package:resavation/ui/views/booking_submission/booking_submission_view.dart';
import 'package:resavation/ui/views/confirmation/confirmation_view.dart';
import 'package:resavation/ui/views/date_picker/date_picker_view.dart';
import 'package:resavation/ui/views/filter/filter_view.dart';
import 'package:resavation/ui/views/login/login_view.dart';
import 'package:resavation/ui/views/main/main_view.dart';
import 'package:resavation/ui/views/map/map_view.dart';
import 'package:resavation/ui/views/onboarding/onboarding_view.dart';
import 'package:resavation/ui/views/payment/payment_view.dart';
import 'package:resavation/ui/views/property_details/property_details_view.dart';
import 'package:resavation/ui/views/property_owner_profile/property_owner_profile_view.dart';
import 'package:resavation/ui/views/property_owner_step1/property_owner_step1_view.dart';
import 'package:resavation/ui/views/property_owner_step2/property_owner_step2_view.dart';
import 'package:resavation/ui/views/property_owner_step2/property_owner_step2_viewmodel.dart';
import 'package:resavation/ui/views/rest_password/reset_password_view.dart';
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
    AdaptiveRoute(page: SignUpView),
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
    AdaptiveRoute(page: PropertyOwnerStep1View),
    AdaptiveRoute(page: PropertyOwnerStep_1_3View),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
)
class AppSetup {}
