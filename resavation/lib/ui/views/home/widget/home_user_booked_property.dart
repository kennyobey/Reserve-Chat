import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/model/tenant_booked_property/content.dart';
import 'package:resavation/model/tenant_booked_property/tenant_booked_property.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:stacked/stacked.dart';
import '../../../shared/spacing.dart';
import '../home_viewmodel.dart';
import 'items.dart';

class HomeUserBookedProperty extends ViewModelWidget<HomeViewModel> {
  const HomeUserBookedProperty({Key? key}) : super(key: key);

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
          height: 70,
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
          'An error occurred with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 70,
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
          'No data!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'You curretly have no booked property',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget buildBody(HomeViewModel model) {
    return FutureBuilder<TenantBookedProperty>(
      future: model.httpService.getAllTenantsBookedProperty(page: 0, size: 5),
      builder: ((context, asyncDataSnapshot) {
        if (asyncDataSnapshot.hasError) {
          return buildErrorBody(context);
        }

        if (asyncDataSnapshot.hasData) {
          final queryData = asyncDataSnapshot.data;
          final List<TenantBookedPropertyContent> bookedProperty =
              queryData?.content ?? [];

          return buildSuccessBody(bookedProperty, model, context);
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

  Widget buildSuccessBody(List<TenantBookedPropertyContent> allContent,
      HomeViewModel model, BuildContext context) {
    return allContent.isEmpty
        ? buildEmptyBody(context)
        : ListView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final content = allContent[index];
              return BookedPropertyCard(
                content: content,
                onTap: () {
                  model.goToBookedPropertyDetails(content);
                },
              );
            },
            itemCount: allContent.length,
          );
  }

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleListTile(
          onTap: () {
            model.goToBookedContentList();
          },
          visibility: true,
          title: 'Booked Propierties',
        ),
        verticalSpaceSmall,
        buildBody(model),
      ],
    );
  }
}

class BookedPropertyCard extends StatelessWidget {
  const BookedPropertyCard({
    Key? key,
    required this.content,
    this.onTap,
  }) : super(key: key);

  final TenantBookedPropertyContent content;
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
                      'Verified: ' + content.status.toString().toUpperCase(),
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
