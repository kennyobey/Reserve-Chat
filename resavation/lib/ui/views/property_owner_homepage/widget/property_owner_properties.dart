import 'package:flutter/material.dart';
import 'package:resavation/model/owner_property/owner_property.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/views/home/widget/items.dart';
import 'package:resavation/ui/views/property_owner_properties/property_owner_properties_view.dart';
import 'package:stacked/stacked.dart';

import '../property_owner_homepageViewModel.dart';

class PropertyOwnerProperties
    extends ViewModelWidget<PropertyOwnerHomePageViewModel> {
  const PropertyOwnerProperties({Key? key}) : super(key: key);

  Column buildErrorBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occured with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Column buildEmptyBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        Text(
          'No properties yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly create a new property by listing your space above',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget buildBody(PropertyOwnerHomePageViewModel model) {
    return FutureBuilder<OwnerPropertyModel>(
      future: model.httpService.getOwnerProperty(page: 0, size: 5),
      builder: ((context, asyncDataSnapshot) {
        if (asyncDataSnapshot.hasError) {
          return buildErrorBody(context);
        }

        if (asyncDataSnapshot.hasData) {
          final List<Property> ownerProperty =
              asyncDataSnapshot.data?.properties ?? [];

          return buildSuccessBody(ownerProperty, model, context);
        } else {
          return buildLoadingWidget();
        }
      }),
    );
  }

  Widget buildLoadingWidget() {
    return Container(
      height: 300,
      width: double.infinity,
      alignment: Alignment.center,
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

  Widget buildSuccessBody(List<Property> allProperties,
      PropertyOwnerHomePageViewModel model, BuildContext context) {
    return allProperties.isEmpty
        ? buildEmptyBody(context)
        : ListView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: allProperties.length,
            itemBuilder: (_, index) {
              final property = allProperties[index];
              return PropertyOwnerPropertiesCard(
                id: property.id ?? -1,
                onTap: () => model.goToPropertyDetails(property),
                image: property.propertyImages?[0].imageUrl ?? '',
                amountPerYear: property.spacePrice ?? 0.0,
                name: property.propertyName ?? '',
                address: property.address ?? '',
                numberOfBathrooms: property.bathTubCount ?? 0,
                numberOfBedrooms: property.bedroomCount ?? 0,
                squareFeet: property.surfaceArea ?? 0,
                isFavoriteTap: property.favourite ?? false,
              );
            },
          );
  }

  @override
  Widget build(BuildContext context, PropertyOwnerHomePageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleListTile(
          onTap: () {
            model.goToPropertyOwnerPropertiesView();
          },
          visibility: true,
          title: 'Your Properties',
        ),
        verticalSpaceSmall,
        buildBody(model),
      ],
    );
  }
}
