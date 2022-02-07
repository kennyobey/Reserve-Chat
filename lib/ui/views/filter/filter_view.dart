import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
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
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: ResavationAppBar(
            title: "Filter",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 15,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpaceSmall,
                        Text(
                          'Property Type',
                          style: AppStyle.kBodyBold,
                        ),
                        verticalSpaceMedium,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Select Property',
                                style: AppStyle.kBodyBold,
                              ),
                            ),
                            Expanded(
                              child: DropdownButton<String>(
                                value: model.propertyValue,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                isExpanded: true,
                                style: AppStyle.kBodyBold.copyWith(color: kBlack),
                                underline: Container(
                                  // height: 0,
                                  color: Colors.transparent,
                                ),
                                onChanged: model.onDropdownButtonSelect,
                                items: <String>[
                                  'Flat',
                                  'Bungalow',
                                  'Self Contain',
                                ].map<DropdownMenuItem<String>>((
                                  String value,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Price Range',
                          style: AppStyle.kBodyBold,
                        ),
                        verticalSpaceMedium,
                        RangeSlider(
                          divisions: 10,
                          activeColor: kPrimaryColor,
                          inactiveColor: kGray,
                          onChanged: model.onRangeSliderChanged,
                          labels: model.rangeLabels,
                          values: model.rangeValue,
                          max: 1000000,
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Surface area',
                          style: AppStyle.kBodyBold,
                        ),
                        verticalSpaceMedium,
                        Slider(
                          divisions: 9,
                          activeColor: kPrimaryColor,
                          inactiveColor: kGray,
                          label: '${model.sliderValue.round()} sqft',
                          max: 3000,
                          value: model.sliderValue,
                          onChanged: model.onSliderChanged,
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Facilities',
                          style: AppStyle.kBodyBold,
                        ),
                        verticalSpaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FacilityCard(
                              icon: Icons.bedroom_parent,
                            ),
                            FacilityCard(
                              icon: Icons.bathroom,
                            ),
                            FacilityCard(
                              icon: Icons.toys,
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Availability',
                          style: AppStyle.kBodyBold,
                        ),
                        verticalSpaceSmall,
                        Column(
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
                        ),
                        verticalSpaceSmall,
                      ],
                    ),
                  ),
                ),
                verticalSpaceSmall,
                ResavationButton(
                  title: 'Apply',
                  onTap: model.goToSearchView,
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => FilterViewModel(),
    );
  }
}

class AvailabilityListTile extends ViewModelWidget<FilterViewModel> {
  const AvailabilityListTile({required this.title, required this.value});
  final String title;
  final Availability value;

  @override
  Widget build(BuildContext context, model) {
    return ListTile(
      title: Text(title),
      trailing: Radio<Availability>(
        value: value,
        groupValue: model.duration,
        onChanged: model.onDurationChanged,
      ),
    );
  }
}

class FacilityCard extends StatelessWidget {
  const FacilityCard({
    Key? key,
    this.icon,
    this.onTap,
  }) : super(key: key);

  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: kPrimaryColor,
        ),
        height: 60,
        width: 70,
        child: Icon(
          icon,
          size: 30,
          color: kWhite,
        ),
      ),
    );
  }
}
