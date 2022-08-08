import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:resavation/model/top_categories_model/content.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/categories_list/categories_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';
import '../home/widget/items.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesListViewModel>.reactive(
      builder: (context, model, child) {
        return FocusDetector(
          onFocusGained: () {
            model.getData();
          },
          child: Scaffold(
            appBar: buildAppBar(),
            body: buildBody(model, context),
          ),
        );
      },
      viewModelBuilder: () => CategoriesListViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Categories",
      centerTitle: false,
    );
  }

  Column buildErrorBody(BuildContext context) {
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

  Column buildEmptyBody(BuildContext context) {
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
          'No cities yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly check back later for updated cities',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Widget buildLoadingWidget() {
    return GridView.builder(
        padding: const EdgeInsets.all(0),
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 1,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          return CategoryCard(
            image: '',
            shimmerEnabled: true,
            category: '',
            onTap: () {},
          );
        });
  }

  Padding buildBody(CategoriesListViewModel model, BuildContext context) {
    final topCategories = model.topCategories;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const Divider(),
          verticalSpaceTiny,
          Row(
            children: [
              Text(
                topCategories.length.toString(),
                style: AppStyle.kSubHeading.copyWith(
                  color: kPrimaryColor,
                ),
              ),
              Text(
                ' Categories',
                style: AppStyle.kSubHeading,
              ),
              Spacer(),
            ],
          ),
          verticalSpaceTiny,
          const Divider(),
          verticalSpaceSmall,
          Expanded(
            child: buildBodyItem(topCategories, model, context),
          ),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  Widget buildBodyItem(
    List<TopCategoriesContent> topCategories,
    CategoriesListViewModel model,
    BuildContext context,
  ) {
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasErrorOnData) {
      return buildErrorBody(context);
    } else if (topCategories.isEmpty) {
      return buildEmptyBody(context);
    } else {
      return GridView.builder(
          padding: const EdgeInsets.all(0),
          physics: const BouncingScrollPhysics(),
          controller: model.scrollController,
          itemCount: topCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 1,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (_, index) {
            final topCategory = topCategories[index];
            return CategoryCard(
              image: model.topCategoriesImages[index],
              category: topCategory.propertyCategory ?? '',
              onTap: () =>
                  model.goToSearchView(topCategory.propertyCategory ?? ''),
            );
          });
    }
  }
}
