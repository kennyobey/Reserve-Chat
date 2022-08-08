import 'package:flutter/material.dart';
import 'package:resavation/model/filter.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_sort.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';
import 'filter_display_viewmodel.dart';

class FilterDisplay extends StatelessWidget {
  final Filter filter;
  const FilterDisplay({Key? key, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterDisplayViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: buildAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const Divider(),
                verticalSpaceSmall,
                SortProperty2(
                  noOfProperties: model.properties.length,
                ),
                verticalSpaceSmall,
                const Divider(),
                verticalSpaceSmall,
                Expanded(
                  child: buildBody(model, context),
                ),
              ],
            ),
          )),
      viewModelBuilder: () => FilterDisplayViewModel(filter),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Filter",
      backEnabled: true,
      centerTitle: false,
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
          numberOfBedrooms: 0,
          numberOfCars: 0,
          squareFeet: 0.0,
          shimmerEnabled: true,
          isFavoriteTap: false,
          onFavoriteTap: () {},
        );
      },
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      itemCount: 8,
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

  Column buildErrorBody(BuildContext context) {
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

  Widget buildBody(FilterDisplayViewModel model, BuildContext context) {
    final properties = model.properties;
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasErrorOnData) {
      return buildErrorBody(context);
    } else if (properties.isEmpty) {
      return buildEmptyBody(context);
    } else {
      return buildBodyItem(properties, model, context);
    }
  }

  Widget buildBodyItem(List<Property> properties, FilterDisplayViewModel model,
      BuildContext context) {
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
                numberOfBedrooms: property.bedroomCount ?? 0,
                numberOfCars: property.carSlot ?? 0,
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
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            controller: model.scrollController,
            itemCount: properties.length,
          ),
        ),
        if (model.isLoadingOldData) buildOldLoadingWidget(),
      ],
    );
  }

  Column buildEmptyBody(BuildContext context) {
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
          'No property yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly check back later for properties with this filter',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }
}
