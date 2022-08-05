import 'dart:io';

import 'package:badges/badges.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/model/edit_profile_model.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/edit_profile/edit_profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class EditProfileView extends StatefulWidget {
  final EditProfileModel? userProfile;
  const EditProfileView({Key? key, this.userProfile}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: buildBottomAppBar(model, context),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: buildBody(model, context),
        ),
      ),
      viewModelBuilder: () => EditProfileViewModel(widget.userProfile),
    );
  }

  SingleChildScrollView buildBody(
      EditProfileViewModel model, BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: model.editProfileFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUserImage(model, context),
            verticalSpaceSmall,
            const Divider(),
            verticalSpaceTiny,
            Text(
              'Personal Information Data',
              style: AppStyle.kHeading3,
            ),
            verticalSpaceTiny,
            const Divider(),
            verticalSpaceSmall,
            Text(
              'About Me',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            ResavationTextField(
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxline: null,
              hintText: '',
              hintTextStyle: AppStyle.kSubHeading,
              controller: model.aboutMeEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please write something about yourself';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'Phone Number',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            ResavationTextField(
              textInputAction: TextInputAction.next,
              hintText: '',
              hintTextStyle: AppStyle.kSubHeading,
              keyboardType: TextInputType.number,
              controller: model.phoneNumberEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'Gender',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            verticalSpaceTiny,
            buildGender(model),
            verticalSpaceMedium,
            Text(
              'Occupation',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            verticalSpaceTiny,
            buildOccupation(model),
            verticalSpaceMedium,
            Text(
              'Date Of Birth',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            verticalSpaceTiny,
            CalendarDatePicker(
              firstDate: DateTime(1900),
              initialDate: model.dateOfBirthInitialTime,
              lastDate: DateTime.now(),
              onDateChanged: model.setSelectedDOB,
            ),
            verticalSpaceSmall,
            const Divider(),
            verticalSpaceTiny,
            Text(
              'Personal Address Data',
              style: AppStyle.kHeading3,
            ),
            verticalSpaceTiny,
            const Divider(),
            verticalSpaceSmall,
            Text(
              'Country',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            ResavationTextField(
              textInputAction: TextInputAction.next,
              hintText: "",
              hintTextStyle: AppStyle.kSubHeading,
              controller: model.contryEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your country';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'State',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            ResavationTextField(
              textInputAction: TextInputAction.next,
              hintText: '',
              hintTextStyle: AppStyle.kSubHeading,
              controller: model.stateEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your state';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'City',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            ResavationTextField(
              textInputAction: TextInputAction.next,
              hintText: '',
              hintTextStyle: AppStyle.kSubHeading,
              controller: model.cityEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'Address',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            ResavationTextField(
              textInputAction: TextInputAction.next,
              hintText: "",
              hintTextStyle: AppStyle.kSubHeading,
              controller: model.addressEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'Postal Code',
              style: AppStyle.kBodyRegularBlack14W500,
            ),
            ResavationTextField(
              textInputAction: TextInputAction.next,
              hintText: "",
              hintTextStyle: AppStyle.kSubHeading,
              keyboardType: TextInputType.number,
              controller: model.postalCodeEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your postal code';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomAppBar(EditProfileViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: ResavationElevatedButton(
              child: Text('Cancel'),
              onPressed: model.goToUserProfileView,
            ),
          ),
          horizontalSpaceSmall,
          Expanded(
            child: ResavationElevatedButton(
              child: Text('Update'),
              onPressed: () async {
                final isValid =
                    model.editProfileFormKey.currentState?.validate();
                if ((isValid ?? false) == false || model.isLoading) {
                  return;
                }

                if (model.selectedGenderValue == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Kindly select your geneder.')),
                  );
                  return;
                }
                if (model.selectedOccupationValue == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Kindly select your occupation.'),
                    ),
                  );
                  return;
                }
                if (model.dateOfBirth == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Kindly select a valid Date Of Birth.'),
                    ),
                  );
                  return;
                }
                showSaveProfileDialog(model);
              },
            ),
          ),
        ],
      ),
    );
  }

  showSaveProfileDialog(EditProfileViewModel model) async {
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Material(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.blue,
                valueColor: AlwaysStoppedAnimation(kWhite),
              ),
            ),
            verticalSpaceMedium,
            Text(
              'Updating Profile',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Updating profile, please do not cancel until success',
              textAlign: TextAlign.center,
              style: AppStyle.kBodyRegularBlack14,
            ),
          ],
        ),
      )),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Updating Profile",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
    try {
      await model.editDetails();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your profile has successfully been updated')),
      );
      Navigator.of(context).pop();
    } catch (exception) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(exception.toString())),
      );
    }
  }

  Widget buildUserImage(EditProfileViewModel model, BuildContext context) {
    return Center(
      child: Badge(
        badgeColor: kWhite,
        position: BadgePosition.bottomEnd(),
        badgeContent: IconButton(
            icon: Icon(Icons.camera_alt_sharp),
            onPressed: () async {
              try {
                final imageLocation = await model.showFilePicker();
                model.updateImageLocation(imageLocation);
              } catch (exception) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(exception.toString())),
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
          child: model.isImageFile
              ? Image.file(
                  File(model.profileImage),
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                  errorBuilder: (ctx, _, __) => Container(
                    width: 150,
                    height: 150,
                    color: kLightBlue,
                  ),
                )
              : ResavationImage(
                  image: model.profileImage,
                ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: BackButton(
        color: Colors.black,
      ),
      title: Text(
        'Edit Profile',
        style: AppStyle.kHeading0,
      ),
    );
  }

  Widget buildGender(EditProfileViewModel model) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
          hint: Text(
            "Select Gender",
            style: AppStyle.kBodyRegular,
          ),
          items: model.gender
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: AppStyle.kBodyRegular,
                    ),
                  ))
              .toList(),
          value: model.selectedGenderValue,
          onChanged: (value) {
            model.onSelectedGender(value);
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          buttonWidth: double.infinity,
          buttonPadding: EdgeInsets.only(left: 18, right: 20),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black26,
            ),
          )),
    );
  }

  Widget buildOccupation(EditProfileViewModel model) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
          hint: Text(
            "Select Occupation",
            style: AppStyle.kBodyRegular,
          ),
          items: model.occupation
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: AppStyle.kBodyRegular,
                    ),
                  ))
              .toList(),
          value: model.selectedOccupationValue,
          onChanged: (value) {
            model.onSelectedOccupation(value);
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          buttonWidth: double.infinity,
          buttonPadding: EdgeInsets.only(left: 18, right: 20),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black26,
            ),
          )),
    );
  }
}
