import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'widget/owner_space_items.dart';

class PropertyOwnerSpaceTypeView extends StatefulWidget {
  PropertyOwnerSpaceTypeView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerSpaceTypeView> createState() =>
      _PropertyOwnerSpaceTypeViewState();
}

class _PropertyOwnerSpaceTypeViewState
    extends State<PropertyOwnerSpaceTypeView> {
  final uploadFormKey = GlobalKey<FormState>();

  List<dynamic> subCategoriesMaster = [];
  List<dynamic> subCategories = [];

  String? CategoriesID;
  String? subCategoriesID;

  @override
  void initState() {
    super.initState;
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
    return ViewModelBuilder<PropertyOwnerSpaceTypeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(title: "Space Type"),
        body: model.isLoading
            ? buildLoadingWidget()
            : model.hasErrorOnData
                ? buildErrorBody()
                : buildBody(model),
      ),
      viewModelBuilder: () => PropertyOwnerSpaceTypeViewModel(),
    );
  }

  SingleChildScrollView buildBody(PropertyOwnerSpaceTypeViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Form(
        key: uploadFormKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              verticalSpaceSmall,
              Text(
                'Tell us about your property',
                style: AppStyle.kBodyRegularBlack15W500,
              ),
              verticalSpaceSmall,
              const Divider(),

              verticalSpaceSmall,
              buildPropertyStatus(model),
              verticalSpaceSmall,

              ...buildPropertyCategory(model),
              verticalSpaceSmall,

              buildPropertyType(model),

              verticalSpaceSmall,
              buildListingOptions(model),

              verticalSpaceSmall,
              const Divider(),
              verticalSpaceSmall,
              Text(
                'Narrow down your space type',
                style: AppStyle.kBodyRegularBlack15W500,
              ),
              verticalSpaceSmall,
              const Divider(),
              verticalSpaceSmall,
              ...buildSpaceServiced(model),
              verticalSpaceSmall,
              ...buildSpaceFurnished(model),

              verticalSpaceSmall,
              ...buildLiveInSpace(model),
              verticalSpaceMedium,
              buildNumberOfBedrooms(model),
              verticalSpaceSmall,
              //Select the number of bathrooms
              buildNumberOfBathrooms(model),
              verticalSpaceSmall,
              //Select the number of car slots
              buildNumberOfCarSlots(model),
              verticalSpaceMedium,
              buildButtons(context, model),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(
      BuildContext context, PropertyOwnerSpaceTypeViewModel model) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          'Next',
          style: AppStyle.kBodyRegular.copyWith(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.only(top: 5, bottom: 5),
        ),
        onPressed: () async {
          if (uploadFormKey.currentState!.validate()) {
            final bool isAllAdded = model.uploadTypeService.verifyStage1();
            if (isAllAdded) {
              model.goToPropertyOwnerDetailsView();
            } else {
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                const SnackBar(
                  content: Text('Kindly fill all the fields above to proceed'),
                ),
              );
            }
          }
        },
      ),
    );
  }

  AmenitiesSelection buildNumberOfCarSlots(
      PropertyOwnerSpaceTypeViewModel model) {
    return AmenitiesSelection(
      title: "Number of car slots",
      value: model.uploadTypeService.numberOfCarSLot,
      onPositiveTap: () => model.onPositiveCarSlotTap(),
      onNegativeTap: () => model.onNegativeCarSlotTap(),
    );
  }

  AmenitiesSelection buildNumberOfBathrooms(
      PropertyOwnerSpaceTypeViewModel model) {
    return AmenitiesSelection(
      title: "Number of bathrooms",
      value: model.uploadTypeService.noOfBathroom,
      onPositiveTap: () => model.onPositiveBathRoomTap(),
      onNegativeTap: () => model.onNegativeBathRoomTap(),
    );
  }

  AmenitiesSelection buildNumberOfBedrooms(
      PropertyOwnerSpaceTypeViewModel model) {
    return AmenitiesSelection(
      title: "Number Of bedrooms",
      value: model.noOfBedroom,
      onPositiveTap: () => model.onPositiveBedRoomTap(),
      onNegativeTap: () => model.onNegativeBedRoomTap(),
    );
  }

  List<Widget> buildLiveInSpace(PropertyOwnerSpaceTypeViewModel model) {
    return [
      Text(
        'Do you leave in this space',
        style: AppStyle.kBodyRegularBlack15W500,
      ),
      FilterListTile(
        selectedValue: model.liveInSpace,
        onChanged: model.setLiveInSpace,
      ),
    ];
  }

  Widget buildPropertyStatus(PropertyOwnerSpaceTypeViewModel model) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          "Select Property Status",
          style: AppStyle.kBodyRegular,
        ),
        items: model.propertyStatus
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
        value: model.uploadTypeService.propertyStatus,
        onChanged: (value) {
          model.onPropertyStatusValueChange(value);
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
    );
  }

  Widget buildListingOptions(PropertyOwnerSpaceTypeViewModel model) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
          hint: Text(
            "Select Style Option",
            style: AppStyle.kBodyRegular,
          ),
          items: model.propertyStyleOption
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: AppStyle.kBodyRegular,
                    ),
                  ))
              .toList(),
          value: model.propertyStyleValue,
          onChanged: (value) {
            model.onPropertyStyleValueChange(value);
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
          )),
    );
  }

  List<Widget> buildSpaceFurnished(PropertyOwnerSpaceTypeViewModel model) {
    return [
      Text(
        'Is your space furnished',
        style: AppStyle.kBodyRegularBlack15W500,
      ),
      FilterListTile(
        selectedValue: model.isSpaceFurnished,
        onChanged: model.setSpaceFurnished,
      ),
    ];
  }

  List<Widget> buildSpaceServiced(PropertyOwnerSpaceTypeViewModel model) {
    return [
      Text(
        'Is your space serviced',
        style: AppStyle.kBodyRegularBlack15W500,
      ),
      FilterListTile(
          selectedValue: model.isSpaceServiced,
          onChanged: model.setSpaceServiced),
    ];
  }

  Widget buildPropertyType(PropertyOwnerSpaceTypeViewModel model) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
          hint: Text(
            "Select Property",
            style: AppStyle.kBodyRegular,
          ),
          items: model.spaceType
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: AppStyle.kBodyRegular,
                    ),
                  ))
              .toList(),
          value: model.uploadTypeService.spaceType,
          onChanged: (value) {
            model.onSelectedSpaceTypeChange(value);
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
          )),
    );
  }

  List<Widget> buildPropertyCategory(PropertyOwnerSpaceTypeViewModel model) {
    return [
      DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            "Select Property Category",
            style: AppStyle.kBodyRegular,
          ),
          items: model.propertyCategories
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
          value: model.uploadTypeService.propertyCategory,
          onChanged: (value) {
            model.onPropertyCategoriesValueChange(value);
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
      verticalSpaceSmall,
      if (model.isCategoryEnabled)
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              "Select Property Type",
              style: AppStyle.kBodyRegular,
            ),
            items: model.getPropertyTypeList
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
            value: model.propertyTypeValue,
            onChanged: (value) {
              model.onPropertyTypeValueChange(value);
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
    ];
  }
}
