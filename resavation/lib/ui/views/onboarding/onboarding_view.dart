import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class OnboardingView extends HookWidget {
  const OnboardingView({Key? key}) : super(key: key);

  final _pages = const [
    Pages(
      asset: Assets.onboarding1,
      subTitle: 'Search as much as possible accommodations of your choice',
      title: 'Search',
    ),
    Pages(
      asset: Assets.onboarding2,
      subTitle:
          'Pay for your rent seamlessly without panic and save yourself from fraud by using our app ',
      title: 'Rent',
    ),
    Pages(
      asset: Assets.onboarding3,
      subTitle:
          'Have access to your accommodation as soon as you make your payment',
      title: 'Move In',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pageViewController = usePageController();
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      onModelReady: (model) => model.loadSvgs(),
      builder: (context, model, child) =>
          buildBody(model, context, pageViewController),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }

  Scaffold buildBody(OnboardingViewModel model, BuildContext context,
      PageController pageViewController) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageViewController,
                  onPageChanged: model.onPageChanged,
                  children: _pages,
                ),
              ),
              buildBottomWidget(context, model)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomWidget(BuildContext context, OnboardingViewModel model) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      child: AnimatedSwitcher(
        child: model.pagePosition == 2
            ? ResavationButton(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20, right: 20),
                title: "Get Started",
                onTap: model.goToSignUpView,
              )
            : buildIndicators(model.pagePosition),
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
      ),
    );
  }

  Widget buildIndicators(int currentIndex) {
    List<int> indexes = [0, 1, 2];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indexes
          .map((index) => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: const EdgeInsets.only(right: 5),
                height: 8,
                width: (currentIndex == index) ? 50 : 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: (currentIndex == index)
                      ? Colors.blue
                      : Colors.black.withOpacity(0.2),
                ),
              ))
          .toList(),
    );
  }
}

class Pages extends StatelessWidget {
  const Pages({
    Key? key,
    required this.asset,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String asset;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          SvgPicture.asset(
            asset,
            width: 400,
          ),
          verticalSpaceSmall,
          Text(
            title,
            style: AppStyle.kHeading4,
          ),
          verticalSpaceTiny,
          Text(
            subTitle,
            style: AppStyle.kBodyRegularBlack14,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
