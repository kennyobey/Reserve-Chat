// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_amenities/property_owner_amenities_viewModel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/resavation_app_bar.dart';
import '../../shared/dump_widgets/resavation_elevated_button.dart';
import '../../shared/dump_widgets/resavation_textfield.dart';

class PropertyOwnerAmenitiesView extends StatefulWidget {
  PropertyOwnerAmenitiesView({
    Key? key,
  }) : super(key: key);

  @override
  State<PropertyOwnerAmenitiesView> createState() =>
      _PropertyOwnerAmenitiesViewState();
}

class _PropertyOwnerAmenitiesViewState
    extends State<PropertyOwnerAmenitiesView> {
  List<bool>? amenities;

  List<bool>? rules;
  _PropertyOwnerAmenitiesViewState();
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

  showSavePropertyDialog(PropertyOwnerAmenitiesViewModel model) async {
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
      await model.saveStage5Data();

      Navigator.of(context).pop();
      showSaveSucessDialog(model);
    } catch (exception) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while saving your data'),
        ),
      );
    }
  }

  showSaveSucessDialog(PropertyOwnerAmenitiesViewModel model) async {
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAmenitiesViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Amenities and House Rules",
          centerTitle: false,
          backEnabled: false,
          actions: [
            TextButton(
              onPressed: () async {
                bool shouldSave = await showSaveConfirmationDialog();
                if (shouldSave) {
                  showSavePropertyDialog(model);
                }
              },
              child: Text(
                'SAVE',
                style: AppStyle.kBodyRegularBlack14.copyWith(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
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
                    child: Text("Upload"),
                    onPressed: () {
                      model.updateData();

                      showUploadItemDialog(model);
                    }),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              Text(
                'Amenities',
                style: AppStyle.kBodyRegularBlack16W600,
              ),
              verticalSpaceTiny,
              Text(
                'Kindly add the ameniteis availiable at your structure (if any). Examples of ammenities are wifi devices, air conditioning structures and swimming pools',
                style: AppStyle.kBodyRegularBlack14,
              ),
              verticalSpaceMedium,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemBuilder: (ctx, index) {
                  return AmenityItem(
                    item: model.amenities[index],
                    onDelete: model.deleteAmenity,
                  );
                },
                itemCount: model.amenities.length,
              ),
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  child: Text("Add new amenity"),
                  color: Colors.grey,
                  foregroundColor: kBlack,
                  onPressed: () {
                    showAddItemDialog(
                        'Add Amenity',
                        'Kindy specify the amenity at your structure.',
                        model.addAmenity);
                  },
                ),
              ),
              verticalSpaceMedium,
              const Divider(),
              verticalSpaceMedium,
              Text(
                'House Rule(s)',
                style: AppStyle.kBodyRegularBlack16W600,
              ),
              verticalSpaceTiny,
              Text(
                'Kindly specify any rules that apply to your current structure. i.e no pets allowed, no smocking and no loud partying',
                style: AppStyle.kBodyRegularBlack14,
              ),
              verticalSpaceMedium,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemBuilder: (ctx, index) {
                  return AmenityItem(
                    item: model.rules[index],
                    onDelete: model.deleteRule,
                  );
                },
                itemCount: model.rules.length,
              ),
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  child: Text("Add new rule"),
                  color: Colors.grey,
                  foregroundColor: kBlack,
                  onPressed: () {
                    showAddItemDialog(
                        'Add Rule',
                        'Kindly specify any rules that apply to your current structure.',
                        model.addRules);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAmenitiesViewModel(),
    );
  }

  showAddItemDialog(
      String title, String description, Function(String) onSaved) {
    final height = MediaQuery.of(context).size.height * 0.3;
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 5,
      child: Material(
        child: SizedBox(
          height: height,
          child: AmenityInputField(
            title: title,
            description: description,
            onSaved: onSaved,
          ),
        ),
      ),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Item Adder",
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

  showUploadItemDialog(PropertyOwnerAmenitiesViewModel model) async {
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
              'Property Upload',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Uploading property, please do not cancel until success',
              textAlign: TextAlign.center,
              style: AppStyle.kBodyRegularBlack14,
            ),
          ],
        ),
      )),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Upload Property",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    Reference sFirebaseStorageRef = FirebaseStorage.instance.ref();

    final List<String> images = [];

    final rawImages = model.uploadTypeService.selectedImages ?? [];

    for (final image in rawImages) {
      try {
        if (image.runtimeType == XFile) {
          final uniqueId = DateTime.now().millisecondsSinceEpoch;
          Reference firebaseStorageRef = sFirebaseStorageRef.child(
              'users/${model.userData.email}/productImages/${model.uploadTypeService.propertyName}/${model.uploadTypeService.propertyName}-$uniqueId');

          UploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));
          final TaskSnapshot taskSnapshot = await uploadTask;
          String url = await taskSnapshot.ref.getDownloadURL();
          images.add(url);
        } else {
          images.add(image);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error occurred uploading image(s)',
            ),
          ),
        );
      }
    }

    try {
      await model.httpService.uploadProperty(
          uploadTypeService: model.uploadTypeService, images: images);

      Navigator.of(context).pop();

      showSucessDialog(model);
    } catch (exception) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            exception.toString(),
          ),
        ),
      );
    }
  }

  showSucessDialog(PropertyOwnerAmenitiesViewModel model) async {
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
              'Property Uploaded',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Your property has been successfully posted and will be shown after it has been validated by the administrator. ',
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
}

class AmenityItem extends StatelessWidget {
  final String item;
  final Function(String) onDelete;

  const AmenityItem({
    Key? key,
    required this.item,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(item,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
                textAlign: TextAlign.start),
          ),
          horizontalSpaceSmall,
          InkWell(
              onTap: () => onDelete(item),
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              )),
        ],
      ),
    );
  }
}

class AmenityInputField extends StatefulWidget {
  final String title;
  final String description;
  final Function(String) onSaved;

  const AmenityInputField(
      {Key? key,
      required this.title,
      required this.description,
      required this.onSaved})
      : super(key: key);

  @override
  State<AmenityInputField> createState() => _AmenityInputFieldState();
}

class _AmenityInputFieldState extends State<AmenityInputField> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              widget.description,
              style: AppStyle.kBodyRegularBlack14,
            ),
            verticalSpaceMedium,
            ResavationTextField(
              textInputAction: TextInputAction.newline,
              maxline: null,
              controller: textController,
              hintTextStyle: AppStyle.kSubHeading,
            ),
            verticalSpaceMedium,
            SizedBox(
              width: double.infinity,
              child: ResavationElevatedButton(
                onPressed: () {
                  final text = textController.text.trim();
                  if (text.isNotEmpty) {
                    widget.onSaved(text);
                  }

                  Navigator.of(context).pop();
                },
                child: Text('Add Item'),
              ),
            )
          ],
        ));
  }
}
