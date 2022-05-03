import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
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
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(title: 'Settings'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsListTile(
                icon: Icons.people,
                title: 'Account',
              ),
              SettingsListTile(
                title: 'Edit Profile',
                onTap: model.goToEditProfileView,
              ),
              SettingsListTile(
                title: 'Change Password',
                onTap: model.goToResetPasswordView,
              ),
              verticalSpaceSmall,
              SettingsListTile(
                onTap: model.showComingSoon,
                icon: Icons.notifications,
                title: 'Notification',
              ),
              SettingsListTile(
                onSwitchTap: model.onNotificationSwitchChanged,
                isSwitch: true,
                switchValue: model.notificationSwitchValue,
                title: 'Notifications',
              ),
              SettingsListTile(
                onSwitchTap: model.onAppNotificationSwitchValue,
                isSwitch: true,
                switchValue: model.appNotificationSwitchValue,
                title: 'App Notifications',
              ),
              verticalSpaceSmall,
              SettingsListTile(
                onTap: model.showComingSoon,
                icon: Icons.more_rounded,
                title: 'More',
              ),
              SettingsListTile(
                title: 'Language',
                onTap: model.showComingSoon,
              ),
              SettingsListTile(
                title: 'Country',
                onTap: model.showComingSoon,
              ),
              verticalSpaceMedium,
              ResavationButton(
                onTap: () {
                  model.goToPropertyOwnerHomePageView();
                  model.updateUserType();
                },
                width: double.infinity,
                title: model.returnUserType()
                    ? 'Switch to Property Owner'
                    : 'Switch to User',
                borderColor: kBlack,
                titleColor: kBlack,
                buttonColor: kWhite.withOpacity(0.9),
              ),
              verticalSpaceLarge,
              ListTile(
                minLeadingWidth: 0,
                horizontalTitleGap: 5,
                onTap: model.logout,
                dense: true,
                contentPadding: EdgeInsets.all(0),
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
              verticalSpaceLarge,

            ],
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
    this.isSwitch = false,
    this.isTitle = false,
    this.switchValue = false,
    required this.title,
    this.onTap,
    this.onSwitchTap,
  }) : super(key: key);

  final IconData? icon;
  final bool isTitle;
  final bool isSwitch;
  final bool switchValue;
  final String title;
  final void Function()? onTap;
  final void Function(bool)? onSwitchTap;


  @override
  Widget build(BuildContext context) {
    bool hasIcon = icon != null;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Padding(
        padding: isSwitch
            ? EdgeInsets.only(top: 3, bottom: 3)
            : EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (hasIcon) ? Icon(icon) : horizontalSpaceMedium,
            horizontalSpaceSmall,
            Expanded(
              child: Text(
                title,
                style: hasIcon
                    ? AppStyle.kBodyRegularBlack14W500
                    : AppStyle.kBodyRegularBlack14,
              ),
            ),
            horizontalSpaceSmall,
            if (isSwitch)
              Switch(
                value: switchValue,
                onChanged: onSwitchTap,
              )
          ],
        ),
      ),
    );
  }
}
