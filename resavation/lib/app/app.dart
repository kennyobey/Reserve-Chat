import 'package:resavation/ui/views/home/home_view.dart';
import 'package:resavation/ui/views/login/login_view.dart';
import 'package:resavation/ui/views/main/main_view.dart';
import 'package:resavation/ui/views/onboarding/onboarding_view.dart';
import 'package:resavation/ui/views/rest_password/reset_password_view.dart';
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
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
)
class AppSetup {}
