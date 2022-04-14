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
import 'package:stacked_services/stacked_services.dart';

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ademoye Stephen',
                          style: AppStyle.kBodyBold,
                        ),
                        Text('Ibadan, Nigeria'),
                        Divider(),
                        Text('About', style: AppStyle.kSubHeadingW600),
                        verticalSpaceTiny,
                        Text(
                            'injvjernknljfncfdkjvnlkjrnvl icklemcvekrnmx,cn kjnwxmecnrfkj nw,mcnewnxence,fnk,wnf,c,lern lknmkcrkgm .kgrmklmdktmk.vmxdmre;ltm;lkvm;l'),
                        Divider(),
                        verticalSpaceRegular,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ResavationButton(
                                width: 92,
                                title: 'Message',
                                icon: Icons.messenger_outline,
                                onTap: model.goToMessagesView,
                              ),
                            ),
                            horizontalSpaceMedium,
                            Expanded(
                              child: ResavationButton(
                                buttonColor: kGreen,
                                borderColor: kGreen,
                                width: 56,
                                title: 'Call',
                                icon: Icons.call_outlined,
                                onTap: () {
                                  model.goToAudioCallView();
                                },
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        TitleListTile(
                          title: "Stephen's Listing",
                          visibility: false,
                          onTap: model.goToPropertyDetails,
                        ),
                        verticalSpaceMedium,
                        ...model.properties
                            .map(
                              (property) {
                                return Column(
                                  children: [
                                    PropertyCard(
                                      onTap: model.goToPropertyDetails,
                                      image: property.image,
                                      amountPerYear: property.amountPerYear,
                                      location: property.location,
                                      address: property.address,
                                      numberOfBathrooms:
                                          property.numberOfBedrooms,
                                      numberOfBedrooms:
                                          property.numberOfBathrooms,
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