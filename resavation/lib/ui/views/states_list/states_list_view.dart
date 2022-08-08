import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:resavation/model/top_states_model/content.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/home/widget/items.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';
import 'states_list_viewmodel.dart';

class StatesListView extends StatelessWidget {
  const StatesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StatesListViewModel>.reactive(
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
      viewModelBuilder: () => StatesListViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "States",
      backEnabled: true,
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
          'No States yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly check back later for updated States',
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
          childAspectRatio: 1 / 1.5,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          return TopCityCard(
            image: '',
            numberOfProperties: 0,
            shimmerEnabled: true,
            location: '',
            onTap: () {},
          );
        });
  }

  Padding buildBody(StatesListViewModel model, BuildContext context) {
    final topStates = model.topStates;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const Divider(),
          verticalSpaceTiny,
          Row(
            children: [
              Text(
                topStates.length.toString(),
                style: AppStyle.kSubHeading.copyWith(
                  color: kPrimaryColor,
                ),
              ),
              Text(
                ' States',
                style: AppStyle.kSubHeading,
              ),
              Spacer(),
            ],
          ),
          verticalSpaceTiny,
          const Divider(),
          verticalSpaceSmall,
          Expanded(
            child: buildBodyItem(topStates, model, context),
          ),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  Widget buildBodyItem(List<TopStatesContent> topStates,
      StatesListViewModel model, BuildContext context) {
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasErrorOnData) {
      return buildErrorBody(context);
    } else if (topStates.isEmpty) {
      return buildEmptyBody(context);
    } else {
      return GridView.builder(
          padding: const EdgeInsets.all(0),
          physics: const BouncingScrollPhysics(),
          controller: model.scrollController,
          itemCount: topStates.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 1.5,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (_, index) {
            final topCity = topStates[index];
            return TopCityCard(
              image: model.topCitiesImages[index],
              numberOfProperties: topCity.numberOfProperties ?? 0,
              location: topCity.state ?? '',
              onTap: () => model.goToSearchView(topCity.state ?? ''),
            );
          });
    }
  }
}
