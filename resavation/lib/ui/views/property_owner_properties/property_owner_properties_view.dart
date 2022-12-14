import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:intl/intl.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:shimmer/shimmer.dart';
import '../../shared/text_styles.dart';
import 'property_owner_properties_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';

class PropertyOwnerPropertiesView extends StatefulWidget {
  const PropertyOwnerPropertiesView({
    Key? key,
  }) : super(key: key);

  @override
  State<PropertyOwnerPropertiesView> createState() =>
      _PropertyOwnerPropertiesViewState();
}

class _PropertyOwnerPropertiesViewState
    extends State<PropertyOwnerPropertiesView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerPropertiesViewModel>.reactive(
      builder: (context, model, child) => FocusDetector(
        onFocusGained: () {
          model.getInitData();
        },
        child: Scaffold(
          appBar: buildAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const Divider(),
                verticalSpaceTiny,
                Row(
                  children: [
                    Text(
                      model.properties.length.toString(),
                      style: AppStyle.kSubHeading.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      '  Properties',
                      style: AppStyle.kSubHeading,
                    ),
                    Spacer(),
                  ],
                ),
                verticalSpaceTiny,
                const Divider(),
                verticalSpaceSmall,
                Expanded(
                  child: buildBody(model),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerPropertiesViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: 'Your Properties',
      backEnabled: true,
      centerTitle: false,
    );
  }

  Widget buildLoadingWidget() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return PropertyOwnerPropertiesCard(
          id: -1,
          verified: true,
          onTap: () {},
          image: '',
          amountPerYear: 0.0,
          shimmerEnabled: true,
          name: '',
          address: '',
          numberOfBathrooms: 0,
          numberOfBedrooms: 0,
          numberOfCars: 0,
          squareFeet: 0,
          isFavoriteTap: false,
        );
      },
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      itemCount: 15,
    );
  }

  Widget buildOldLoadingWidget() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

  Column buildErrorBody() {
    var textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occurred with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Widget buildBody(PropertyOwnerPropertiesViewModel model) {
    final properties = model.properties;
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasErrorOnData) {
      return buildErrorBody();
    } else if (properties.isEmpty) {
      return buildEmptyBody();
    } else {
      return buildBodyItem(properties, model);
    }
  }

  Widget buildBodyItem(
      List<Property> properties, PropertyOwnerPropertiesViewModel model) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              final property = properties[index];
              return PropertyOwnerPropertiesCard(
                id: property.id ?? -1,
                onTap: () => model.goToPropertyDetails(property),
                verified: property.verificationStatus == null ||
                        property.verificationStatus == 'NOT_VERIFIED'
                    ? false
                    : true,
                image: property.propertyImages?[0].imageUrl ?? '',
                amountPerYear: property.spacePrice ?? 0.0,
                name: property.propertyName ?? '',
                address: property.address ?? '',
                numberOfBathrooms: property.bathTubCount ?? 0,
                numberOfBedrooms: property.bedroomCount ?? 0,
                numberOfCars: property.carSlot ?? 0,
                squareFeet: property.surfaceArea ?? 0,
                isFavoriteTap: property.favourite ?? false,
              );
            },
            controller: model.scrollController,
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            itemCount: properties.length,
          ),
        ),
        if (model.isLoadingOldData) buildOldLoadingWidget(),
      ],
    );
  }

  Column buildEmptyBody() {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'No property yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly create a new property by listing your space',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }
}

class PropertyOwnerPropertiesCard extends StatelessWidget {
  const PropertyOwnerPropertiesCard({
    Key? key,
    required this.id,
    required this.image,
    required this.verified,
    this.onFavoriteTap,
    this.amountPerYear,
    required this.name,
    this.shimmerEnabled = false,
    this.address = '',
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.numberOfCars,
    required this.squareFeet,
    this.isFavoriteTap = false,
    this.onTap,
  }) : super(key: key);

  final void Function()? onFavoriteTap;
  final int id;
  final String image;
  final double? amountPerYear;
  final String name;
  final bool verified;
  final String address;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int numberOfCars;
  final double squareFeet;
  final bool isFavoriteTap;
  final bool shimmerEnabled;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: shimmerEnabled
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: shimmerBody(),
                )
              : buildBody(),
        ),
      ),
    );
  }

  Row shimmerBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 100,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: kSecondaryColor,
            ),
          ),
        ),
        horizontalSpaceSmall,
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: 10,
              ),
              verticalSpaceTiny,
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: 10,
              ),
              verticalSpaceTiny,
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: 10,
              ),
              verticalSpaceTiny,
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildBody() {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: onTap,
            child: Hero(
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ResavationImage(
                      image: image,
                    ),
                  ),
                  Positioned(
                    top: 3,
                    left: 3,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: verified ? Colors.green : Colors.orange,
                      ),
                      child: Text(
                        verified ? 'Verifed' : 'Unverified',
                        style: AppStyle.kBodySmallRegular12W500.copyWith(
                          color: kWhite,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              tag: id.toString(),
            ),
          ),
        ),
        horizontalSpaceSmall,
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppStyle.kBodyRegular18W500,
              ),
              verticalSpaceTiny,
              Text(
                address,
                style: AppStyle.kBodySmallRegular12W300,
              ),
              verticalSpaceTiny,
              Text(
                'Verified: ${verified}',
                style: AppStyle.kBodySmallRegular12W300,
              ),
              verticalSpaceTiny,
              Text(
                '${String.fromCharCode(8358)}${oCcy.format(amountPerYear ?? 0)}',
                style: AppStyle.kBodySmallRegular12W500.copyWith(
                  color: kPrimaryColor,
                ),
              ),
              verticalSpaceSmall,
              PropertyDetails(
                numberOfBedrooms: numberOfBedrooms,
                numberOfCars: numberOfCars,
                numberOfBathrooms: numberOfBathrooms,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                squareFeet: squareFeet,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
