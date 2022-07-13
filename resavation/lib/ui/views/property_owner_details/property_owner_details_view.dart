// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_details/property_owner_details_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/resavation_app_bar.dart';

class PropertyOwnerDetailsView extends StatefulWidget {
  const PropertyOwnerDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  State<PropertyOwnerDetailsView> createState() =>
      _PropertyOwnerDetailsViewState();
}

class _PropertyOwnerDetailsViewState extends State<PropertyOwnerDetailsView> {
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

  showSavePropertyDialog(PropertyOwnerDetailsViewModel model) async {
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
      await model.saveStage2Data();

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

  showSucessDialog(PropertyOwnerDetailsViewModel model) async {
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

  Column buildErrorBody() {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occurred while fetching data, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Center buildLoadingWidget() {
    return const Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerDetailsViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: ResavationAppBar(
            title: "Details",
            centerTitle: false,
            backEnabled: false,
            actions: [
              IconButton(
                  onPressed: () async {
                    if (model.selectedState != null) {
                      if (model.uploadFormKey.currentState!.validate()) {
                        bool shouldSave = await showSaveConfirmationDialog();
                        if (shouldSave) {
                          showSavePropertyDialog(model);
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please pick your state'),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.save_rounded,
                    color: kPrimaryColor,
                  ))
            ],
          ),
          backgroundColor: Colors.white,
          body: model.isLoading
              ? buildLoadingWidget()
              : model.hasErrorOnData
                  ? buildErrorBody()
                  : buildBody(model),
          bottomSheet: buildBottomSheet(context, model),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerDetailsViewModel(),
    );
  }

  Padding buildBottomSheet(
      BuildContext context, PropertyOwnerDetailsViewModel model) {
    return Padding(
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
          model.isLoading || model.hasErrorOnData
              ? SizedBox()
              : horizontalSpaceMedium,
          model.isLoading || model.hasErrorOnData
              ? SizedBox()
              : Expanded(
                  child: ResavationElevatedButton(
                      child: Text("Next"),
                      onPressed: () async {
                        if (model.selectedState != null) {
                          if (model.uploadFormKey.currentState!.validate()) {
                            model.goToPropertyOwnerAddPhotosView();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please pick your state'),
                            ),
                          );
                        }
                      }),
                )
        ],
      ),
    );
  }

  SingleChildScrollView buildBody(PropertyOwnerDetailsViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Form(
        key: model.uploadFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Name',
              style: AppStyle.kBodySmallRegular12W500,
            ),
            verticalSpaceTiny,
            ResavationTextField(
              hintText: '',
              fillColors: Colors.white,
              textInputAction: TextInputAction.next,
              controller: model.propertyNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter property name';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'Property Description',
              style: AppStyle.kBodySmallRegular12W500,
            ),
            verticalSpaceTiny,
            ResavationTextField(
              hintText: '',
              fillColors: Colors.white,
              maxline: null,
              textInputAction: TextInputAction.newline,
              controller: model.propertyDescriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter property description';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'Address',
              style: AppStyle.kBodySmallRegular12W500,
            ),
            verticalSpaceTiny,
            ResavationTextField(
              hintText: 'Enter the address of this space',
              fillColors: Colors.white,
              textInputAction: TextInputAction.next,
              controller: model.propertyAddressController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter property address';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'Surface Area',
              style: AppStyle.kBodySmallRegular12W500,
            ),
            verticalSpaceTiny,
            ResavationTextField(
              hintText: 'Enter the surface area of this space',
              fillColors: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: model.surfaceAreaController,
              validator: (value) {
                final area = double.tryParse(value ?? '');
                if (value == null || value.isEmpty) {
                  return 'Please enter surface area';
                } else if (area == null) {
                  return 'Please enter a valid surfce area';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'City',
              style: AppStyle.kBodySmallRegular12W500,
            ),
            verticalSpaceTiny,
            ResavationTextField(
              hintText: 'City',
              fillColors: Colors.white,
              textInputAction: TextInputAction.next,
              controller: model.propertyCityController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter city';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            Text(
              'State',
              style: AppStyle.kBodySmallRegular12W500,
            ),
            verticalSpaceTiny,
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text(
                  "Select State",
                  style: AppStyle.kBodyRegular,
                ),
                items: model.states
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: AppStyle.kBodyRegular,
                        ),
                      ),
                    )
                    .toList(),
                value: model.selectedState,
                onChanged: (value) {
                  model.onStateChanged(value);
                },
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
                ),
              ),
            ),
            /*  ResavationTextField(
                  hintText: 'State',
                  fillColors: Colors.white,
                  textInputAction: TextInputAction.next,
                  controller: model.propertyStateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter state';
                    }
                    return null;
                  },
                ), */
            /*       verticalSpaceSmall,
                Text(
                  'Generate your address on Google map',
                  style: AppStyle.kBodySmallRegular12W500,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ResavationElevatedButton(
                    child: Text("Go to Map"),
                    onPressed: () {
                      model.goToMapView();
                    },
                  ),
                ), */
            verticalSpaceMassive,
          ],
        ),
      ),
    );
  }
}
