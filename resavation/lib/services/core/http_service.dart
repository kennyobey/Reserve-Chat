import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/registration_model.dart';
import 'package:stacked_services/stacked_services.dart';

class HttpService {
  final _snackbarService = locator<SnackbarService>();

  late RegistrationModel registration;

}
