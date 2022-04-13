// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_analyticpage/property_owner_analyticViewModel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerAnalyticView extends StatelessWidget {
  const PropertyOwnerAnalyticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAnalyticViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceMedium,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Analytics"),
                      Spacer(),
                      Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: kGray),
                          borderRadius: BorderRadius.circular(5.0),
                          color: kWhite,
                        ),
                        child: Center(child: Text("Jul-Oct")),
                      )
                    ],
                  ),
                  verticalSpaceMedium,
                  Text("Revenue", style: AppStyle.kBodyRegularBlack14W500),
                  verticalSpaceMedium,
                  Center(
                    child: Container(
                      height: 400,
                      width: 320,
                      decoration: BoxDecoration(
                        color: kWhite,
                        border: Border.all(color: kWhite),
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(child: Text("Chart")),
                    ),
                  ),
                  verticalSpaceRegular,
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: kGray),
                      borderRadius: BorderRadius.circular(5.0),
                      color: kPrimaryColor,
                    ),
                    width: 170,
                    height: 103,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpaceTiny,
                          Text(
                            "Payout",
                            style: TextStyle(color: kWhite),
                          ),
                          verticalSpaceSmall,
                          Text(
                            "#100,000",
                            style: TextStyle(color: kWhite),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpaceRegular,
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: kGray),
                      borderRadius: BorderRadius.circular(5.0),
                      color: kSecondaryColor,
                    ),
                    width: 170,
                    height: 103,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpaceTiny,
                          Text(
                            "Balance",
                            style: TextStyle(color: kWhite),
                          ),
                          verticalSpaceSmall,
                          Text(
                            "#100,000",
                            style: TextStyle(color: kWhite),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAnalyticViewModel(),
    );
  }
}

//kBodyRegularBlack14W500