import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/propety_model/user.dart';
import 'package:resavation/model/search_model/search_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:resavation/ui/views/messages/messages_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final userService = locator<UserTypeService>();
  bool isLoading = false;
  bool hasErrorOnData = false;
  int page = 0;
  int size = 5;

  final ScrollController scrollController = ScrollController();
  final httpService = locator<HttpService>();
  List<SearchModel> propertySearches = [];

  List<Property> get properties {
    final List<Property> allProperty = [];

    propertySearches.forEach((element) {
      allProperty.addAll(element.properties ?? []);
    });

    return allProperty;
  }

  PropertyOwnerProfileViewModel({
    required User user,
  }) {
    getInitData(user);
  }

  void getInitData(User user) async {
    page = 0;
    propertySearches.clear();
    isLoading = true;
    hasErrorOnData = false;

    notifyListeners();

    try {
      final propertySearch = await httpService.getLandOwnerListings(
          userId: user.id ?? -1, page: page, size: size);

      propertySearches.add(propertySearch);

      hasErrorOnData = false;
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    notifyListeners();
  }

  onFavoriteTap(Property selectedProperty) async {
    try {
      if (selectedProperty.id == null || selectedProperty.favourite == null) {
        return;
      }
      int propertySearchIndex = -1;
      int propertyIndex = -1;

      propertySearches.forEach((propertySearch) {
        propertySearch.properties?.forEach((property) {
          if (property.id == selectedProperty.id) {
            propertySearchIndex = propertySearches.indexOf(propertySearch);
            propertyIndex = propertySearch.properties!.indexOf(property);
          }
        });
      });

      if (propertySearchIndex != -1 && propertyIndex != -1) {
        propertySearches[propertySearchIndex]
            .properties?[propertyIndex]
            .favourite = !(selectedProperty.favourite!);
      }
      notifyListeners();

      /// toggling the property
      await httpService.togglePropertyAsFavourite(
          propertyId: selectedProperty.id ?? -1);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  void goToPropertyDetails(Property property) {
    _navigationService.navigateTo(
      Routes.propertyDetailsTenantView,
      arguments: PropertyDetailsTenantViewArguments(passedProperty: property),
    );
  }

  void goToPropertyOwnerProfile2(User user) {
    _navigationService.navigateTo(
      Routes.propertyOwnerProfileView2,
      arguments: PropertyOwnerProfileView2Arguments(user: user),
    );
  }

  Future<void> gotToChatRoomView(User user) async {
    try {
      if (userService.userData.email == (user.email ?? '')) {
        return Future.error('You can not create a chat room with your self');
      } else {
        final chatModel = await MessagesViewModel.createChat(
          user.email?.trim() ?? '-',
          (user.firstName?.trim() ?? '') + ' ' + (user.lastName?.trim() ?? ''),
          user.imageUrl?.trim() ?? '',
        );
        _navigationService.navigateTo(Routes.chatRoomView,
            arguments: ChatRoomViewArguments(chatModel: chatModel));
        return;
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  void navigateBack() {
    _navigationService.back();
  }
}
