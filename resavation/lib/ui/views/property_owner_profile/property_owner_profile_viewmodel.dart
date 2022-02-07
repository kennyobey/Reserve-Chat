import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<Property> get properties => ListOfProperties;

  void goToProfileProductListView() {
    //_navigationService.navigateTo(Routes.profileProductListView);
  }
}
