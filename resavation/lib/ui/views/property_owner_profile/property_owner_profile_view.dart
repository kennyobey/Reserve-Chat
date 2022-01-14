import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_profile/property_owner_profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PropertyOwnerProfileView extends StatelessWidget {
  const PropertyOwnerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(),
        body: Center(
          child: Text(
            'Property Owner Profile',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerProfileViewModel(),
    );
  }
}
