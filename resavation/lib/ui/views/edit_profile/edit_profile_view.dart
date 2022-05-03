import 'dart:io';

import 'package:badges/badges.dart';
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
    var file = File(imageUrl);
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
}
