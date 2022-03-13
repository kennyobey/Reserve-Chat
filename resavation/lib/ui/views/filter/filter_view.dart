import 'package:flutter/cupertino.dart';
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
                          style: AppStyle.kHeading3,
                        ),
                        verticalSpaceMedium,
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton<String>(
                              value: model.propertyValue,
                              style: AppStyle.kBodyRegular,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              isExpanded: true,
                              underline: Container(
                                // height: 0,
                                color: Colors.transparent,
                              ),
                              onChanged: model.onDropdownButtonSelect,
                              items: <String>[
                                'Select Property',
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
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Price Range',
                          style: AppStyle.kBodyRegularBlack14W500,
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
                          style: AppStyle.kBodyRegularBlack14W500,
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
                          style: AppStyle.kBodyRegularBlack14W500,
                        ),
                        verticalSpaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FacilityCard(
                              icon: Icons.bed_outlined,
                              onTap: ()=> model.onSelectFacilityTap()
                            ),
                            FacilityCard(
                              icon: Icons.bathtub_outlined,
                            ),
                            FacilityCard(
                              icon: Icons.car_rental,
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        Visibility(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FacilityNumber(num: "1",
                              ),
                              FacilityNumber(num: "2",
                              ),
                              FacilityNumber(num: "3",
                              ),
                              FacilityNumber(num: "4",
                              ),
                              FacilityNumber(num: "5",
                              ),
                              FacilityNumber(num: "6",
                              ),
                              FacilityNumber(num: "+",
                              )
                            ],
                          ),
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Availability',
                          style: AppStyle.kBodyRegularBlack14W500,
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
                  onTap: model.goToMainView,
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

class FacilityNumber extends StatelessWidget {
  final String num;

  FacilityNumber({required this.num});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: kBlack10,
          width: 1.0
        )
      ),
      width: 31,
      height: 25,
      child: Center(child: Text(num, style: AppStyle.kBodySmallRegular12W500,)),
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
      title: Text(title, style: AppStyle.kBodyRegularBlack14,),
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
        height: 45,
        width: 65,
        child: Icon(
          icon,
          size: 25,
          color: kWhite,
        ),
      ),
    );
  }
}
