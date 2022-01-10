// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/login/login_view.dart';
import '../ui/views/main/main_view.dart';
import '../ui/views/onboarding/onboarding_view.dart';
import '../ui/views/rest_password/reset_password_view.dart';
import '../ui/views/signup/signup_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String mainView = '/main-view';
  static const String onboardingView = '/onboarding-view';
  static const String signUpView = '/sign-up-view';
  static const String logInView = '/log-in-view';
  static const String resetPasswordView = '/reset-password-view';
  static const all = <String>{
    startupView,
    mainView,
    onboardingView,
    signUpView,
    logInView,
    resetPasswordView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.mainView, page: MainView),
    RouteDef(Routes.onboardingView, page: OnboardingView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.logInView, page: LogInView),
    RouteDef(Routes.resetPasswordView, page: ResetPasswordView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    MainView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const MainView(),
        settings: data,
      );
    },
    OnboardingView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const OnboardingView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const SignUpView(),
        settings: data,
      );
    },
    LogInView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const LogInView(),
        settings: data,
      );
    },
    ResetPasswordView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const ResetPasswordView(),
        settings: data,
      );
    },
  };
}
