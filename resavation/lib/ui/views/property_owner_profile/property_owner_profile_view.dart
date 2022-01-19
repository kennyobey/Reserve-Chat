import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/profile_header.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/home/home_view.dart';
import 'package:resavation/ui/views/property_owner_profile/property_owner_profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PropertyOwnerProfileView extends StatelessWidget {
  const PropertyOwnerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: ProfileHeader(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ademoye Stephen',
                          style: AppStyle.kBodyBold,
                        ),
                        Text('Ibadan, Nigeria'),
                        verticalSpaceSmall,
                        Divider(),
                        verticalSpaceSmall,
                        Text(
                            'injvjernknljfncfdkjvnlkjrnvl icklemcvekrnmx,cn kjnwxmecnrfkj nw,mcnewnxence,fnk,wnf,c,lern lknmkcrkgm .kgrmklmdktmk.vmxdmre;ltm;lkvm;l'),
                        Divider(),
                        verticalSpaceRegular,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ResavationButton(
                              width: 150,
                              title: 'Message',
                              onTap: () {},
                            ),
                            ResavationButton(
                              buttonColor: kGreen,
                              width: 150,
                              title: 'Call',
                              onTap: () {},
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        TitleListTile(
                          title: 'Property Listing',
                          onTap: model.goToProfileProductListView,
                        ),
                        verticalSpaceMedium,
                        ...model.properties
                            .map(
                              (property) {
                                return Column(
                                  children: [
                                    PropertyCard(
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
                                    verticalSpaceSmall
                                  ],
                                );
                              },
                            )
                            .toList()
                            .take(2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => PropertyOwnerProfileViewModel(),
    );
  }
}
