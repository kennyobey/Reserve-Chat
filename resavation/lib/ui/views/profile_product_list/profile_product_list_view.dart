import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
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
      builder: (context, model, child) {
        var properties = model.properties;
        return Scaffold(
          appBar: ResavationAppBar(
            title: "${model.userData.firstName} listings",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                verticalSpaceTiny,
                const Divider(),
                Row(
                  children: [
                    Text(
                      properties.length.toString(),
                      style: AppStyle.kSubHeading.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      ' Properties',
                      style: AppStyle.kSubHeading,
                    ),
                    Spacer(),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          "sort by",
                          style: AppStyle.kBodySmallRegular,
                        ),
                        items: model.items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: model.selectedValue,
                        onChanged: (value) {
                          model.onSelectedValueChange(value);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(),
                verticalSpaceSmall,
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      final property = properties[index];
                      return PropertyCard(
                        id: property.id ?? -1,
                        onTap: () => model.goToPropertyDetails(property),
                        image: property.imageUrl ?? '',
                        amountPerYear: property.spacePrice,
                        propertyName: property.city ?? '',
                        address: property.address ?? '',
                        numberOfBathrooms: property.bathTubCount ?? 0,
                        numberOfBedrooms: property.bedroomCount ?? 0,
                        squareFeet: property.surfaceArea ?? 0,
                        isFavoriteTap: property.favourite ?? false,
                        onFavoriteTap: () {},
                      );
                    },
                    padding: const EdgeInsets.all(0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: properties.length,
                  ),
                ),
                verticalSpaceMedium,
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileProductListViewModel(),
    );
  }
}
