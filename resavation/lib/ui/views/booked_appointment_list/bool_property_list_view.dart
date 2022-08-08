import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:resavation/model/tenant_booked_property/content.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/views/home/widget/home_user_booked_property.dart';
import '../../shared/text_styles.dart';
import 'book_property_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';

class BookedPropertyListView extends StatefulWidget {
  const BookedPropertyListView({
    Key? key,
  }) : super(key: key);

  @override
  State<BookedPropertyListView> createState() => _BookedPropertyListViewState();
}

class _BookedPropertyListViewState extends State<BookedPropertyListView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookedPropertyListViewModel>.reactive(
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
                        model.contents.length.toString(),
                        style: AppStyle.kSubHeading.copyWith(
                          color: kPrimaryColor,
                        ),
                      ),
                      Text(
                        '  Booked Properties',
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
            )),
      ),
      viewModelBuilder: () => BookedPropertyListViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: 'Booked Property',
      backEnabled: true,
      centerTitle: false,
    );
  }

  Widget buildLoadingWidget() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return BookedPropertyCard(
          content: TenantBookedPropertyContent(),
          onTap: () {},
          shimmerEnabled: true,
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

  Widget buildBody(BookedPropertyListViewModel model) {
    final contents = model.contents;
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasErrorOnData) {
      return buildErrorBody();
    } else if (contents.isEmpty) {
      return buildEmptyBody();
    } else {
      return buildBodyItem(contents, model);
    }
  }

  Widget buildBodyItem(List<TenantBookedPropertyContent> contents,
      BookedPropertyListViewModel model) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              final content = contents[index];
              return BookedPropertyCard(
                content: content,
                onTap: () {
                  model.goToPropertyDetails(content);
                },
              );
            },
            controller: model.scrollController,
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            itemCount: contents.length,
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
          'Kindly check back later for the specified property',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }
}
