// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_acceptbuttonViewItems/property_owner_acceptbuttonItemsViewModel.dart';

import 'package:resavation/utility/assets.dart';

import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/resavation_elevated_button.dart';
import '../../shared/dump_widgets/resavation_image.dart';

class PropertyOwnerAcceptbuttonItemsView extends StatelessWidget {
  const PropertyOwnerAcceptbuttonItemsView({Key? key, required String pageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAcceptbuttonItemsViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      AppointmentView(),
                      verticalSpaceMedium,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpaceTiny,
                          Text(
                            "Connecting you to the best tenant all over the world",
                            style: TextStyle(color: kWhite),
                          ),
                          verticalSpaceSmall,
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAcceptbuttonItemsViewModel(),
    );
  }
}

class AppointmentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //const maxLines = 5;

    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kGray,
        border: Border.all(color: kGray),
        borderRadius: new BorderRadius.circular(5.0),
        //color: kBlack,
      ),
      width: MediaQuery.of(context).size.width,
      height: 146.0,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Apointment Request',
                style: AppStyle.kBodyRegularBlack14W600,
              ),
              Text(
                '7 May 2022, 9:00 AM-10:10 AM',
                style: AppStyle.kSubHeading,
              ),
              Spacer(),
              Row(
                children: [
                  Image.asset(
                    Assets.profile_image4,
                    width: 40,
                    height: 40,
                  ),
                  horizontalSpaceTiny,
                  Text(
                    'Adeyemo',
                    style: AppStyle.kSubHeading,
                  ),
                  horizontalSpaceMedium,
                  FlatButton(
                    height: 5,
                    child: Text(
                      'Accept',
                      style: AppStyle.kSubHeading,
                    ),
                    color: kPrimaryColor,
                    textColor: kWhite,
                    onPressed: () {},
                  ),
                  horizontalSpaceSmall,
                  FlatButton(
                    height: 5,
                    child: Text(
                      'Decline',
                      style: AppStyle.kSubHeading,
                    ),
                    color: kWhite,
                    textColor: kBlack,
                    onPressed: () {},
                  ),
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }
}
