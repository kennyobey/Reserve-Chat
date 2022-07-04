import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> goToOnboardingView() async {
    await Future.delayed(Duration(seconds: 2));
    await _navigationService.replaceWith(Routes.onboardingView);
  }
}
