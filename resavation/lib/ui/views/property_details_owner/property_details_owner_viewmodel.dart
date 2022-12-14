import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/amenities_model.dart';
import 'package:resavation/model/owner_booked_property/content.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/services/core/user_type_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';
import '../messages/messages_viewmodel.dart';

class PropertyDetailsOwnerViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final userService = locator<UserTypeService>();
  int _pagePosition = 0;
  int get pagePosition => _pagePosition;
  Property? property;

  PropertyDetailsOwnerViewModel(Property? property) {
    this.property = property;
    notifyListeners();
  }

  Property getProperty() {
    return _navigationService.currentArguments;
  }

  void onPageChanged(int index) {
    _pagePosition = index;
    notifyListeners();
  }

  // List<Property> get properties => listOfProperties;
  List<Property> get properties => [];
  List<Amenity> get amenities => ListOfAmenities;

  void navigateBack() {
    _navigationService.back();
  }

  // Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }

  acceptTenantRequest(OwnerBookedPropertyContent propertyContent) async {
    try {
      await httpService.acceptDeclineTeantRequest(
        true,
        propertyContent.id ?? -1,
      );
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  declineTenantRequest(OwnerBookedPropertyContent propertyContent) async {
    try {
      await httpService.acceptDeclineTeantRequest(
        false,
        propertyContent.id ?? -1,
      );
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  void goToEditProperty(Property property) {
    _navigationService.navigateTo(
      Routes.propertyOwnerEditPropertyView,
      arguments: PropertyOwnerEditPropertyViewArguments(
        property: property,
      ),
    );
  }

  Future<void> gotToChatRoomView(
      OwnerBookedPropertyContent? ownerPropertyContent) async {
    try {
      if (ownerPropertyContent?.user?.email == null ||
          ownerPropertyContent!.user!.email!.isEmpty) {
        return Future.error('An error occurred fetching the user details');
      } else if (userService.userData.email ==
          (ownerPropertyContent.user?.email ?? '')) {
        return Future.error('You can not create a chat room with your self');
      } else {
        final chatModel = await MessagesViewModel.createChat(
          ownerPropertyContent.user?.email?.trim() ?? '-',
          (ownerPropertyContent.user?.firstName?.trim() ?? '') +
              ' ' +
              (ownerPropertyContent.user?.lastName?.trim() ?? ''),
          ownerPropertyContent.user?.imageUrl?.trim() ?? '',
        );
        _navigationService.navigateTo(Routes.chatRoomView,
            arguments: ChatRoomViewArguments(chatModel: chatModel));
        return;
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
