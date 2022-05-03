import 'dart:ui';

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
              Expanded(
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
                      buildFacilitiesCount(),
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
              ),
              verticalSpaceSmall,
              ResavationButton(
                title: 'Apply',
                width: double.infinity,
                onTap: model.goToMainView,
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => FilterViewModel(),
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

  Visibility buildFacilitiesCount() {
    return Visibility(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FacilityNumber(
            num: "1",
          ),
          FacilityNumber(
            num: "2",
          ),
          FacilityNumber(
            num: "3",
          ),
          FacilityNumber(
            num: "4",
          ),
          FacilityNumber(
            num: "5",
          ),
          FacilityNumber(
            num: "6",
          ),
          FacilityNumber(
            num: "+",
          )
        ],
      ),
    );
  }

  Padding buildFacilities(FilterViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FacilityCard(
            icon: Icons.bed_outlined,
            isSelected: model.isFacilitySelected(0),
            onTap: () => model.onSelectFacilityTap(0),
          ),
          FacilityCard(
            icon: Icons.bathtub_outlined,
            isSelected: model.isFacilitySelected(1),
            onTap: () => model.onSelectFacilityTap(1),
          ),
          FacilityCard(
            icon: Icons.car_rental,
            isSelected: model.isFacilitySelected(2),
            onTap: () => model.onSelectFacilityTap(2),
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
      label: '${model.sliderValue.round()} sqft',
      max: 3000,
      value: model.sliderValue,
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
          items: model.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: AppStyle.kBodyRegular,
                    ),
                  ))
              .toList(),
          value: model.selectedValue,
          onChanged: (value) {
            model.onSelectedValueChange(value);
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

class FacilityNumber extends StatelessWidget {
  final String num;

  FacilityNumber({required this.num});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: kBlack10, width: 1.0)),
      width: 40,
      height: 40,
      child: Center(
          child: Text(
        num,
        style: AppStyle.kBodySmallRegular12W500,
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
    ListTile(
      title: Text(
        title,
      ),
      trailing: Radio<Availability>(
        value: value,
        groupValue: model.duration,
        onChanged: model.onDurationChanged,
      ),
    );

    final isActive =
        (model.duration.name.toLowerCase() == value.name.toLowerCase());
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
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color:
                    (isActive) ? kBlack.withOpacity(0.3) : Colors.transparent,
                blurRadius: 0.5,
                offset: Offset(3, 3),
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
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  final void Function()? onTap;
  final IconData? icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: isSelected ? kPrimaryColor : kWhite,
        ),
        height: 45,
        width: 65,
        child: Icon(
          icon,
          size: 25,
          color: isSelected ? kWhite : kBlack,
        ),
      ),
    );
  }
}
