import 'package:flutter_svg/flutter_svg.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/utility/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  int _pagePosition = 0;
  int get pagePosition => _pagePosition;

  void onPageChanged(int index) {
    _pagePosition = index;
    notifyListeners();
  }

  void setOnboardingVisibility() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_visibility', false);
  }

  void goToMainView() {
    _navigationService.navigateTo(Routes.mainView);
  }

  void goToSignInView() {
    setOnboardingVisibility();
    _navigationService.navigateTo(Routes.logInView);
  }

  Future<void> loadSvgs() async {
    await Future.wait([
      precachePicture(
          ExactAssetPicture(
              SvgPicture.svgStringDecoderBuilder, Assets.onboarding1),
          null),
      precachePicture(
          ExactAssetPicture(
              SvgPicture.svgStringDecoderBuilder, Assets.onboarding2),
          null),
      precachePicture(
          ExactAssetPicture(
              SvgPicture.svgStringDecoderBuilder, Assets.onboarding3),
          null),
    ]);
  }
}
