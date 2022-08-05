import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/filter/filter_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FilterView extends StatelessWidget {
  const FilterView({Key? key}) : super(key: key);
  Widget buildLoadingWidget() {
    return Center(
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

  Widget buildErrorBody(BuildContext context) {
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
          'An error occured while fetching data, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Filter",
        ),
        body: model.isLoading
            ? buildLoadingWidget()
            : model.hasErrorOnData
                ? buildErrorBody(context)
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 15,
                    ),
                    child: Column(
                      children: [
                        buildBody(model),
                        verticalSpaceSmall,
                        buildApplyButton(model, context)
                      ],
                    ),
                  ),
      ),
      viewModelBuilder: () => FilterViewModel(),
    );
  }

  Widget buildApplyButton(FilterViewModel model, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ResavationElevatedButton(
        child: Text('Apply'),
        onPressed: () {
          if (model.propertyStatus == null || model.propertyStatus == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'Please select the property type and status; all other parameters are optional. ')));
          } else {
            model.applyFilter();
          }
        },
      ),
    );
  }

  Expanded buildBody(FilterViewModel model) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Status',
              style: AppStyle.kBodyRegularW500,
            ),
            verticalSpaceSmall,
            buildPropertyStatus(model),
            verticalSpaceMedium,
            Text(
              'Property Type',
              style: AppStyle.kBodyRegularW500,
            ),
            verticalSpaceSmall,
            buildPropertyType(model),
            verticalSpaceMedium,
            Text(
              'Price Range',
              style: AppStyle.kBodyRegularW500,
            ),
            verticalSpaceSmall,
            buildPriceRange(model),
            verticalSpaceMedium,
            Text(
              'Surface Area',
              style: AppStyle.kBodyRegularW500,
            ),
            verticalSpaceSmall,
            buildSurfaceSlider(model),
            verticalSpaceMedium,
            Text(
              'Facilities',
              style: AppStyle.kBodyRegularW500,
            ),
            verticalSpaceSmall,
            buildFacilities(model),
            verticalSpaceMassive,
          ],
        ),
      ),
    );
  }

  Padding buildFacilities(FilterViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          FacilityCard(
            icon: Icons.bed_outlined,
            title: 'No of bedrooms',
            count: model.bedroomCount,
            onIncrement: () => model.onIncrement(0),
            onDecrement: () => model.onDecrement(0),
          ),
          FacilityCard(
            icon: Icons.bathtub_outlined,
            title: 'No of battub',
            count: model.batTubCount,
            onIncrement: () => model.onIncrement(1),
            onDecrement: () => model.onDecrement(1),
          ),
          FacilityCard(
            icon: Icons.car_rental,
            title: 'No of parking space',
            count: model.carCount,
            onIncrement: () => model.onIncrement(2),
            onDecrement: () => model.onDecrement(2),
          ),
        ],
      ),
    );
  }

  Slider buildSurfaceSlider(FilterViewModel model) {
    return Slider(
      divisions: 9,
      activeColor: kPrimaryColor,
      inactiveColor: kGray,
      label: '${model.surfaceArea.round()} sqft',
      max: 3000,
      value: model.surfaceArea,
      onChanged: model.onSliderChanged,
    );
  }

  RangeSlider buildPriceRange(FilterViewModel model) {
    return RangeSlider(
      divisions: 20,
      activeColor: kPrimaryColor,
      inactiveColor: kGray,
      onChanged: model.onRangeSliderChanged,
      labels: model.rangeLabels,
      values: model.rangeValue,
      max: 1000000,
    );
  }

  Widget buildPropertyStatus(FilterViewModel model) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          "Select Property Status",
          style: AppStyle.kBodyRegular,
        ),
        items: model.propertyStatusList
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
        value: model.propertyStatus,
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

  DropdownButtonHideUnderline buildPropertyType(FilterViewModel model) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
          hint: Text(
            "Select Property Type",
            style: AppStyle.kBodyRegular,
          ),
          items: model.propertyTypes
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: AppStyle.kBodyRegular,
                    ),
                  ))
              .toList(),
          value: model.propertyType,
          onChanged: (value) {
            model.onPropertyTypeChanged(value);
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          buttonWidth: double.infinity,
          buttonPadding: const EdgeInsets.only(left: 20, right: 20),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black26,
            ),
          )),
    );
  }
}

class FacilityCard extends StatelessWidget {
  const FacilityCard({
    Key? key,
    this.icon,
    required this.count,
    required this.title,
    required this.onDecrement,
    required this.onIncrement,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 23,
            color: kBlack,
          ),
          horizontalSpaceMedium,
          Expanded(
            child: Text(
              title,
              style: AppStyle.kBodyRegularBlack14,
            ),
          ),
          horizontalSpaceMedium,
          buildIcons(Icons.add_rounded, onIncrement),
          horizontalSpaceSmall,
          Text(
            count.toString(),
          ),
          horizontalSpaceSmall,
          buildIcons(Icons.remove_rounded, onDecrement),
        ],
      ),
    );
  }

  Widget buildIcons(IconData icon, VoidCallback onTap) {
    return InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Container(
          height: 22,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(3),
          width: 22,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Icon(
            icon,
            size: 18,
            color: Colors.grey,
          ),
        ));
  }
}
