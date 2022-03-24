import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/profile_product_list/profile_product_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';

class ProfileProductListView extends StatelessWidget {
  const ProfileProductListView({Key? key, this.onSortByTap}) : super(key: key);

  final void Function()? onSortByTap;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileProductListViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Stephen's listings",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              verticalSpaceRegular,
              Row(
                children: [
                  Expanded(
                    child: ResavationElevatedButton(
                      child: Text(
                        'Listings (8)',
                        style: AppStyle.kBodySmallRegular12W500,
                      ),
                      onPressed: model.showComingSoon,
                    ),
                  ),
                  SizedBox(width: 130),
                  Text(
                    "sort by",
                    style: AppStyle.kBodySmallRegular,
                  ),
                  Icon(Icons.keyboard_arrow_down_outlined)
                ],
              ),
              verticalSpaceMedium,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final property in model.properties) ...[
                        GestureDetector(
                          onTap: model.goToPropertyDetails,
                          child: PropertyCard(
                            image: property.image,
                            amountPerYear: property.amountPerYear,
                            location: property.location,
                            address: property.address,
                            numberOfBathrooms: property.numberOfBedrooms,
                            numberOfBedrooms: property.numberOfBathrooms,
                            squareFeet: property.squareFeet,
                            // isFavoriteTap: property.isFavoriteTap,
                            onFavoriteTap: () {},
                          ),
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
        ),
      ),
      viewModelBuilder: () => ProfileProductListViewModel(),
    );
  }
}


