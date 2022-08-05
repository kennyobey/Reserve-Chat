import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/utility/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';

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
            child: Image.asset('assets/icons/new_app_icon.png',
                height: 150, fit: BoxFit.fitHeight),
          ),
          verticalSpaceTiny,
          Text(
            'Resavation',
            style: AppStyle.kHeading4.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: kBlack,
            ),
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

  void route() async {
    final service = locator<NavigationService>();
    if (AppPreferences.hasUserSeenOnBoarding) {
      if (AppPreferences.getRefeshToken.isEmpty ||
          AppPreferences.getTokenType.isEmpty ||
          AppPreferences.getAccessRoles.isEmpty) {
        service.replaceWith(Routes.logInView);
      } else {
        service.replaceWith(Routes.refreshTokenView);
      }
    } else {
      service.replaceWith(Routes.onboardingView);
    }
  }

  Future startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }
}
