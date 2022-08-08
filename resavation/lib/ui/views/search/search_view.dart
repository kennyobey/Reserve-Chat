import 'package:flutter/material.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: buildAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                FindYourLocation(
                  onTap: model.goToFilterView,
                  onFieldSubmitted: model.searchProperty,
                ),
                verticalSpaceSmall,
                const Divider(),
                verticalSpaceTiny,
                Row(
                  children: [
                    Text(
                      model.properties.length.toString(),
                      style: AppStyle.kSubHeading.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      ' Properties',
                      style: AppStyle.kSubHeading,
                    ),
                    Spacer(),
                  ],
                ),
                verticalSpaceTiny,
                const Divider(),
                verticalSpaceSmall,
                Expanded(
                  child: buildBody(model),
                ),
              ],
            ),
          )),
      viewModelBuilder: () => SearchViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Search",
      centerTitle: false,
    );
  }

  Widget buildLoadingWidget() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return PropertyCard(
          id: -1,
          onTap: () {},
          shimmerEnabled: true,
          image: '',
          amountPerYear: 0,
          propertyName: '',
          address: '',
          numberOfBathrooms: 0,
          numberOfCars: 0,
          numberOfBedrooms: 0,
          squareFeet: 0.0,
          isFavoriteTap: false,
          onFavoriteTap: () async {},
        );
      },
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
    );
  }

  Widget buildOldLoadingWidget() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

  Column buildErrorBody() {
    var textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
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
    );
  }

  Widget buildBody(SearchViewModel model) {
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

  Widget buildBodyItem(List<Property> properties, SearchViewModel model) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
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
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(exception.toString())));
                  }
                },
              );
            },
            controller: model.scrollController,
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            itemCount: properties.length,
          ),
        ),
        if (model.isLoadingOldData) buildOldLoadingWidget(),
      ],
    );
  }

  Column buildEmptyBody() {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
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
    );
  }
}
