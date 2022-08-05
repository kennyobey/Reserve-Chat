import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';
import 'package:resavation/model/tenant_booked_property/content.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:shimmer/shimmer.dart';
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

  Widget buildBody(HomeViewModel model, BuildContext context) {
    if (model.tenantBookedPropertyLoading) {
      return buildLoadingWidget();
    } else if (model.tenantBookedPropertyHasError) {
      return buildErrorBody(context);
    } else {
      return buildSuccessBody(model.tenantBookedPropertyModel, model, context);
    }
  }

  Widget buildLoadingWidget() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return BookedPropertyCard(
          shimmerEnabled: true,
          content: TenantBookedPropertyContent(),
          onTap: () {},
        );
      },
      itemCount: 3,
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
          title: 'Booked Properties',
        ),
        verticalSpaceSmall,
        buildBody(model, context),
      ],
    );
  }
}

class BookedPropertyCard extends StatelessWidget {
  const BookedPropertyCard({
    Key? key,
    required this.content,
    this.onTap,
    this.shimmerEnabled = false,
  }) : super(key: key);

  final TenantBookedPropertyContent content;
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
    final property = content.property;
    final oCcy = NumberFormat("#,##0.00", "en_US");
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
