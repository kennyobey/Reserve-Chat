import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/filter/filter_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FilterView extends StatelessWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Filter",
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 15,
          ),
          child: Column(
            children: [
              buildBody(model),
              verticalSpaceSmall,
              buildApplyButton(model)
            ],
          ),
        ),
      ),
      viewModelBuilder: () => FilterViewModel(),
    );
  }

  ResavationButton buildApplyButton(FilterViewModel model) {
    return ResavationButton(
      title: 'Apply',
      width: double.infinity,
      onTap: model.applyFilter,
    );
  }

  Expanded buildBody(FilterViewModel model) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            verticalSpaceMedium,
            Text(
              'Availability',
              style: AppStyle.kBodyRegularW500,
            ),
            verticalSpaceSmall,
            buildAvailabilityList(),
            verticalSpaceMassive,
          ],
        ),
      ),
    );
  }

  Column buildAvailabilityList() {
    return Column(
      children: [
        AvailabilityListTile(
          title: Availability.Shortlet.name,
          value: Availability.Shortlet,
        ),
        AvailabilityListTile(
          title: '6 Months',
          value: Availability.Months,
        ),
        AvailabilityListTile(
          title: 'Within 1Year',
          value: Availability.Year,
        ),
        AvailabilityListTile(
          title: 'More than 1Year',
          value: Availability.More,
        ),
      ],
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
      divisions: 10,
      activeColor: kPrimaryColor,
      inactiveColor: kGray,
      onChanged: model.onRangeSliderChanged,
      labels: model.rangeLabels,
      values: model.rangeValue,
      max: 1000000,
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

class AvailabilityListTile extends ViewModelWidget<FilterViewModel> {
  const AvailabilityListTile({required this.title, required this.value});

  final String title;
  final Availability value;

  @override
  Widget build(BuildContext context, model) {
    final isActive =
        (model.availibiality.name.toLowerCase() == value.name.toLowerCase());
    return GestureDetector(
      onTap: () {
        model.onDurationChanged(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.only(right: 20, left: isActive ? 20 : 10),
        margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: (isActive) ? kPrimaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color:
                    (isActive) ? kBlack.withOpacity(0.2) : Colors.transparent,
                blurRadius: 0.5,
                offset: Offset(1, 1),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppStyle.kBodyRegularBlack14
                  .copyWith(color: isActive ? kWhite : kBlack),
            ),
            Container(
              // margin: const EdgeInsets.only(right: 20),
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xff3e3e3e).withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(1.3),
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  color: (isActive) ? kSecondaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
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
          buildIcons(Icons.remove_circle, onDecrement),
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
            shape: BoxShape.circle,
            border: Border.all(color: kPrimaryColor, width: 1),
          ),
          child: Icon(
            icon,
            size: 20,
            color: kPrimaryColor,
          ),
        ));
  }
}
