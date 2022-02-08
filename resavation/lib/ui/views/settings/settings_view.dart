import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/settings/settings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Settings',
                    style: AppStyle.kHeading1,
                  ),
                ),
                verticalSpaceMedium,
                SettingsRow(
                  icon: Icons.people,
                  title: 'Account',
                ),
                verticalSpaceMedium,
                Text(
                  'Edit Profile',
                  style: AppStyle.kBodyRegular,
                ),
                verticalSpaceSmall,
                Text(
                  'Change Password',
                  style: AppStyle.kBodyRegular,
                ),
                verticalSpaceMedium,
                SettingsRow(
                  icon: Icons.notifications,
                  title: 'Notification',
                ),
                SwitchListTile(
                  value: model.notificationSwitchValue,
                  onChanged: model.onNotificationSwitchChanged,
                  title: Text(
                    'Notifications',
                    style: AppStyle.kBodyRegular,
                  ),
                ),
                SwitchListTile(
                  value: model.appNotificationSwitchValue,
                  onChanged: model.onAppNotificationSwitchValue,
                  title: Text(
                    'App Notifications',
                    style: AppStyle.kBodyRegular,
                  ),
                ),
                verticalSpaceSmall,
                SettingsRow(
                  icon: Icons.more_rounded,
                  title: 'More',
                ),
                verticalSpaceMedium,
                Text(
                  'Language',
                  style: AppStyle.kBodyRegular,
                ),
                verticalSpaceSmall,
                Text(
                  'Country',
                  style: AppStyle.kBodyRegular,
                ),
                verticalSpaceMedium,
                ResavationButton(
                  title: 'Switch to Property Owner',
                ),
                horizontalSpaceSmall,
                verticalSpaceMedium,
                GestureDetector(
                  onTap: model.logout,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: kRed,
                        // onTap: model.goToOff(),
                      ),
                      Text(
                        'Logout',
                        style: AppStyle.kBodyBold.copyWith(color: kRed),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SettingsViewModel(),
    );
  }
}

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        horizontalSpaceSmall,
        Text(
          title,
          style: AppStyle.kBodyBold,
        ),
      ],
    );
  }
}
