import 'package:flutter/material.dart';
import 'package:resavation/model/owner_booked_property/content.dart';
import 'package:resavation/model/owner_booked_property/owner_booked_property.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/home/widget/items.dart';
import 'package:intl/intl.dart';
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

  Widget buildBody(PropertyOwnerHomePageViewModel model) {
    return FutureBuilder<OwnerBookedProperty>(
      future: model.httpService.getAllOwnerBookedProperty(page: 0, size: 5),
      builder: ((context, asyncDataSnapshot) {
        if (asyncDataSnapshot.hasError) {
          return buildErrorBody(context);
        }

        if (asyncDataSnapshot.hasData) {
          final List<OwnerBookedPropertyContent> ownerProperty =
              asyncDataSnapshot.data?.content ?? [];

          return buildSuccessBody(ownerProperty, model, context);
        } else {
          return buildLoadingWidget();
        }
      }),
    );
  }

  Widget buildLoadingWidget() {
    return Container(
      height: 300,
      width: double.infinity,
      alignment: Alignment.center,
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
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
        buildBody(model),
      ],
    );
  }
}

class PropertyOwnerBookedPropertyCard extends StatelessWidget {
  const PropertyOwnerBookedPropertyCard({
    Key? key,
    required this.content,
    this.onTap,
  }) : super(key: key);

  final OwnerBookedPropertyContent content;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    final property = content.property;
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      property?.propertyName ?? '',
                      style: AppStyle.kBodyRegular18W500,
                    ),
                    verticalSpaceTiny,
                    Text(
                      property?.address ?? '',
                      style: AppStyle.kBodySmallRegular12W300,
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Payment Type: ' + (content.paymentType ?? ''),
                      style: AppStyle.kBodySmallRegular12W300,
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Tenant Name: ' +
                          (content.user?.firstName ?? '') +
                          " " +
                          (content.user?.lastName ?? ''),
                      style: AppStyle.kBodySmallRegular12W300,
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Status: ' +
                          (content.status == true ? 'Accepted' : 'Pending'),
                      style: AppStyle.kBodySmallRegular12W300,
                    ),
                    verticalSpaceTiny,
                    Text(
                      '${String.fromCharCode(8358)} ${oCcy.format(content.amount ?? 0)}',
                      style: AppStyle.kBodySmallRegular12W500.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: onTap,
                  child: Hero(
                    child: Container(
                      height: 100,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ResavationImage(
                        image: property?.propertyImages?[0].imageUrl ?? '',
                      ),
                    ),
                    tag: content.id.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
