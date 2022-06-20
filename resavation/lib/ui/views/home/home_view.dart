import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'widget/home_top_categories.dart';
import 'widget/home_top_states.dart';
import 'widget/home_user_appointment.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(model),
        body: buildBody(model),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  SingleChildScrollView buildBody(HomeViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Find a\n',
              style: AppStyle.kHeading0.copyWith(color: kBlack, height: 1.5),
              children: [
                TextSpan(
                  text: 'Suitable Apartment',
                  style:
                      AppStyle.kHeading2.copyWith(color: kBlack, height: 1.5),
                ),
              ],
            ),
          ),
          verticalSpaceMedium,
          InkWell(
            onTap: () {
              model.setPositionAsSearch();
            },
            splashColor: Colors.transparent,
            child: AbsorbPointer(
              absorbing: true,
              child: FindYourLocation(
                onTap: () {},
                controller: null,
              ),
            ),
          ),
          verticalSpaceMedium,
          HomeTopCategories(),
          verticalSpaceMedium,
          HomeTopStates(),
          verticalSpaceMedium,
          HomeUserAppointment(),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  AppBar buildAppBar(HomeViewModel model) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Center(
        child: GestureDetector(
          onTap: model.goToEditProfileView,
          child: Container(
            height: 40,
            width: 40,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: ResavationImage(
              image: model.userData.imageUrl,
            ),
          ),
        ),
      ),
      title: Text(
        'Welcome ${model.userData.firstName.toUpperCase()}',
        style: AppStyle.kBodyRegularBlack14W600,
      ),
      actions: [
        IconButton(
          onPressed: () {
            model.goToMessage();
          },
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
