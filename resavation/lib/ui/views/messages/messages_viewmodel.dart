import 'package:resavation/app/app.locator.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';

class MessagesViewModel extends BaseViewModel {
  final _snackbarService = locator<CustomSnackbarService>();

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }
}
