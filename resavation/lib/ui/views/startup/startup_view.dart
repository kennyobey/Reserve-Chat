import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';

/*
class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      onModelReady: (model) => model.goToOnboardingView(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}

*/

class StartupView extends StatefulWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView>
    with SingleTickerProviderStateMixin {
  //fade in transition for logo and app name
  Animation<double>? _opacityAnimation;
  AnimationController? _controller;

  final Duration _duration = const Duration(milliseconds: 2000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  FadeTransition buildBody() {
    return FadeTransition(
      opacity: _opacityAnimation!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Hero(
            tag: "logo", // id for hero animation
            child: Image.asset('assets/icons/app_icon.png',
                color: kPrimaryColor, height: 180, fit: BoxFit.fitHeight),
          ),
          verticalSpaceSmall,
          Text(
            'Resavation',
            style: AppStyle.kHeading4.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    setUpAnimation();
  }

  void setUpAnimation() {
    //initialize controller and animation
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      ),
    );

    // action on animation completion
    _controller?.addListener(() {
      if (_controller!.isCompleted) {
        startTime();
      }
    });

    // 2 seconds delay before animation starts
    var duration = const Duration(seconds: 2);
    Timer(duration, () {
      _controller?.forward();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void route() {
    locator<NavigationService>().replaceWith(Routes.onboardingView);
  }

  Future startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }
}
