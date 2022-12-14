// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/filter_display/filter_display_viewmodel.dart';
import 'package:resavation/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SortProperty extends ViewModelWidget<SearchViewModel> {
  const SortProperty(
      {Key? key,
      required this.noOfProperties,
      this.sortByTitle = '',
      this.onSortByTap,
      s})
      : super(key: key);

  final int noOfProperties;
  final String sortByTitle;
  final void Function()? onSortByTap;

  @override
  Widget build(BuildContext context, model) {
    return Row(
      children: [
        Text(
          noOfProperties.toString(),
          style: AppStyle.kSubHeading.copyWith(
            color: kPrimaryColor,
          ),
        ),
        Text(
          ' Properties',
          style: AppStyle.kSubHeading,
        ),
        Spacer(),
        /*       DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              "sort by",
              style: AppStyle.kBodySmallRegular,
            ),
            items: model.items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: model.sortByType,
            onChanged: (value) {
              model.onSortByChanged(value);
            },
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
            ),
          ),
        ) */
      ],
    );
  }
}

class SortProperty2 extends ViewModelWidget<FilterDisplayViewModel> {
  const SortProperty2(
      {Key? key,
      required this.noOfProperties,
      this.sortByTitle = '',
      this.onSortByTap,
      s})
      : super(key: key);

  final int noOfProperties;
  final String sortByTitle;
  final void Function()? onSortByTap;

  @override
  Widget build(BuildContext context, model) {
    return Row(
      children: [
        Text(
          noOfProperties.toString(),
          style: AppStyle.kSubHeading.copyWith(
            color: kPrimaryColor,
          ),
        ),
        Text(
          ' Properties',
          style: AppStyle.kSubHeading,
        ),
        Spacer(),

        /*       DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              "sort by",
              style: AppStyle.kBodySmallRegular,
            ),
            items: model.items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: model.sortByType,
            onChanged: (value) {
              model.onSortByChanged(value);
            },
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
            ),
          ),
        ) */
      ],
    );
  }
}
