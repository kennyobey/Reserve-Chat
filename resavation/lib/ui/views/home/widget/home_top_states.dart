import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../model/top_states_model/content.dart';
import '../../../shared/spacing.dart';

import '../home_viewmodel.dart';
import 'items.dart';

class HomeTopStates extends ViewModelWidget<HomeViewModel> {
  const HomeTopStates({Key? key}) : super(key: key);

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

  Widget buildBody(HomeViewModel model, BuildContext context) {
    if (model.topStatesLoading) {
      return buildLoadingBody(context);
    } else if (model.topStateHasError) {
      return buildErrorBody(context);
    } else {
      final List<TopStatesContent> allContent =
          model.topStatesModel.content ?? [];
      return buildSuccessBody(allContent, model, context);
    }
  }

  SingleChildScrollView buildLoadingBody(BuildContext context) {
    final allContent = [
      TopStatesContent(),
      TopStatesContent(),
      TopStatesContent(),
      TopStatesContent(),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (final _ in allContent) ...[
            TopCityCard(
              image: '',
              numberOfProperties: 0,
              shimmerEnabled: true,
              location: '',
              onTap: () {},
            ),
            horizontalSpaceSmall,
          ],
        ],
      ),
    );
  }

  Widget buildSuccessBody(List<TopStatesContent> allContent,
      HomeViewModel model, BuildContext context) {
    return allContent.isEmpty
        ? buildEmptyBody(context)
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final content in allContent) ...[
                  TopCityCard(
                    image: model.topStatesImages[allContent.indexOf(content)],
                    numberOfProperties: content.numberOfProperties ?? 0,
                    location: content.state ?? '',
                    onTap: () {
                      model.goToTopItemsView(content.state ?? '', true);
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
          onTap: model.goToStatesView,
          visibility: true,
          title: 'Top States',
        ),
        verticalSpaceSmall,
        buildBody(model, context),
      ],
    );
  }
}
