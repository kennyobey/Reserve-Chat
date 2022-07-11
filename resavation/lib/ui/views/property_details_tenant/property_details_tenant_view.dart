import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/model/owner_booked_property/content.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/tenant_booked_property/content.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details_header.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import 'package:stacked/stacked.dart';

import 'property_details_tenant_viewmodel.dart';

class PropertyDetailsTenantView extends StatelessWidget {
  final Property? passedProperty;
  final TenantBookedPropertyContent? tenantPropertyContent;

  const PropertyDetailsTenantView({
    Key? key,
    required this.passedProperty,
    this.tenantPropertyContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyDetailsTenantViewModel>.reactive(
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
      viewModelBuilder: () => PropertyDetailsTenantViewModel(passedProperty),
    );
  }

  Widget buildBottomBar(
      PropertyDetailsTenantViewModel model, BuildContext context) {
    if (tenantPropertyContent == null) {
      //tenant is seeing either book appointment or book property
      return buildTenantBookedBottomBar(model);
    } else if (tenantPropertyContent?.status == true) {
      // tenant is seeing the payment screen
      return buildPaymentBottomBar(model, context);
    } else {
      // none of the above category.
      return const SizedBox(
        height: 0,
        width: double.infinity,
      );
    }
  }

  Padding buildTenantBookedBottomBar(PropertyDetailsTenantViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ResavationElevatedButton(
              child: Text("Book Appointment"),
              onPressed: () => model.goToBookAppointmentPage(),
            ),
          ),
          horizontalSpaceMedium,
          Expanded(
            child: ResavationElevatedButton(
              child: Text("Book Property"),
              onPressed: () => model.goToDatePickerView(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPaymentBottomBar(
      PropertyDetailsTenantViewModel model, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: ResavationElevatedButton(
        child: Text("Make Payment"),
        onPressed: () {
          showTenantPaymentDialog(model, context);
        },
      ),
    );
  }

  showTenantPaymentDialog(
      PropertyDetailsTenantViewModel model, BuildContext context) async {
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Material(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Payment',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Please note that you would be enrolled in a payment plan and ${tenantPropertyContent?.paymentType} payments of NGN ${tenantPropertyContent?.amount} would be made.\n\nBefore charging, you will always receive a confirmation email that allows you to cancel at any time. ',
              textAlign: TextAlign.start,
              style: AppStyle.kBodyRegularBlack14,
            ),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Proceed',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Cancel',
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );

    final shouldPay = await showGeneralDialog<bool>(
      context: context,
      barrierLabel: "Property Payment",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    if (shouldPay == true) {
      model.goToMakePayment(tenantPropertyContent);
    }
  }

  Widget buildLocation(PropertyDetailsTenantViewModel model) {
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
      PropertyDetailsTenantViewModel model, BuildContext context) {
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
                child: Container(
                  width: 50,
                  height: 50,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ResavationImage(
                      image: passedProperty?.user?.imageUrl ?? ''),
                ),
                onTap: () =>
                    model.goToPropertyOwnersProfileView(passedProperty?.user),
              ),
              horizontalSpaceSmall,
              InkWell(
                onTap: () {
                  model.goToPropertyOwnersProfileView(passedProperty?.user);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (passedProperty?.user?.firstName ?? '') +
                          ' ' +
                          (passedProperty?.user?.lastName ?? ''),
                      style: AppStyle.kBodyRegularBlack16W600,
                    ),
                    Text(
                      'View Profile',
                      style: AppStyle.kBodyRegularBlack14
                          .copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              horizontalSpaceSmall,
              GestureDetector(
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Setting up chatroom, please wait')),
                  );
                  final error = await model.gotToChatRoomView();
                  if (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'You can not create a chat room with your self'),
                      ),
                    );
                  }
                },
                child: Icon(
                  Icons.message_rounded,
                  size: 25,
                  color: kBlack,
                ),
              ),
            ],
          ),
          verticalSpaceMedium,
          _PropertyDetailItem(
              title: 'Description',
              description: model.property?.description ?? ''),
          _PropertyDetailItem(
              title: 'Property type',
              description: model.property?.propertyType ?? ''),
          _PropertyDetailItem(
              title: 'Property style',
              description: model.property?.propertyStyle ?? ''),
          _PropertyDetailItem(
              title: 'Property status',
              description: model.property?.propertyStatus ?? ''),
          _PropertyDetailItem(
              title: 'Space serviced',
              description: model.property?.isSpaceServiced ?? ''),
          _PropertyDetailItem(
              title: 'Space furnished',
              description: model.property?.isSpaceFurnished ?? ''),
          _PropertyDetailItem(
              title: 'Owner lives in space',
              description: model.property?.isLiveInSPace ?? ''),
          _PropertyDetailItem(
              title: 'Service type',
              description: model.property?.serviceType ?? ''),
          _PropertyDetailItem(
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
          _PropertyDetailItem3(property: model.property),
        ],
      ),
    );
  }

  Widget buildHeader(
      PropertyDetailsTenantViewModel model, BuildContext context) {
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

class _PropertyDetailItem extends StatelessWidget {
  final String title;
  final String description;

  const _PropertyDetailItem(
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

class _PropertyDetailItem3 extends StatelessWidget {
  final Property? property;

  const _PropertyDetailItem3({
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
