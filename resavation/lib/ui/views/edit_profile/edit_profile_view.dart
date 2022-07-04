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

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            'Edit Profile',
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
                          badgeContent: IconButton(
                              icon: Icon(Icons.camera_alt_sharp),
                              onPressed: () async {
                                try {
                                  final imageLocation =
                                      await model.showFilePicker();
                                  showImageDialog(imageLocation, model);
                                } catch (exception) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(exception.toString())),
                                  );
                                }
                              }),
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

                      verticalSpaceMedium,
                      Text(
                        'Personal Information Data',
                        style: AppStyle.kHeading3,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Last Name',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: model.userData.lastName,
                        controller: model.userLastNameController,
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'First Name',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: model.userData.firstName,
                        controller: model.userFirstNameController,
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'About Me',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "I am a student of UNIBEN",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Date of birth',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "22/01/2022",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Phone Number',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "2347032867019",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Gender',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      // buildGender(model),
                      // verticalSpaceSmall,
                      verticalSpaceSmall,
                      Text(
                        'Occupation',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceMedium,
                      Text(
                        'Personal Address Data',
                        style: AppStyle.kHeading3,
                      ),
                      Text(
                        'Country',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "Nigeria",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'State',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "Nigeria",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'City',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "Ibadan",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Address',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "No 1 Festus Idahosa Street, Molete, Ibadan.",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,

                      Text(
                        'Postal Code',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "224466",
                        hintTextStyle: AppStyle.kSubHeading,
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
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "Stephen",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,

                      Text(
                        'Last Name',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "Adeyemo",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
                      verticalSpaceSmall,

                      Text(
                        'Email',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "adeyemo********8@gmail.com",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),

                      verticalSpaceSmall,

                      Text(
                        'Phone number',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "+2347088996756",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),

                      verticalSpaceSmall,

                      Text(
                        'Gender',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "Male",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),

                      verticalSpaceSmall,

                      Text(
                        'Relationship',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      ResavationTextField(
                        textInputAction: TextInputAction.next,
                        hintText: "Uncle",
                        hintTextStyle: AppStyle.kSubHeading,
                      ),
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
                  horizontalSpaceSmall,
                  Expanded(
                    child: ResavationButton(
                      title: 'Save',
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Updating profile please wait')),
                        );
                        try {
                          await model.updateProfile();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Profile Updated')),
                          );
                          model.goToMainView();
                        } catch (exception) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(exception.toString())),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
      viewModelBuilder: () => EditProfileViewModel(),
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
