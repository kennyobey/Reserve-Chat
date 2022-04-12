// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_add_photos/property_owner_add_photosViewModel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerAddPhotosView extends StatelessWidget {
  PropertyOwnerAddPhotosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAddPhotosViewModel>.reactive(
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
                verticalSpaceMedium,
                Center(
                  child: Text(
                    'Add Photos',
                    style: AppStyle.kHeading0,
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  'Add photo to your listings',
                  style: AppStyle.kHeading0,
                ),
                verticalSpaceMedium,
                Text(
                  'Photos help prospective tenant imagine staying in your place',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                Text(
                  'You can add as many photo as you want',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                verticalSpaceMedium,
                ResavationButton(
                  // width: 140,
                  // height: 40,
                  onTap: () {
                    //model.addPhoto();
                    model.goToPropertyOwnerAddCoverPhotosView();
                  },
                  title: 'Add photos',
                  titleColor: kWhite,
                  buttonColor: kPrimaryColor,
                  //  borderColor: kp,
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAddPhotosViewModel(),
    );
  }
}
