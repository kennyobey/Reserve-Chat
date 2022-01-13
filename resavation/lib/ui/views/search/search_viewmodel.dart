import 'package:resavation/model/property_model.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  void onFavoriteTap(Property property) {
    notifyListeners();
  }

  List<Property> get properties => ListOfProperties;
}
