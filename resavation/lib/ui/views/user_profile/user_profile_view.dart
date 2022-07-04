import 'dart:io';

import 'package:badges/badges.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/edit_profile/edit_profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'user_profile_viewModel.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            'User Profile',
            style: AppStyle.kHeading0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceSmall,
                      Center(
                        child: Badge(
                          badgeColor: kWhite,
                          position: BadgePosition.bottomEnd(),
                          badgeContent: ResavationButton(
                            fontSize: 13,
                            title: "Edit Profile",
                            height: 30,
                            width: 90,
                            onTap: () {
                              model.goToEditProfileView();
                            },
                          ),
                          child: Container(
                            width: 150,
                            height: 150,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: ResavationImage(
                              image: model.userData.imageUrl,
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceMedium,
                      ResavationButton(
                        width: MediaQuery.of(context).size.width,
                        title: 'Verify',
                        buttonColor: Colors.green,
                        borderColor: Colors.transparent,
                        titleColor: kWhite,
                        onTap: () {
                          model.goToVerificationPage();
                        },
                      ),
                      verticalSpaceMedium,
                      Text(
                        'Personal Information Data',
                        style: AppStyle.kHeading3,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Full legal first and middle names',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Stephen ',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Last names',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Adeyemo',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'About Me',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'I am a final student of Agric Science, Obafemi Awolowo University, Ile-ife, Nigeria.',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Date of birth',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'August 24, 1990',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Email',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'adeyemo********8@gmail.com',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Phone number',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        '07089898989',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Gender',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Male',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Occupation',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Student',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceMedium,
                      Text(
                        'Personal Address Data',
                        style: AppStyle.kHeading3,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Country',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Nigeria',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'State',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Oyo',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'City',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Ibadan',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Address',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        "No 1 Festus Idahosa Street, Molete, Ibadan.",
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Postal Code',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      Text(
                        '224466',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceMedium,
                      Text(
                        'Next of Kin Data',
                        style: AppStyle.kHeading3,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'First Name',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Stephen',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Last Name',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Adeyemo',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Email',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'adeyemo********8@gmail.com',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Phone number',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        '+2347088996756',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Gender',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Male',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Relationship',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Uncle',
                        style: AppStyle.kBodyRegularBlack14W500
                            .copyWith(color: kGray),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpaceMedium,
              // Row(
              //   children: [
              //     Expanded(
              //       child: ResavationButton(
              //         title: 'Cancel',
              //         onTap: model.goToMainView,
              //         buttonColor: kWhite,
              //         titleColor: kBlack,
              //         borderColor: kGray,
              //       ),
              //     ),
              //     horizontalSpaceSmall,
              //     Expanded(
              //       child: ResavationButton(
              //         title: 'Save',
              //         onTap: () async {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(
              //                 content: Text('Updating profile please wait')),
              //           );
              //           try {
              //             await model.updateProfile();
              //             ScaffoldMessenger.of(context).showSnackBar(
              //               SnackBar(content: Text('Profile Updated')),
              //             );
              //             model.goToMainView();
              //           } catch (exception) {
              //             ScaffoldMessenger.of(context).showSnackBar(
              //               SnackBar(content: Text(exception.toString())),
              //             );
              //           }
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
      viewModelBuilder: () => UserProfileViewModel(),
    );
  }

  showImageDialog(String imageUrl, EditProfileViewModel model) {
    final file = File(imageUrl);
    Dialog dialog = Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 280,
                  errorBuilder: (ctx, _, __) => const SizedBox(),
                ),
              ),
              verticalSpaceMedium,
              Text(
                'Do you want to set this image as your profile picture?',
                style: AppStyle.kBodyRegularBlack14,
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,
              ResavationButton(
                title: 'Continue',
                onTap: () async {
                  Navigator.of(context).pop();
                  try {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Processing request, please wait')),
                    );
                    await model.uploadDocument(file);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile updated successfully')),
                    );
                  } catch (exception) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(exception.toString())),
                    );
                  }
                },
              ),
              verticalSpaceSmall,
              ResavationButton(
                title: 'Cancel',
                buttonColor: Colors.transparent,
                borderColor: kPrimaryColor,
                titleColor: kPrimaryColor,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Image",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
  }

  Widget buildGender(EditProfileViewModel model) {
    String? selectedValue;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
          hint: Text(
            "Select your gender",
            style: AppStyle.kBodyRegular,
          ),
          items: model.gender
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: AppStyle.kBodyRegular,
                    ),
                  ))
              .toList(),
          value: model.gender,
          onChanged: (value) {},
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          buttonWidth: double.infinity,
          buttonPadding: EdgeInsets.only(left: 18, right: 20),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black26,
            ),
          )),
    );
  }
}
