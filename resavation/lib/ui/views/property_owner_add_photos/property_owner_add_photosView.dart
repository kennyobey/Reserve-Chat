// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/chat_room/widgets/buttom_sheet_widget.dart';
import 'package:resavation/ui/views/property_owner_add_photos/property_owner_add_photosViewModel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerAddPhotosView extends StatelessWidget {
  PropertyOwnerAddPhotosView({Key? key}) : super(key: key);

  PlatformFile? get file => null;

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
                verticalSpaceRegular,
                ResavationButton(
                  onTap: () {
                    model.goToPropertyOwnerAddCoverPhotosView();
                  },
                  title: 'Add photos',
                  titleColor: kWhite,
                  buttonColor: kPrimaryColor,
                  //  borderColor: kp,
                ),
                // if (file != null) fileDetails(file!),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ResavationElevatedButton(
                  child: Text("Back"),
                  onPressed: () => Navigator.pop(context),
                ),
                // ResavationElevatedButton(
                //   child: Text("Next"),
                //   onPressed: () => model.goToPropertyOwnerAddCoverPhotosView(),
                // )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAddPhotosViewModel(),
    );
  }
}

// Widget fileDetails(PlatformFile file) {
//   final kb = file.size / 1024;
//   final mb = kb / 1024;
//   final size =
//       (mb >= 1) ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('File Name: ${file.name}'),
//         Text('File Size: $size'),
//         Text('File Extension: ${file.extension}'),
//         Text('File Path: ${file.path}'),
//       ],
//     ),
//   );
// }
