import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_step1/property_owner_step1_viewmodel.dart';
import 'package:resavation/ui/views/settings/settings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PropertyOwnerStep1View extends StatelessWidget {
  const PropertyOwnerStep1View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerStep1ViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Space Type',
                      style: AppStyle.kHeading1,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Tell us about your property',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Narrow down your space type',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Is your space serviced',
                    style: AppStyle.kBodyRegular,
                  ),
                  // RadioListTile(
                  //   title: const Text('Flutter'),
                  //   value: FavoriteMethod.flutter,
                  //   groupValue: _method,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _method = value;
                  //     });
                  //   },
                  // ),
                  SwitchListTile(
                    value: model.notificationSwitchValue,
                    onChanged: model.onNotificationSwitchChanged,
                    title: Text(
                      'Yes',
                      style: AppStyle.kBodyRegular,
                    ),
                  ),
                  SwitchListTile(
                    value: model.appNotificationSwitchValue,
                    onChanged: model.onAppNotificationSwitchValue,
                    title: Text(
                      'No',
                      style: AppStyle.kBodyRegular,
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Is your space furnished',
                    style: AppStyle.kBodyRegular,
                  ),
                  SwitchListTile(
                    value: model.notificationSwitchValue,
                    onChanged: model.onNotificationSwitchChanged,
                    title: Text(
                      'Yes',
                      style: AppStyle.kBodyRegular,
                    ),
                  ),
                  SwitchListTile(
                    value: model.appNotificationSwitchValue,
                    onChanged: model.onAppNotificationSwitchValue,
                    title: Text(
                      'No',
                      style: AppStyle.kBodyRegular,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Listing Options',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Country',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceMedium,
                  ResavationTextField(
                    hintText: 'Choose your listing option',
                  ),
                  Text(
                    'Do you leave in this space',
                    style: AppStyle.kBodyRegular,
                  ),
                  SwitchListTile(
                    value: model.notificationSwitchValue,
                    onChanged: model.onNotificationSwitchChanged,
                    title: Text(
                      'Yes',
                      style: AppStyle.kBodyRegular,
                    ),
                  ),
                  SwitchListTile(
                    value: model.appNotificationSwitchValue,
                    onChanged: model.onAppNotificationSwitchValue,
                    title: Text(
                      'No',
                      style: AppStyle.kBodyRegular,
                    ),
                  ),

                  //Number of Bathroom and Bedroom
                  SwitchListTile(
                    value: model.notificationSwitchValue,
                    onChanged: model.onNotificationSwitchChanged,
                    title: Text(
                      'Number of Bathrooms',
                      style: AppStyle.kBodyRegular,
                    ),
                  ),
                  SwitchListTile(
                    value: model.appNotificationSwitchValue,
                    onChanged: model.onAppNotificationSwitchValue,
                    title: Text(
                      'Number of Bedrooms',
                      style: AppStyle.kBodyRegular,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerStep1ViewModel(),
    );
  }
}
