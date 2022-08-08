import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/edit_profile_model.dart';
import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';
import '../../../services/core/user_type_service.dart';

class DojahVerificationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _httpService = locator<HttpService>();

  final _userService = locator<UserTypeService>();
  LoginModel get userData => _userService.userData;

  EditProfileModel? userProfile;

  bool hasErrorOnData = false;
  bool userHasNotFilledProfile = false;
  bool isLoading = true;

  void goToMainView() {
    _navigationService.navigateTo(Routes.mainView);
  }

  getProfile() async {
    isLoading = true;
    hasErrorOnData = false;
    notifyListeners();
    try {
      userProfile = await _httpService.getUserProfile();
      final firstName = userProfile?.firstName ?? '';
      final lastName = userProfile?.lastName ?? '';
      final dob = userProfile?.dateOfBirth;
      final country = userProfile?.country ?? '';
      if (firstName.isEmpty ||
          lastName.isEmpty ||
          dob == null ||
          country.isEmpty) {
        userHasNotFilledProfile = true;
      }
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    notifyListeners();
  }

  void editProfileScreen() {
    _navigationService.replaceWith(
      Routes.editProfileView,
      arguments: EditProfileViewArguments(
        userProfile: userProfile,
      ),
    );
  }
}
