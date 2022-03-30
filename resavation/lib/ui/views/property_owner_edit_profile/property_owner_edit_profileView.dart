import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_edit_profile/property_owner_edit_profileViewModel.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class PropertyOwnerEditProfileView extends StatelessWidget {
  const PropertyOwnerEditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerEditProfileViewModel>.reactive(
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
                      'Save',
                      style: AppStyle.kBodySmallRegular12W500
                          .copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
                verticalSpaceMedium,
                Center(
                  child: GestureDetector(
                      child: CircleAvatar(
                        radius: 40, // Image radius
                        backgroundImage: AssetImage(Assets.profile_image),
                      ),
                      onTap: () {}),
                ),
                horizontalSpaceSmall,
                verticalSpaceMedium,
                Text(
                  'About me',
                  style: AppStyle.kBodyRegularBlack14W600,
                ),
                verticalSpaceMedium,
                _buildTextField(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    Text('50 characters remaining',
                        style: AppStyle.kBodySmallRegular12W500),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerEditProfileViewModel(),
    );
  }
}

Widget _buildTextField() {
  return Container(
    height: 70,
    width: 400,
    child: TextFormField(
        decoration: new InputDecoration(
      hintText:
          "I am a entrepenuer and keenly intrested in solving renting accomodation",
      hintStyle: AppStyle.kBodySmallRegular12W500,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(width: 5, color: kGray),
      ),
    )),
  );
}
