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
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(Assets.profile_image),
                        ),
                      ),
                      verticalSpaceMedium,
                      Text(
                        'Last Name',
                        style: AppStyle.kBodyRegular,
                      ),
                      ResavationTextField(
                        hintText: 'Ameh',
                      ),
                      verticalSpaceSmall,
                      Text(
                        'First Name',
                        style: AppStyle.kBodyRegular,
                      ),
                      ResavationTextField(
                        hintText: 'Queen',
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Email',
                        style: AppStyle.kBodyRegular,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ResavationTextField(
                              hintText: 'queenameh@gmail.com',
                            ),
                          ),
                          horizontalSpaceSmall,
                          GestureDetector(
                            onTap: () {},
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
                        style: AppStyle.kBodyRegular,
                      ),
                      ResavationTextField(
                        obscureText: true,
                        hintText: 'password',
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
                      onTap: () {},
                      buttonColor: kWhite,
                      titleColor: kBlack,
                      borderColor: kGray,
                    ),
                  ),
                  horizontalSpaceMedium,
                  Expanded(
                    child: ResavationButton(
                      title: 'Save',
                      onTap: () {},
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
