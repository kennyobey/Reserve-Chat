import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details_header.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
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
                          'Eleko Estate ',
                          style: AppStyle.kBodyRegularBlack14,
                        ),
                        Text(
                          '11 Chevron Drive, Lekki',
                          style: AppStyle.kBodySmallRegular12W300,
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
                            InkWell(
                              child: CircleAvatar(
                                radius: 30, // Image radius
                                backgroundImage: AssetImage(Assets.profile_image),
                              ),
                              onTap: ()=> model.goToPropertyOwnersProfileView(),
                            ),
                            horizontalSpaceSmall,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Adeyemo Steven',
                                  style: AppStyle.kBodyRegularBlack14W500,
                                ),
                                Text(
                                  'Listing Agent',
                                  style: AppStyle.kSubHeading,
                                ),
                              ],
                            ),
                            horizontalSpaceSmall,
                            horizontalSpaceMedium,
                            GestureDetector(
                              onTap: model.showComingSoon,
                              child: Icon(
                                Icons.message_rounded,
                                color: Colors.black38,
                              ),
                            ),
                            horizontalSpaceSmall,
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
                          style: AppStyle.kBodyRegularBlack14W500,
                        ),
                        verticalSpaceSmall,
                        Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eu risus quam eros placerat nullam enim rhoncus. Id odio velit nibh risus praesent suscipit ut convallis orci. Hendrerit in nulla non quis magna et at. Non faucibus fermentum pellentesque ipsum nullam faucibus. In consequat suscipit leo amet, diam facilisi facilisis nunc eu. In ultrices mi integer ut mauris eget. Diam adipiscing integer mauris sociis. Ultricies mi, mus nunc, praesent. Hendrerit metus, libero aenean dignissim euismod condimentum porta mus' +
                          'Nunc, amet gravida morbi lacus. Id ullamcorper mauris faucibus malesuada semper sagittis, libero donec egestas. Eget pharetra, in in hendrerit cursus nibh.',
                            style: AppStyle.kBodySmallRegular12W500),
                        verticalSpaceMedium,
                        Text(
                          'Amenities',
                          style: AppStyle.kBodyRegularBlack14W500,
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
              crossAxisSpacing: 4,
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
                      style: AppStyle.kBodyRegularBlack14W500,
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
                          style: AppStyle.kBodySmallRegular12W500,
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    ResavationElevatedButton(
                      child: Text("Go to Map"),
                      onPressed: (){
                        model.goToMapView();
                      },
                    ),
                    verticalSpaceMedium,
                    Text(
                      'House Rules',
                      style: AppStyle.kBodyRegularBlack14W500,
                    ),
                    verticalSpaceSmall,
                    Text(
                      'No Party',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceSmall,
                    Text(
                      'No Pets',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceSmall,
                    Text(
                      'No Smoking',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceRegular,
                    verticalSpaceLarge
                  ],
                ),
              ),
            ])),

          ],
        ),
        bottomSheet: Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Starting at", style: AppStyle.kBodySmallRegular12W500),
                  Text(
                    '₦ 2,326,363',
                    style: AppStyle.kBodyRegularBlack14,
                  )
                ],
              ),
              ResavationElevatedButton(
                child: Text('Rent Now'),
                onPressed: model.goToDatePickerView,
              ),
            ],
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0, ),
      child: Row(
        children: [
          Icon(iconData, color: kGray,),
          horizontalSpaceSmall,
          Text(
            title,
            style: AppStyle.kBodySmallRegular12W500,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
