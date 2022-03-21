// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_identification_verification/property_owner_identification_verificationViewModel.dart';
import 'package:resavation/utility/assets.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerIdentificationVerificationView extends StatelessWidget {
  const PropertyOwnerIdentificationVerificationView({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<
        PropertyOwnerIdentificationVerificationViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    Text(
                      'Edit',
                      style: AppStyle.kBodySmallRegular12W500
                          .copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
                verticalSpaceMedium,
                Row(
                  children: [
                    GestureDetector(
                        child: CircleAvatar(
                          radius: 40, // Image radius
                          backgroundImage: AssetImage(Assets.profile_image),
                        ),
                        onTap: () {}),
                    horizontalSpaceSmall,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adeyemo Stephen',
                          style: AppStyle.kBodyRegularBlack14W600,
                        ),
                        Text(
                          'Joined in December 2021',
                          style: AppStyle.kBodySmallRegular12,
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpaceMedium,
                Row(
                  children: [
                    Text(
                      'Identity Verification',
                      style: AppStyle.kBodyRegularBlack14W600,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        model.goToPropertyOwnerVerificationView();
                      },
                      child: Text(
                        'Verify now',
                        style: AppStyle.kBodySmallRegular12W500
                            .copyWith(color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
                verticalSpaceMedium,
                Text(
                  'NIMC',
                  style: AppStyle.kBodySmallRegular12,
                ),
                verticalSpaceSmall,
                Text(
                  'Voters card',
                  style: AppStyle.kBodySmallRegular12,
                ),
                verticalSpaceSmall,
                Text(
                  'International Passpot',
                  style: AppStyle.kBodySmallRegular12,
                ),
                verticalSpaceSmall,
                Text(
                  'About',
                  style: AppStyle.kBodyRegularBlack14W600,
                ),
                verticalSpaceSmall,
                Text(
                  'Am a social entreprenuer and am keenly intrested in solving renting accomadtion in Nigeria',
                  style: AppStyle.kBodySmallRegular12,
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () =>
          PropertyOwnerIdentificationVerificationViewModel(),
    );
  }
}
