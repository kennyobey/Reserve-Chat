import 'package:flutter/material.dart';
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
        return Scaffold(
          appBar: buildAppBar(),
          body: buildBody(model, context),
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
      return ListView.builder(
        itemBuilder: (ctx, index) {
          final topCity = topStates[index];

          return LongCategoriesAndStatesCard(
            onTap: () => model.goToSearchView(topCity.state ?? ''),
            image: "",
            title: topCity.state ?? '',
            count: "${topCity.numberOfProperties ?? ''} items",
          );
        },
        padding: const EdgeInsets.all(0),
        controller: model.scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: topStates.length,
      );
    }
  }
}
