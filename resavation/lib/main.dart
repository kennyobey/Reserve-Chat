import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/app/ui/setup_sanckbar_ui.dart';
import 'package:stacked_services/stacked_services.dart';

Future main() async {
  setupLocator();
  setupSnackbarUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resavation',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: Colors.white),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
