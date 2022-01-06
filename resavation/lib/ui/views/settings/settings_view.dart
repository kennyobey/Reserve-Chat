import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/settings/settings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'Settings View',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => SettingsViewModel(),
    );
  }
}
