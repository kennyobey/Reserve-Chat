// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:stacked/stacked.dart';
import '../../shared/dump_widgets/resavation_button.dart';
import 'property_owner_tracklisViewModel.dart';

class PropertyOwnerTrackListView extends StatelessWidget {
  const PropertyOwnerTrackListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerTrackListViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Text(
                  'Transaction List',
                  style: AppStyle.kBodyBold,
                ),
                verticalSpaceMedium,
                Row(
                  children: [
                    Text(
                      'Sortby',
                      style: AppStyle.kBodySmallRegular11W400,
                    ),
                    Spacer(),
                    Text(
                      'Status',
                      style: AppStyle.kBodySmallRegular11W400,
                    ),
                  ],
                ),
                verticalSpaceMedium,
                tableItems()
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerTrackListViewModel(),
    );
  }
}

List<Widget> buildPropertyStatus(PropertyOwnerTrackListViewModel model) {
  return [
    Text(
      'Property Status',
      style: AppStyle.kBodyRegular,
    ),
    verticalSpaceTiny,
    DropdownButtonHideUnderline(
      child: DropdownButton2(
          hint: Text(
            "Select Property Status",
            style: AppStyle.kBodyRegular,
          ),
          items: model.propertyStatus
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: AppStyle.kBodyRegular,
                    ),
                  ))
              .toList(),
          value: model.propertySearchValue,
          onChanged: (value) {},
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
    ),
  ];
}

Widget tableItems() {
  return DataTable(
    horizontalMargin: 10,
    columnSpacing: 5,
    columns: <DataColumn>[
      DataColumn(
        label: Text(
          'Order ID',
          style: AppStyle.kBodySmallRegular12W500,
        ),
      ),
      DataColumn(
        label: Text(
          ' Name',
          style: AppStyle.kBodySmallRegular12W500,
        ),
      ),
      DataColumn(
        label: Text(
          'Owner',
          style: AppStyle.kBodySmallRegular12W500,
        ),
      ),
      DataColumn(
        label: Text(
          'Status',
          style: AppStyle.kBodySmallRegular12W500,
        ),
      ),
    ],
    rows: <DataRow>[
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Mohit')),
          DataCell(Text('Mohit')),
          DataCell(Text('Associate Software Developer')),
          DataCell(Text('Associate Software Developer')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Akshay')),
          DataCell(Text('Mohit')),
          DataCell(Text('Software Developer')),
          DataCell(Text('Associate Software Developer')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Deepak')),
          DataCell(Text('Mohit')),
          DataCell(Text('Team Lead ')),
          DataCell(Text('Associate Software Developer')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Deepak')),
          DataCell(Text('Mohit')),
          DataCell(Text('Team Lead ')),
          DataCell(Text('Associate Software Developer')),
        ],
      ),
    ],
  );
}
