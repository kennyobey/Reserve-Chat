import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/edit_profile/edit_profile_viewmodel.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Edit Profile",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 15,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      Center(
                        child: Badge(
                          badgeColor: kWhite,
                          position: BadgePosition.bottomEnd(),
                          badgeContent: Icon(Icons.camera_alt_sharp),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage(Assets.profile_image),
                          ),
                        ),
                      ),
                      verticalSpaceMedium,
                      Text(
                        'Last Name',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: 'Ameh',
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'First Name',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: 'Queen',
                        hintTextStyle: AppStyle.kSubHeading,

                      ),
                      verticalSpaceSmall,
                      Text(
                        'Email',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ResavationTextField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'queenameh@gmail.com',
                              hintTextStyle: AppStyle.kSubHeading,

                            ),
                          ),
                          horizontalSpaceSmall,
                          GestureDetector(
                            onTap: model.showComingSoon,
                            child: Text(
                              'verify',
                              style: AppStyle.kBodyRegular.copyWith(
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Password',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        hintText: 'password',
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      horizontalSpaceMedium,
                    ],
                  ),
                ),
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  Expanded(
                    child: ResavationButton(
                      title: 'Cancel',
                      onTap: model.goToMainView,
                      buttonColor: kWhite,
                      titleColor: kBlack,
                      borderColor: kGray,
                    ),
                  ),
                  horizontalSpaceMedium,
                  Expanded(
                    child: ResavationButton(
                      title: 'Save',
                      onTap: model.goToMainView,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => EditProfileViewModel(),
    );
  }
}
