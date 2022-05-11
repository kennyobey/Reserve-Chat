import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details_header.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_details/property_details_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../model/property_model.dart';
import '../messages/messages_viewmodel.dart';

class PropertyDetailsView extends StatelessWidget {
  final Property? property;

  const PropertyDetailsView({Key? key, required this.property})
      : super(key: key);

  get orientation => null;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyDetailsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            buildHeader(model),
            buildDescription(model, context),
            buildAmenity(model),
            buildLocation(model),
          ],
        ),
        bottomSheet: buildBottomBar(model),
      ),
      viewModelBuilder: () => PropertyDetailsViewModel(),
    );
  }

  Container buildBottomBar(PropertyDetailsViewModel model) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.center,
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Starting at", style: AppStyle.kBodySmallRegular12W500),
                Text(
                  '${String.fromCharCode(8358)} ${oCcy.format(property?.amountPerYear ?? 0)}',
                  style: AppStyle.kBodyRegularBlack14.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          ResavationElevatedButton(
            child: Text('Rent Now'),
            onPressed: () => model.goToDatePickerView(property),
          ),
        ],
      ),
    );
  }

  SliverList buildLocation(PropertyDetailsViewModel model) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceSmall,
            Text(
              'Location',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Expanded(
                  child: Text(
                    property?.address ?? '',
                    style: AppStyle.kBodyRegularBlack15,
                  ),
                ),
                verticalSpaceTiny,
                ResavationElevatedButton(
                  child: Text("Go to Map"),
                  onPressed: () {
                    model.goToMapView();
                  },
                ),
              ],
            ),
            verticalSpaceMedium,
            Text(
              'House Rule(s)',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceSmall,
            ...?property?.houseRules
                .map(
                  (rule) => Row(
                    children: [
                      Text(
                        '- $rule',
                        style: AppStyle.kBodySmallRegular12,
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                )
                .toList(),
            verticalSpaceMassive,
          ],
        ),
      ),
    ]));
  }

  SliverGrid buildAmenity(PropertyDetailsViewModel model) {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 0,
      crossAxisSpacing: 4,
      childAspectRatio: 4,
      children: model.amenities
          .map(
            (amenity) => AmenitiesItem(
              iconData: amenity.iconData,
              title: amenity.title,
            ),
          )
          .toList(),
    );
  }

  SliverList buildDescription(
      PropertyDetailsViewModel model, BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceSmall,
                Text(
                  property?.location ?? '',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
                Text(
                  property?.address ?? '',
                  style: AppStyle.kBodySmallRegular12W300,
                ),
                verticalSpaceSmall,
                PropertyDetails(
                  title: property?.category ?? '',
                  numberOfBedrooms: property?.numberOfBedrooms ?? 0,
                  numberOfBathrooms: property?.numberOfBathrooms ?? 0,
                  squareFeet: property?.squareFeet ?? 0,
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: 25, // Image radius
                        backgroundImage:
                            AssetImage(property?.ownerProfileImage ?? ''),
                      ),
                      onTap: () => model.goToPropertyOwnersProfileView(),
                    ),
                    horizontalSpaceSmall,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property?.ownerProfileName ?? '',
                          style: AppStyle.kBodyRegularBlack16W600,
                        ),
                        Text(
                          property?.ownerAgentType ?? '',
                          style: AppStyle.kBodyRegularBlack14,
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Settig up chatroom, please wait')),
                        );
                        final chatModel = await MessagesViewModel.createChat(
                            'otitemitope6@gmail.com',
                            property?.ownerProfileName ?? '',
                            'https://firebasestorage.googleapis.com/v0/b/oh2020-a8512.appspot.com/o/images%2Fothers%2FEXCEEDING%20EXPECTATIONS%20DAY%202%2F49834?alt=media&token=6a9c3239-f222-44d1-ab9f-a87a9a3fd960');
                        model.gotToChatRoomView(chatModel);
                      },
                      child: Icon(
                        Icons.message_rounded,
                        color: Colors.black38,
                        size: 20,
                      ),
                    ),
                    horizontalSpaceSmall,
                    GestureDetector(
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Setting up chatroom, please wait')),
                        );
                        final chatModel = await MessagesViewModel.createChat(
                            'otitemitope6@gmail.com',
                            property?.ownerProfileName ?? '',
                            'https://firebasestorage.googleapis.com/v0/b/oh2020-a8512.appspot.com/o/images%2Fothers%2FEXCEEDING%20EXPECTATIONS%20DAY%202%2F49834?alt=media&token=6a9c3239-f222-44d1-ab9f-a87a9a3fd960');
                        model.gotToChatRoomView(chatModel);
                      },
                      child: Icon(
                        Icons.call,
                        size: 20,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
                verticalSpaceMedium,
                Text(
                  'Description',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
                verticalSpaceSmall,
                Text(property?.description ?? '',
                    style: AppStyle.kBodySmallRegular12),
                verticalSpaceMedium,
                Text(
                  'Amenities',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverPersistentHeader buildHeader(PropertyDetailsViewModel model) {
    return SliverPersistentHeader(
      floating: true,
      delegate: PropertyDetailsHeader(
          onBackTap: model.navigateBack, property: property),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            iconData,
            color: kGray,
          ),
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
