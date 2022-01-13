import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/favorite_card.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_sort.dart';
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Favorite',
                      style: AppStyle.kHeading1,
                    ),
                    verticalSpaceMedium,
                    SortProperty(
                      noOfProperties: 30,
                      sortByTitle: 'Date',
                    ),
                  ],
                ),
                verticalSpaceMedium,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final property in model.properties) ...[
                          FavoriteCard(
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
