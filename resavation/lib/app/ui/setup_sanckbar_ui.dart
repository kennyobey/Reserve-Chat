import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final _snackbarServie = locator<SnackbarService>();

  _snackbarServie.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: kWhite,
    textColor: kPrimaryColor,
    mainButtonTextColor: Colors.black,
  ));
}
