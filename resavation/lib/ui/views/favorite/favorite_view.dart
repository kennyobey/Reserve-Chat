import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/favorite_card.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/views/favorite/favorite_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteViewModel>.reactive(
      builder: (context, model, child) {
        var properties = model.properties;
        return Scaffold(
          appBar: ResavationAppBar(
            title: "Favorite",
            centerTitle: false,
          ),
          body: ListView.builder(
            itemBuilder: (ctx, index) {
              final property = properties[index];
              return FavoriteCard(
                id: property.id,
                onTap: () => model.goToPropertyDetails(property),
                image: property.image,
                amountPerYear: property.amountPerYear,
                location: property.location,
                address: property.address,
                numberOfBathrooms: property.numberOfBedrooms,
                numberOfBedrooms: property.numberOfBathrooms,
                squareFeet: property.squareFeet,
                isFavoriteTap: property.isFavoriteTap,
                category: property.category,
              );
            },
            itemCount: properties.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
          ),
        );
      },
      viewModelBuilder: () => FavoriteViewModel(),
    );
  }
}
