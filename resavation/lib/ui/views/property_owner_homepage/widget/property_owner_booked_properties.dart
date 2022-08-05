import 'package:flutter/material.dart';
import 'package:resavation/model/owner_booked_property/content.dart';

import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/home/widget/items.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../property_owner_homepageViewModel.dart';

class PropertyOwnerBookedProperties
    extends ViewModelWidget<PropertyOwnerHomePageViewModel> {
  const PropertyOwnerBookedProperties({Key? key}) : super(key: key);

  Column buildErrorBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occured with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Column buildEmptyBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        Text(
          'No  booked properties yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly check back later for request(s) on your properties',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget buildBody(PropertyOwnerHomePageViewModel model, BuildContext context) {
    if (model.ownerBookedPropertyLoading) {
      return buildLoadingWidget();
    } else if (model.ownerBookedPropertyHasError) {
      return buildErrorBody(context);
    } else {
      return buildSuccessBody(model.ownerBookedPropertyModel, model, context);
    }
  }

  Widget buildLoadingWidget() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (_, index) {
        return PropertyOwnerBookedPropertyCard(
          content: OwnerBookedPropertyContent(),
          shimmerEnabled: true,
          onTap: () {},
        );
      },
    );
  }

  Widget buildSuccessBody(List<OwnerBookedPropertyContent> allProperties,
      PropertyOwnerHomePageViewModel model, BuildContext context) {
    return allProperties.isEmpty
        ? buildEmptyBody(context)
        : ListView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: allProperties.length,
            itemBuilder: (_, index) {
              final property = allProperties[index];
              return PropertyOwnerBookedPropertyCard(
                  content: property,
                  onTap: () => model.goToOwnerBookedPropertyDetails(property));
            },
          );
  }

  @override
  Widget build(BuildContext context, PropertyOwnerHomePageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleListTile(
          onTap: () {
            model.goToPropertyOwnerBookedPropertiesView();
          },
          visibility: true,
          title: 'Tenant Request(s)',
        ),
        verticalSpaceSmall,
        buildBody(model, context),
      ],
    );
  }
}

class PropertyOwnerBookedPropertyCard extends StatelessWidget {
  const PropertyOwnerBookedPropertyCard({
    Key? key,
    required this.content,
    this.onTap,
    this.shimmerEnabled = false,
  }) : super(key: key);

  final OwnerBookedPropertyContent content;
  final void Function()? onTap;
  final bool shimmerEnabled;

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
        child: shimmerEnabled
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: shimmerBody(),
              )
            : buildBody(),
      ),
    );
  }

  Widget shimmerBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 130,
          width: double.infinity,
          color: kPrimaryColor,
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            color: kPrimaryColor,
            width: double.infinity,
            height: 10,
          ),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            color: kPrimaryColor,
            width: double.infinity,
            height: 10,
          ),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            color: kPrimaryColor,
            width: double.infinity,
            height: 10,
          ),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            color: kPrimaryColor,
            width: double.infinity,
            height: 10,
          ),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            color: kPrimaryColor,
            width: double.infinity,
            height: 10,
          ),
        ),
        verticalSpaceTiny,
      ],
    );
  }

  Widget buildBody() {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    final property = content.property;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Hero(
          child: Stack(
            children: [
              Container(
                height: 130,
                width: double.infinity,
                child: ResavationImage(
                  image: property?.propertyImages?[0].imageUrl ?? '',
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
                    color:
                        content.status == true ? Colors.green : Colors.orange,
                  ),
                  child: Text(
                    content.status == true ? 'Accepted' : 'Pending',
                    style: AppStyle.kBodySmallRegular12W500.copyWith(
                      color: kWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
          tag: content.id.toString(),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            property?.propertyName ?? '',
            style: AppStyle.kBodyRegularBlack16W600.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        verticalSpaceTiny,
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            property?.address ?? '',
            style: AppStyle.kBodySmallRegular12W300,
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Payment Cycle',
                  style: AppStyle.kBodySmallRegular12W300,
                ),
              ),
              Text(
                (content.paymentCycle ?? ''),
                style: AppStyle.kBodySmallRegular12W500,
              ),
            ],
          ),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Tenant Name',
                  style: AppStyle.kBodySmallRegular12W300,
                ),
              ),
              Text(
                (content.user?.firstName ?? '') +
                    " " +
                    (content.user?.lastName ?? ''),
                style: AppStyle.kBodySmallRegular12W500,
              ),
            ],
          ),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Price',
                  style: AppStyle.kBodySmallRegular12W300,
                ),
              ),
              Text(
                '${String.fromCharCode(8358)} ${oCcy.format(content.amount ?? 0)}',
                style: AppStyle.kBodySmallRegular12W500,
              ),
            ],
          ),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Payment Details',
                  style: AppStyle.kBodySmallRegular12W300,
                ),
              ),
              Text(
                'Not Paid',
                style: AppStyle.kBodySmallRegular12W500,
              ),
            ],
          ),
        ),
        verticalSpaceTiny,
      ],
    );
  }
}
