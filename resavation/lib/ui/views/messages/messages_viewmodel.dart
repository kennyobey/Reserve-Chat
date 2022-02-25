import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MessagesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<CustomSnackbarService>();

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToChatRoomView() {
    _navigationService.navigateTo(Routes.chatRoomView);
  }
}
