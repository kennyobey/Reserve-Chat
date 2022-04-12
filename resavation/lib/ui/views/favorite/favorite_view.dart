import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/favorite_card.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/favorite/favorite_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: ResavationAppBar(
          title: "Favorite",
        ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [

                verticalSpaceMedium,
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [

                        for (final property in model.properties) ...[
                          FavoriteCard(
                            id: property.id!,
                            onTap: model.goToPropertyDetails,
                            image: property.image,
                            amountPerYear: property.amountPerYear,
                            location: property.location,
                            address: property.address,
                            numberOfBathrooms: property.numberOfBedrooms,
                            numberOfBedrooms: property.numberOfBathrooms,
                            squareFeet: property.squareFeet,
                            isFavoriteTap: property.isFavoriteTap,
                            category: property.category,
                          ),
                          verticalSpaceSmall,
                        ]
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => FavoriteViewModel(),
    );
  }
}
