import 'package:flutter/material.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/propety_model/user.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/profile_header.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_profile/property_owner_profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../home/widget/items.dart';

class PropertyOwnerProfileView extends StatefulWidget {
  final User user;

  const PropertyOwnerProfileView({Key? key, required this.user})
      : super(key: key);

  @override
  State<PropertyOwnerProfileView> createState() =>
      _PropertyOwnerProfileViewState();
}

class _PropertyOwnerProfileViewState extends State<PropertyOwnerProfileView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerProfileViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(
                  onBackTap: () => model.navigateBack(),
                  user: widget.user,
                  onChatPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Setting up chatroom, please wait')),
                    );
                    try {
                      await model.gotToChatRoomView(widget.user);
                    } catch (exception) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            exception.toString(),
                          ),
                        ),
                      );
                    }
                  },
                ),
                verticalSpaceTiny,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const Divider(),
                      verticalSpaceTiny,
                      TitleListTile(
                        onTap: () {
                          model.goToPropertyOwnerProfile2(widget.user);
                        },
                        visibility: model.properties.length >= 5 ? true : false,
                        title: '${model.properties.length} item(s)',
                      ),
                      verticalSpaceTiny,
                      const Divider(),
                      verticalSpaceSmall,
                      buildBody(model),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => PropertyOwnerProfileViewModel(
        user: widget.user,
      ),
    );
  }

  Widget buildLoadingWidget() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return PropertyCard(
          id: -1,
          onTap: () {},
          image: '',
          amountPerYear: 0,
          propertyName: '',
          address: '',
          numberOfBathrooms: 0,
          numberOfCars: 0,
          numberOfBedrooms: 0,
          squareFeet: 0.0,
          isFavoriteTap: false,
          shimmerEnabled: true,
          onFavoriteTap: () {},
        );
      },
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
    );
  }

  Widget buildErrorBody() {
    var textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'Error occurred!',
            style: bodyText1,
          ),
          const SizedBox(
            height: 5,
            width: double.infinity,
          ),
          Text(
            'An error occurred with the data fetch, please try again later',
            textAlign: TextAlign.center,
            style: bodyText2,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget buildBody(PropertyOwnerProfileViewModel model) {
    final properties = model.properties;
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasErrorOnData) {
      return buildErrorBody();
    } else if (properties.isEmpty) {
      return buildEmptyBody();
    } else {
      return buildBodyItem(properties, model);
    }
  }

  Widget buildBodyItem(
      List<Property> properties, PropertyOwnerProfileViewModel model) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final property = properties[index];

        return PropertyCard(
          id: property.id ?? -1,
          onTap: () => model.goToPropertyDetails(property),
          image: property.propertyImages?[0].imageUrl ?? '',
          amountPerYear: property.spacePrice ?? 0,
          propertyName: property.propertyName ?? '',
          address: property.address ?? '',
          numberOfBathrooms: property.bathTubCount ?? 0,
          numberOfCars: property.carSlot ?? 0,
          numberOfBedrooms: property.bedroomCount ?? 0,
          squareFeet: property.surfaceArea ?? 0.0,
          isFavoriteTap: property.favourite ?? false,
          onFavoriteTap: () async {
            try {
              await model.onFavoriteTap(property);
            } catch (exception) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(exception.toString())));
            }
          },
        );
      },
      controller: model.scrollController,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: properties.length,
    );
  }

  Widget buildEmptyBody() {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'No property yet!',
            style: bodyText1,
          ),
          const SizedBox(
            height: 5,
            width: double.infinity,
          ),
          Text(
            'Kindly check back later for the specified property',
            textAlign: TextAlign.center,
            style: bodyText2,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
