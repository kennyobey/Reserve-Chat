// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:resavation/app/app.router.dart';

import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_add_photos/property_owner_add_photosViewModel.dart';

import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/resavation_app_bar.dart';

class PropertyOwnerAddPhotosView extends StatefulWidget {
  PropertyOwnerAddPhotosView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerAddPhotosView> createState() =>
      _PropertyOwnerAddPhotosViewState();
}

class _PropertyOwnerAddPhotosViewState
    extends State<PropertyOwnerAddPhotosView> {
  Future<bool> showSaveConfirmationDialog() async {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Save property',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Do you wish to store your property for later editing? Your progress will be recovered when you upload again.',
              textAlign: TextAlign.start,
              style: AppStyle.kBodyRegularBlack14,
            ),
            verticalSpaceSmall,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Yes',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );

    final shouldShow = await showGeneralDialog<bool>(
      context: context,
      barrierLabel: "Save property confirmation",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
    if (shouldShow == null) {
      return false;
    } else {
      return shouldShow;
    }
  }

  showSavePropertyDialog(PropertyOwnerAddPhotosViewModel model) async {
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
              'Saving Property',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Saving property, please do not cancel until success',
              textAlign: TextAlign.center,
              style: AppStyle.kBodyRegularBlack14,
            ),
          ],
        ),
      )),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Saving Property",
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
      await model.saveStage3Data();

      Navigator.of(context).pop();
      showSucessDialog(model);
    } catch (exception) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while saving your data'),
        ),
      );
    }
  }

  showSucessDialog(PropertyOwnerAddPhotosViewModel model) async {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Saved',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Your property has been successfully saved and will be shown on your next property listing.',
              textAlign: TextAlign.start,
              style: AppStyle.kBodyRegularBlack14,
            ),
            verticalSpaceSmall,
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Okay',
                ),
              ),
            ),
          ],
        ),
      )),
    );

    await showGeneralDialog(
      context: context,
      barrierLabel: "Upload Property Success",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    model.uploadTypeService.clearStage1();
    model.navigationService.clearStackAndShow(Routes.mainView);
  }

  Column buildEmptyBody(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'No image(s) yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly click the add(+) button below',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAddPhotosViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () async {
            if (model.selectedImages.length >= 10) {
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                SnackBar(
                  content: Text(
                    "You can not add more than 10 images",
                  ),
                ),
              );
              return;
            }
            try {
              await model.addPhoto();
            } catch (exception) {
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                SnackBar(
                  content: Text(
                    exception.toString(),
                  ),
                ),
              );
            }
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ResavationElevatedButton(
                  child: Text("Back"),
                  color: Colors.grey,
                  foregroundColor: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              horizontalSpaceMedium,
              Expanded(
                child: ResavationElevatedButton(
                    child: Text("Next"),
                    onPressed: () {
                      if (model.selectedImages.isNotEmpty) {
                        model.goToPropertyOwnerPaymentView();
                      } else {
                        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                          SnackBar(
                            content: Text('Please select one or more images'),
                          ),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
        appBar: ResavationAppBar(
          title: "Add Image(s)",
          centerTitle: false,
          backEnabled: false,
          actions: [
            TextButton(
              onPressed: () async {
                if (model.selectedImages.isNotEmpty) {
                  bool shouldSave = await showSaveConfirmationDialog();
                  if (shouldSave) {
                    showSavePropertyDialog(model);
                  }
                } else {
                  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                    SnackBar(
                      content: Text('Please select one or more images'),
                    ),
                  );
                }
              },
              child: Text(
                'SAVE',
                style: AppStyle.kBodyRegularBlack14.copyWith(
                  color: kPrimaryColor,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              Text(
                'Add image(s) to your listings',
                style: AppStyle.kBodyRegularBlack16W600,
              ),
              verticalSpaceTiny,
              Text(
                'Image(s) help prospective tenant imagine staying in your place\nYou can add  up to 10 images of your property.',
                style: AppStyle.kBodyRegularBlack14,
              ),
              verticalSpaceMedium,
              Expanded(
                child: model.selectedImages.isEmpty
                    ? buildEmptyBody(context)
                    : GridView.builder(
                        itemCount: model.selectedImages.length,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 0,
                          childAspectRatio: 1 / 1,
                          mainAxisSpacing: 0,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          final image = model.selectedImages[index];
                          return ImageItem(
                            image: image,
                            clearImage: () => model.clearImage(image),
                          );
                        },
                      ),
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAddPhotosViewModel(),
    );
  }
}

class ImageItem extends StatelessWidget {
  const ImageItem({
    Key? key,
    required this.image,
    required this.clearImage,
  }) : super(key: key);

  final dynamic image;
  final Function() clearImage;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 1,
      child: InkWell(
        onTap: () => showImage(context),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: image.runtimeType == XFile
              ? Image.file(
                  File(image.path),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  showImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 5,
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: size.height * 0.8,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: PhotoView.customChild(
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2.5,
              child: image.runtimeType == XFile
                  ? Image.file(
                      File(image.path),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    )
                  : Image.network(
                      image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.cancel_outlined, color: kWhite),
              ),
            ),
          ),
          Positioned(
              bottom: 5,
              left: 10,
              right: 10,
              child: ResavationElevatedButton(
                child: Text('Remove Image'),
                onPressed: () {
                  Navigator.of(context).pop();
                  clearImage();
                },
              )),
        ],
      ),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Image Viewer",
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
