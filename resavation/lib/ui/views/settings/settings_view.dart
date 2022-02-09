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
                SettingsListTile(
                  onTap: model.showComingSoon,
                  icon: Icons.people,
                  title: 'Account',
                ),
                SettingsListTile(title: 'Edit Profile'),
                SettingsListTile(title: 'Change Password'),
                SettingsListTile(
                  onTap: model.showComingSoon,
                  icon: Icons.notifications,
                  title: 'Notification',
                ),
                SwitchListTile(
                  dense: true,
                  value: model.notificationSwitchValue,
                  onChanged: model.onNotificationSwitchChanged,
                  title: Text(
                    'Notifications',
                    style: AppStyle.kBodyRegular,
                  ),
                ),
                SwitchListTile(
                  dense: true,
                  value: model.appNotificationSwitchValue,
                  onChanged: model.onAppNotificationSwitchValue,
                  title: Text(
                    'App Notifications',
                    style: AppStyle.kBodyRegular,
                  ),
                ),
                SettingsListTile(
                  onTap: model.showComingSoon,
                  icon: Icons.more_rounded,
                  title: 'More',
                ),
                SettingsListTile(title: 'Language'),
                SettingsListTile(title: 'Country'),
                verticalSpaceMedium,
                ListTile(
                  minLeadingWidth: 0,
                  horizontalTitleGap: 5,
                  onTap: model.logout,
                  leading: Icon(
                    Icons.logout,
                    color: kRed,
                    // onTap: model.goToOff(),
                  ),
                  title: Text(
                    'Logout',
                    style: AppStyle.kBodyBold.copyWith(color: kRed),
                  ),
                ),
                Spacer(),
                ResavationButton(
                  onTap: model.showComingSoon,
                  title: 'Switch to Property Owner',
                  titleColor: kPrimaryColor,
                  buttonColor: kWhite.withOpacity(0.9),
                  //  borderColor: kp,
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SettingsViewModel(),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    Key? key,
    this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool hasIcon = icon != null;
    return ListTile(
      onTap: hasIcon ? null : onTap,
      dense: true,
      leading: hasIcon ? Icon(icon) : null,
      title: Text(
        title,
        style: hasIcon ? AppStyle.kBodyBold : AppStyle.kBodyRegular,
      ),
    );
  }
}
