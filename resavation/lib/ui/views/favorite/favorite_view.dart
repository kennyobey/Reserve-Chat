import 'package:flutter/material.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/ui/shared/dump_widgets/favorite_card.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/views/favorite/favorite_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: buildAppBar(),
          body: buildBody(model, context),
        );
      },
      viewModelBuilder: () => FavoriteViewModel(),
    );
  }

  Center buildLoadingWidget() {
    return const Center(
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
          'No favourite(s) yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly check back later for your favourite(s)',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
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

  Widget buildBody(FavoriteViewModel model, BuildContext context) {
    final properties = model.properties;
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasError) {
      return buildErrorBody(context);
    } else if (properties.isEmpty) {
      return buildEmptyBody(context);
    } else {
      return buildBodyItem(properties, model);
    }
  }

  ListView buildBodyItem(List<Property> properties, FavoriteViewModel model) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final property = properties[index];
        return FavoriteCard(
          id: property.id ?? -1,
          onTap: () => model.goToPropertyDetails(property),
          image: property.imageUrl ?? '',
          amountPerYear: property.spacePrice ?? 0,
          location: property.city ?? '',
          address: property.address ?? '',
          numberOfBathrooms: property.bathTubCount ?? 0,
          numberOfBedrooms: property.bedroomCount ?? 0,
          squareFeet: property.surfaceArea ?? 0.0,
          isFavoriteTap: property.favourite ?? false,
        );
      },
      itemCount: properties.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(0),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Favorite",
      centerTitle: false,
    );
  }
}
