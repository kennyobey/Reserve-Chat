import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
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
        return Scaffold(
          appBar: buildAppBar(),
          body: buildBody(model, context),
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

  Center buildLoadingWidget() {
    return const Center(
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

  Padding buildBody(CategoriesListViewModel model, BuildContext context) {
    final topCategories = model.topCategories;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          verticalSpaceTiny,
          const Divider(),
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
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    "sort by",
                    style: AppStyle.kBodySmallRegular,
                  ),
                  items: model.items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: model.selectedValue,
                  onChanged: (String? value) {
                    model.onSelectedValueChange(value);
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              )
            ],
          ),
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

  Widget buildBodyItem(List<TopCategoriesContent> topCategories,
      CategoriesListViewModel model, BuildContext context) {
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasError) {
      return buildErrorBody(context);
    } else if (topCategories.isEmpty) {
      return buildEmptyBody(context);
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          final topCategory = topCategories[index];

          return LongCategoriesAndCitiesCard(
            onTap: () =>
                model.goToSearchView(topCategory.propertyCategory ?? ''),
            image: "",
            title: topCategory.propertyCategory ?? '',
            count: "${topCategory.numberOfProperties ?? ''} category",
          );
        },
        padding: const EdgeInsets.all(0),
        physics: const BouncingScrollPhysics(),
        itemCount: topCategories.length,
      );
    }
  }
}
