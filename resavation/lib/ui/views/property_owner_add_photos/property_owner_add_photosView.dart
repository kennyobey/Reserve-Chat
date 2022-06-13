// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: () async {
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
                  'Image(s) help prospective tenant imagine staying in your place\nYou can add as many image(s) as you want',
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

  final XFile image;
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
          child: Image.file(
            File(image.path),
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
              child: Image.file(
                File(image.path),
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
                clearImage();
              },
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.cancel_outlined, color: kWhite),
              ),
            ),
          ),
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
