import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details_header.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_details/property_details_viewmodel.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

import '../messages/messages_viewmodel.dart';

class PropertyDetailsView extends StatelessWidget {
  final Property? passedProperty;

  const PropertyDetailsView({Key? key, required this.passedProperty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyDetailsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(model, context),
              buildDescription(model, context),
              buildLocation(model),
              verticalSpaceMassive,
              verticalSpaceMassive,
            ],
          ),
        ),
        bottomSheet: buildBottomBar(model, context),
      ),
      viewModelBuilder: () => PropertyDetailsViewModel(passedProperty),
    );
  }

  Widget buildBottomBar(PropertyDetailsViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ResavationElevatedButton(
              child: Text("Book Appointment"),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          horizontalSpaceMedium,
          Expanded(
            child: ResavationElevatedButton(
              child: Text("Pay Now"),
              onPressed: () => model.goToDatePickerView(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildLocation(PropertyDetailsViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          Text(
            'Location',
            style: AppStyle.kBodyRegularBlack15W500,
          ),
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Text(
                      'Address: ${model.property?.address}',
                      style: AppStyle.kBodyRegularBlack15,
                    ),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Text(
                      'State: ${model.property?.state}',
                      style: AppStyle.kBodyRegularBlack15,
                    ),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Text(
                      'City: ${model.property?.city}',
                      style: AppStyle.kBodyRegularBlack15,
                    ),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Text(
                      'Country: ${model.property?.country}',
                      style: AppStyle.kBodyRegularBlack15,
                    ),
                  ),
                ],
              ),
              verticalSpaceTiny,
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  child: Text("Go to Map"),
                  onPressed: () {
                    model.goToMapView();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDescription(
      PropertyDetailsViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          Text(
            model.property?.propertyName ?? '',
            style: AppStyle.kBodyRegularBlack16W600,
          ),
          Text(
            model.property?.address ?? '',
            style: AppStyle.kBodySmallRegular12W300,
          ),
          verticalSpaceSmall,
          PropertyDetails(
            title: model.property?.propertyCategory ?? '',
            numberOfBedrooms: model.property?.bedroomCount ?? 0,
            numberOfBathrooms: model.property?.bathTubCount ?? 0,
            squareFeet: model.property?.surfaceArea ?? 0,
          ),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: CircleAvatar(
                  radius: 25, // Image radius
                  backgroundImage: AssetImage(Assets.profile_image2),
                ),
                onTap: () => model.goToPropertyOwnersProfileView(),
              ),
              horizontalSpaceSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Dummy David Strang",
                    style: AppStyle.kBodyRegularBlack16W600,
                  ),
                  Text(
                    "",
                    style: AppStyle.kBodyRegularBlack14,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Settig up chatroom, please wait')),
                  );
                  final chatModel = await MessagesViewModel.createChat(
                      'otitemitope6@gmail.com',
                      " property?.ownerProfileName ?? ''",
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
                    SnackBar(content: Text('Setting up chatroom, please wait')),
                  );
                  final chatModel = await MessagesViewModel.createChat(
                      'otitemitope6@gmail.com',
                      " property?.ownerProfileName ?? ''",
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
          PropertyDetailItem(
              title: 'Description',
              description: model.property?.description ?? ''),
          PropertyDetailItem(
              title: 'Property type',
              description: model.property?.propertyType ?? ''),
          PropertyDetailItem(
              title: 'Property style',
              description: model.property?.propertyStyle ?? ''),
          PropertyDetailItem(
              title: 'Property status',
              description: model.property?.propertyStatus ?? ''),
          PropertyDetailItem(
              title: 'Space serviced',
              description: model.property?.isSpaceServiced ?? ''),
          PropertyDetailItem(
              title: 'Space furnished',
              description: model.property?.isSpaceFurnished ?? ''),
          PropertyDetailItem(
              title: 'Owner lives in space',
              description: model.property?.isLiveInSPace ?? ''),
          PropertyDetailItem(
              title: 'Service type',
              description: model.property?.serviceType ?? ''),
          PropertyDetailItem(
              title: 'Property category',
              description: model.property?.propertyCategory ?? ''),
          PropertyDetailItem2(
              title: 'Property amenities',
              items: model.property?.amenities
                      ?.map((e) => e.amenity ?? '')
                      .toList() ??
                  []),
          PropertyDetailItem2(
              title: 'Property rules',
              items: model.property?.propertyRule
                      ?.map((e) => e.rule ?? '')
                      .toList() ??
                  []),
          PropertyDetailItem3(property: model.property),
        ],
      ),
    );
  }

  Widget buildHeader(PropertyDetailsViewModel model, BuildContext context) {
    return PropertyDetailsHeader(
      onBackTap: model.navigateBack,
      propertyImages: model.property?.propertyImages ?? [],
      isFavoriteTap: model.property?.favourite ?? false,
      onFavoriteTap: () async {
        try {
          await model.onFavouriteTap();
        } catch (exception) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(exception.toString())));
        }
      },
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

class PropertyDetailItem extends StatelessWidget {
  final String title;
  final String description;

  const PropertyDetailItem(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaceSmall,
        Text(
          title,
          style: AppStyle.kBodyRegularBlack15W500,
        ),
        verticalSpaceTiny,
        Text(description, style: AppStyle.kBodySmallRegular12),
      ],
    );
  }
}

class PropertyDetailItem2 extends StatelessWidget {
  final String title;
  final List<String> items;

  const PropertyDetailItem2(
      {Key? key, required this.title, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaceSmall,
        Text(
          title,
          style: AppStyle.kBodyRegularBlack15W500,
        ),
        verticalSpaceTiny,
        ...items.map((element) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text('- $element', style: AppStyle.kBodySmallRegular12),
          );
        }).toList(),
      ],
    );
  }
}

class PropertyDetailItem3 extends StatelessWidget {
  final Property? property;

  const PropertyDetailItem3({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaceSmall,
        Text(
          'Payment Options',
          style: AppStyle.kBodyRegularBlack15W500,
        ),
        verticalSpaceTiny,
        if ((property?.subscription?.monthlyPrice ?? 0) > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Plan:',
                  style: AppStyle.kBodySmallRegular12,
                ),
                Text(
                    '${String.fromCharCode(8358)} ${oCcy.format(property?.subscription?.monthlyPrice ?? 0)}',
                    style: AppStyle.kBodySmallRegular12),
              ],
            ),
          ),
        if ((property?.subscription?.quarterlyPrice ?? 0) > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quartely Plan:', style: AppStyle.kBodySmallRegular12),
                Text(
                    '${String.fromCharCode(8358)} ${oCcy.format(property?.subscription?.quarterlyPrice ?? 0)}',
                    style: AppStyle.kBodySmallRegular12),
              ],
            ),
          ),
        if ((property?.subscription?.biannualPrice ?? 0) > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Biannual Plan:', style: AppStyle.kBodySmallRegular12),
                Text(
                    '${String.fromCharCode(8358)} ${oCcy.format(property?.subscription?.biannualPrice ?? 0)}',
                    style: AppStyle.kBodySmallRegular12),
              ],
            ),
          ),
        if ((property?.subscription?.annualPrice ?? 0) > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Annual Plan:', style: AppStyle.kBodySmallRegular12),
                Text(
                    '${String.fromCharCode(8358)} ${oCcy.format(property?.subscription?.annualPrice ?? 0)}',
                    style: AppStyle.kBodySmallRegular12),
              ],
            ),
          ),
      ],
    );
  }
}
