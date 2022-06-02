import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/model/top_cities_model/content.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/cities_list/cities_list_viewmodel.dart';
import 'package:resavation/ui/views/home/widget/items.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';

class CitiesListView extends StatelessWidget {
  const CitiesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CitiesListViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: buildAppBar(),
          body: buildBody(model, context),
        );
      },
      viewModelBuilder: () => CitiesListViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Cities",
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

  Padding buildBody(CitiesListViewModel model, BuildContext context) {
    final topCities = model.topCities;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          verticalSpaceTiny,
          const Divider(),
          Row(
            children: [
              Text(
                topCities.length.toString(),
                style: AppStyle.kSubHeading.copyWith(
                  color: kPrimaryColor,
                ),
              ),
              Text(
                ' Cities',
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
            child: buildBodyItem(topCities, model, context),
          ),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  Widget buildBodyItem(List<TopCitiesContent> topCities,
      CitiesListViewModel model, BuildContext context) {
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasError) {
      return buildErrorBody(context);
    } else if (topCities.isEmpty) {
      return buildEmptyBody(context);
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          final topCity = topCities[index];

          return LongCategoriesAndCitiesCard(
            onTap: () => model.goToSearchView(topCity.cityName ?? ''),
            image: "",
            title: topCity.cityName ?? '',
            count: "${topCity.numberOfProperties ?? ''} cities",
          );
        },
        padding: const EdgeInsets.all(0),
        physics: const BouncingScrollPhysics(),
        itemCount: topCities.length,
      );
    }
  }
}
