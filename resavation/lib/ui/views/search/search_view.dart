import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_sort.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
            appBar: ResavationAppBar(
              title: "Search",
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      verticalSpaceMedium,
                      //model.buildSearch(),
                      FindYourLocation(

                        onTap: model.goToFilterView,
                      ),
                      verticalSpaceMedium,
                      SortProperty(
                        noOfProperties: 7,
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
                              onTap: model.goToPropertyDetails,
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