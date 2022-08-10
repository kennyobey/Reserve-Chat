import 'package:flutter/material.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_add_photos/property_owner_add_photosView.dart';
import 'package:resavation/ui/views/property_owner_amenities/property_owner_amenities_view.dart';

import 'package:stacked/stacked.dart';

import '../property_owner_payment/property_owner_payment_view.dart';
import 'property_owner_edit_viewmodel.dart';

class PropertyOwnerEditPropertyView extends StatefulWidget {
  final Property property;

  const PropertyOwnerEditPropertyView({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  State<PropertyOwnerEditPropertyView> createState() =>
      _PropertyOwnerEditPropertyViewState();
}

class _PropertyOwnerEditPropertyViewState
    extends State<PropertyOwnerEditPropertyView> {
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

  showLoadingData(BuildContext context) async {
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
              'Property Update',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Please be patient while we update your property.',
              textAlign: TextAlign.center,
              style: AppStyle.kBodyRegularBlack14,
            ),
          ],
        ),
      )),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Property Update",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerEditPropertyViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Edit Property",
          centerTitle: false,
          backEnabled: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property Description',
                style: AppStyle.kBodyRegularBlack16W600,
              ),
              verticalSpaceTiny,
              ResavationTextField(
                hintText: '',
                fillColors: Colors.white,
                maxline: null,
                focusNode: model.propertyDescriptionFocusNode,
                textInputAction: TextInputAction.newline,
                controller: model.propertyDescriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter property description';
                  }
                  return null;
                },
              ),
              verticalSpaceTiny,
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  child: Text(
                    'Update Property Description',
                  ),
                  onPressed: () async {
                    final isValid =
                        model.propertyDescriptionController.text.isNotEmpty;
                    if (!isValid) {
                      return;
                    }
                    model.propertyDescriptionFocusNode.unfocus();
                    showLoadingData(context);
                    try {
                      await model.updatePropertyDescription();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Update Successful'),
                        ),
                      );
                    } catch (exception) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'An error occurred with the property update, please try again later'),
                        ),
                      );
                    }
                  },
                ),
              ),
              verticalSpaceMedium,
              const Divider(),
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
                  color: Colors.grey,
                  foregroundColor: kBlack,
                  child: Text("Add New Amenity"),
                  onPressed: () {
                    showAddItemDialog(
                        'Add Amenity',
                        'Kindy specify the amenity at your structure.',
                        model.addAmenity);
                  },
                ),
              ),
              verticalSpaceTiny,
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  child: Text("Update Property Amenities"),
                  onPressed: () async {
                    showLoadingData(context);

                    try {
                      await model.updatePropertyAmenities();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Update Successful'),
                        ),
                      );
                    } catch (exception) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'An error occurred with the property update, please try again later'),
                        ),
                      );
                    }
                  },
                ),
              ),
              verticalSpaceMedium,
              const Divider(),
              verticalSpaceSmall,
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
                  child: Text("Add New Rule"),
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
              verticalSpaceTiny,
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  child: Text("Update Property Rules"),
                  onPressed: () async {
                    showLoadingData(context);

                    try {
                      await model.updatePropertyRules();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Update Successful'),
                        ),
                      );
                    } catch (exception) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'An error occurred with the property update, please try again later'),
                        ),
                      );
                    }
                  },
                ),
              ),
              verticalSpaceMedium,
              const Divider(),
              verticalSpaceSmall,
              Text(
                'Availiablity Periods',
                style: AppStyle.kBodyRegularBlack16W600,
              ),
              verticalSpaceTiny,
              Text(
                'Please specify your property\'s availability periods; your property will only be listed if the user date falls within the selected periods.',
                style: AppStyle.kBodyRegularBlack14,
              ),
              verticalSpaceSmall,
              DateContainer(
                label: 'Availability Period (Start)',
                initialDate: model.startDate,
                firstDate: model.initialDate,
                lastDate: DateTime(model.startDate.year + 5),
                onPressed: model.selectStartDate,
              ),
              verticalSpaceSmall,
              DateContainer(
                label: 'Availability Period (End)',
                initialDate: model.startDate,
                firstDate: model.startDate,
                lastDate: DateTime(model.startDate.year + 5),
                onPressed: model.selectEndDate,
              ),
              verticalSpaceSmall,
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  child: Text("Update Availiablity Period(s)"),
                  onPressed: () async {
                    if (model.startDate.millisecondsSinceEpoch ==
                            model.endDate.millisecondsSinceEpoch ||
                        model.startDate.millisecondsSinceEpoch >
                            model.endDate.millisecondsSinceEpoch) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Kindly update both the start and end availability date for your property'),
                        ),
                      );
                      return;
                    }
                    showLoadingData(context);

                    try {
                      await model.updatePropertyAvailiability();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Update Successful'),
                        ),
                      );
                    } catch (exception) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'An error occurred with the property update, please try again later'),
                        ),
                      );
                    }
                  },
                ),
              ),
              verticalSpaceMedium,
              const Divider(),
              verticalSpaceSmall,
              Text(
                'House Images(s)',
                style: AppStyle.kBodyRegularBlack16W600,
              ),
              verticalSpaceTiny,
              Text(
                'Image(s) help prospective tenant imagine staying in your place\nYou can add as many image(s) as you want',
                style: AppStyle.kBodyRegularBlack14,
              ),
              verticalSpaceMedium,
              GridView.builder(
                itemCount: model.selectedImages.length,
                padding: const EdgeInsets.only(left: 10, right: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1 / 1,
                  mainAxisSpacing: 0,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final image = model.selectedImages[index];
                  return ImageItem(
                    image: image,
                    clearImage: () => model.clearImage(image),
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  color: Colors.grey,
                  foregroundColor: kBlack,
                  child: Text("Add New Image"),
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
                ),
              ),
              verticalSpaceTiny,
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  child: Text("Update Property Images"),
                  onPressed: () async {
                    showLoadingData(context);

                    try {
                      await model.updatePropertyImages();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Update Successful'),
                        ),
                      );
                    } catch (exception) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'An error occurred with the property update, please try again later'),
                        ),
                      );
                    }
                  },
                ),
              ),
              verticalSpaceMedium,
              verticalSpaceMassive,
            ],
          ),
        ),
      ),
      viewModelBuilder: () =>
          PropertyOwnerEditPropertyViewModel(widget.property),
    );
  }
}
