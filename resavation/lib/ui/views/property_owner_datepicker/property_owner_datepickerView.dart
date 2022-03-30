// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_datepicker/property_owner_datepickerViewModel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerDatePickerView extends StatelessWidget {
  const PropertyOwnerDatePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerDatePickerViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 15,
              ),
              child: AlertDialog(
                title: Text("Dailoge"),
                content: Text("My name"),
              )),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerDatePickerViewModel(),
    );
  }
}
