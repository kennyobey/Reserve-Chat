import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class OnboardingView extends HookWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageViewController = usePageController();
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
            body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            PageView(
              controller: pageViewController,
              onPageChanged: model.onPageChanged,
              children: [
                Pages(
                  asset: Assets.onboarding1,
                  subTitle: 'Search as much as possible accomodations of your choice',
                  title: 'Search',
                ),
                Pages(
                  asset: Assets.onboarding2,
                  subTitle: 'Pay for your rent seamlessly without panic and save yourself from fraud by using our app ',
                  title: 'Rent',
                ),
                Pages(
                  asset: Assets.onboarding3,
                  subTitle: 'Have access to your accomodation as soon as you make your payment',
                  title: 'Move In',
                ),
              ],
            ),
            Positioned(
              bottom: 120,
              child: model.pagePosition == 2
                  ? ResavationButton(
                      title: "Get Started",
                      onTap: model.goToMainView,
                    )
                  : DotsIndicator(
                      dotsCount: 3,
                      position: model.pagePosition.toDouble(),
                    ),
            )
          ],
        )),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
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
    return Column(
      children: [
        verticalSpaceMassive,
        SvgPicture.asset(
          asset,
        ),
        verticalSpaceMassive,
        Text(
          title,
          style: AppStyle.kBodyBold,
        ),
        verticalSpaceMedium,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
