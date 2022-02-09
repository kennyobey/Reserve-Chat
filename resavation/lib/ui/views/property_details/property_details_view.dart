import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details_header.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_details/property_details_viewmodel.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class PropertyDetailsView extends StatelessWidget {
  const PropertyDetailsView({Key? key}) : super(key: key);

  get orientation => null;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyDetailsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        // appBar: ResavationAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: PropertyDetailsHeader(
                onBackTap: model.navigateBack,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Eleko Estate',
                          style: AppStyle.kBodyRegular,
                        ),
                        verticalSpaceSmall,
                        PropertyDetails(
                          title: 'Apartment',
                          numberOfBedrooms: 2,
                          numberOfBathrooms: 2,
                          squareFeet: 2040,
                        ),
                        verticalSpaceMedium,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30, // Image radius
                              backgroundImage: AssetImage(Assets.profile_image),
                            ),
                            horizontalSpaceSmall,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Adeyemo Steven',
                                  style: AppStyle.kBodySmallBold,
                                ),
                                Text(
                                  'Listing Agent',
                                  style: AppStyle.kBodyRegular,
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: model.showComingSoon,
                              child: Icon(
                                Icons.message_rounded,
                                color: Colors.black38,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: model.showComingSoon,
                              child: Icon(
                                Icons.call,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Description',
                          style: AppStyle.kBodySmallBold,
                        ),
                        verticalSpaceSmall,
                        Text(
                            'injvjernknljfncfdkjvnlkjrnvl icklemcvekrnmx,cn kjnwxmecnrfkj nw,mcnewnxence,fnk,wnf,c,lern lknmkcrkgm .kgrmklmdktmk.vmxdmre;ltm;lkvm;l injvjernknljfncfdkjvnlkjrnvl icklemcvekrnmx,cn kjnwxmecnrfkj nw,mcnewnxence,fnk,wnf,c,lern lknmkcrkgm .kgrmklmdktmk.vmxdmre;ltm;lkvm;l injvjernknljfncfdkjvnlkjrnvl icklemcvekrnmx,cn kjnwxmecnrfkj nw,mcnewnxence,fnk,wnf,c,lern lknmkcrkgm .kgrmklmdktmk.vmxdmre;ltm;lkvm;l'),
                        verticalSpaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#2,326,363',
                              style: AppStyle.kBodySmallBold,
                            ),
                            ResavationButton(
                              width: 150,
                              title: 'Rent Now',
                              onTap: model.showComingSoon,
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Amenities',
                          style: AppStyle.kBodySmallBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 10,
              childAspectRatio: 4,
              children: [
                for (final amenity in model.amenities) ...[
                  AmenitiesItem(
                    iconData: amenity.iconData,
                    title: amenity.title,
                  ),
                ],
              ],
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceSmall,
                    Text(
                      'Location',
                      style: AppStyle.kBodySmallBold,
                    ),
                    verticalSpaceSmall,
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        Text(
                          '11, Chevron Lekki',
                          style: AppStyle.kBodyRegular,
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    GestureDetector(
                      onTap: model.showComingSoon,
                      child: Image.asset(
                        'assets/images/map_image.png',
                        width: 600.0,
                        height: 240.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    verticalSpaceMedium,
                    Text(
                      'House Rules',
                      style: AppStyle.kBodySmallBold,
                    ),
                    verticalSpaceSmall,
                    Text(
                      'No Party',
                      style: AppStyle.kBodyRegular,
                    ),
                    verticalSpaceSmall,
                    Text(
                      'No Pets',
                      style: AppStyle.kBodyRegular,
                    ),
                    verticalSpaceSmall,
                    Text(
                      'No Smoking',
                      style: AppStyle.kBodyRegular,
                    ),
                  ],
                ),
              ),
            ]))
          ],
        ),
      ),
      viewModelBuilder: () => PropertyDetailsViewModel(),
    );
  }
}

class AmenitiesItem extends StatelessWidget {
  const AmenitiesItem({
    Key? key,
    this.title = '',
    required this.iconData,
  }) : super(key: key);
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Icon(iconData),
          horizontalSpaceSmall,
          Text(
            title,
            style: AppStyle.kBodySmallBold,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
