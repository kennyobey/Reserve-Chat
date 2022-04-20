import 'package:resavation/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomSnackbarService {
  final _snackbarService = locator<SnackbarService>();

  Future<void> showComingSoon() async {
    _snackbarService.showSnackbar(message: 'This Feature is coming soon');
  }

}
