import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../model/top_categories_model/content.dart';
import '../../../../model/top_categories_model/top_categories_model.dart';
import '../../../shared/spacing.dart';

import '../home_viewmodel.dart';
import 'items.dart';

class HomeTopCategories extends ViewModelWidget<HomeViewModel> {
  const HomeTopCategories({Key? key}) : super(key: key);

  Column buildErrorBody(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
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
    var textTheme = Theme.of(context).textTheme;
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
          'There are currently no top categories near  you',
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
    final topCategoriesFuture =
        model.httpService.getTopCategoriesWithHighestProperties();
    return FutureBuilder<TopCategoriesModel>(
      future: topCategoriesFuture,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return buildErrorBody(context);
        }

        if (snapshot.hasData) {
          //show body here
          final List<TopCategoriesContent> allContent =
              snapshot.data?.content ?? [];
          return buildSuccessBody(allContent, model, context);
        } else {
          return buildLoadingBody(context);
        }
      }),
    );
  }

  SingleChildScrollView buildLoadingBody(BuildContext context) {
    final allContent = [
      TopCategoriesContent(
        propertyCategory: 'Loading....',
      ),
      TopCategoriesContent(
        propertyCategory: 'Loading....',
      ),
      TopCategoriesContent(
        propertyCategory: 'Loading....',
      ),
      TopCategoriesContent(
        propertyCategory: 'Loading....',
      ),
      TopCategoriesContent(
        propertyCategory: 'Loading....',
      ),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final content in allContent) ...[
            CategoryCard(
              image: '',
              category: content.propertyCategory ?? '',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Loading data, please wait')));
              },
            ),
            horizontalSpaceSmall,
          ],
        ],
      ),
    );
  }

  Widget buildSuccessBody(List<TopCategoriesContent> allContent,
      HomeViewModel model, BuildContext context) {
    return allContent.isEmpty
        ? buildEmptyBody(context)
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final content in allContent) ...[
                  CategoryCard(
                    image: '',
                    category: content.propertyCategory ?? '',
                    onTap: () {
                      model.goToPropertySearch(content.propertyCategory ?? '');
                    },
                  ),
                  horizontalSpaceSmall,
                ],
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleListTile(
          onTap: model.goToCategoriesView,
          visibility: true,
          title: 'Categories',
        ),
        verticalSpaceSmall,
        buildBody(model),
      ],
    );
  }
}
