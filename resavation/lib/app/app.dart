import 'package:resavation/ui/views/main/main_view.dart';
import 'package:resavation/ui/views/onboarding/onboarding_view.dart';
import 'package:resavation/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    CupertinoRoute(page: MainView),
    CupertinoRoute(page: OnboardingView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
)
class AppSetup {}
