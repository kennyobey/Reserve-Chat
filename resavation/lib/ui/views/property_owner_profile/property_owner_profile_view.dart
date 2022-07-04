import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/profile_header.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_profile/property_owner_profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../home/widget/items.dart';

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
              delegate: ProfileHeader(
                onBackTap: () => model.navigateBack(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ademoye Stephen',
                                style: AppStyle.kBodyRegularBlack16W600,
                              ),
                              Text(
                                'Ibadan, Nigeria',
                              ),
                              verticalSpaceTiny,
                              Divider(),
                              verticalSpaceTiny,
                              Text('About',
                                  style: AppStyle.kBodyRegularBlack16W600),
                              verticalSpaceTiny,
                              Text(
                                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)',
                              ),
                              verticalSpaceTiny,
                              Divider(),
                              verticalSpaceTiny,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ResavationButton(
                                      width: double.infinity,
                                      title: 'Message',
                                      icon: Icons.messenger_outline,
                                      onTap: model.goToMessagesView,
                                    ),
                                  ),
                                  horizontalSpaceSmall,
                                  Expanded(
                                    child: ResavationButton(
                                      buttonColor: kGreen,
                                      borderColor: kGreen,
                                      width: double.infinity,
                                      title: 'Call',
                                      icon: Icons.call_outlined,
                                      onTap: () {
                                        model.goToAudioCallView();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpaceTiny,
                              const Divider(),
                              verticalSpaceTiny,
                              TitleListTile(
                                title: "Stephen's Listing",
                                visibility: false,
                              ),
                              verticalSpaceTiny,
                              const Divider(),
                            ],
                          ),
                        ),
                        verticalSpaceTiny,
                        ListView.builder(
                          itemBuilder: (ctx, index) {
                            final property = model.properties[index];
                            return PropertyCard(
                              id: property.id ?? -1,
                              onTap: () => model.goToPropertyDetails(property),
                              image: property.propertyImages?[0].imageUrl ?? '',
                              amountPerYear: 0,
                              propertyName: property.city ?? '',
                              address: property.address ?? '',
                              numberOfBathrooms: property.bathTubCount ?? 0,
                              numberOfBedrooms: property.bedroomCount ?? 0,
                              squareFeet: property.surfaceArea ?? 0,
                              isFavoriteTap: property.favourite ?? false,
                              onFavoriteTap: () {
                                //model.onFavoriteTap(property)
                              },
                            );
                          },
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model.properties.length,
                        )
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
//
//  verticalSpaceRegular,
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24.0,
//                             vertical: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             color: kPrimaryColor,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Row(
//                             children: [
//                               Text(
//                                 'Message',
//                                 style: AppStyle.kBodyRegular.copyWith(color: kWhite),
//                               ),
//                               horizontalSpaceSmall,
//                               Icon(
//                                 Icons.message_rounded,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         ),
