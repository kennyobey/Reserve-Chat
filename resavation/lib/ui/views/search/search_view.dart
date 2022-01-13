import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_sort.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'search',
                    style: AppStyle.kHeading1,
                  ),
                  verticalSpaceMedium,
                  FindYourLocation(),
                  verticalSpaceMedium,
                  SortProperty(
                    noOfProperties: 40,
                    sortByTitle: 'Default Order',
                  ),
                ],
              ),
              verticalSpaceMedium,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final property in model.properties) ...[
                        PropertyCard(
                          image: property.image,
                          amountPerYear: property.amountPerYear,
                          location: property.location,
                          address: property.address,
                          numberOfBathrooms: property.numberOfBedrooms,
                          numberOfBedrooms: property.numberOfBathrooms,
                          squareFeet: property.squareFeet,
                          isFavoriteTap: property.isFavoriteTap,
                          onFavoriteTap: () => model.onFavoriteTap(property),
                        ),
                        verticalSpaceSmall
                      ]
                    ],
                  ),
                ),
              ),
              verticalSpaceMedium,
            ],
          ),
        )),
      ),
      viewModelBuilder: () => SearchViewModel(),
    );
  }
}
