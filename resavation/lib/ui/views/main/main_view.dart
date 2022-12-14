import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/views/favorite/favorite_view.dart';
import 'package:resavation/ui/views/home/home_view.dart';
import 'package:resavation/ui/views/main/main_viewmodel.dart';
// import 'package:resavation/ui/views/property_owner_analyticpage/property_owner_analyticView.dart';
import 'package:resavation/ui/views/property_owner_appointment_page1/property_owner_appointment_pageoneView.dart';
import 'package:resavation/ui/views/property_owner_homepage/property_owner_homepageView.dart';
import 'package:resavation/ui/views/property_owner_properties/property_owner_properties_view.dart';
import 'package:resavation/ui/views/search/search_view.dart';
import 'package:resavation/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/bottom_nav_bar.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            reverse: model.reverse,
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return SharedAxisTransition(
                child: child,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
              );
            },
            child: getViewForIndex(model.currentIndex, model.returnUserType())),
        bottomNavigationBar: BottomNavBar(),
      ),
      viewModelBuilder: () => MainViewModel(),
    );
  }
}

Widget getViewForIndex(int index, bool isTenant) {
  switch (index) {
    case 0:
      return isTenant ? HomeView() : PropertyOwnerHomePageView();
    case 1:
      return isTenant ? FavoriteView() : PropertyOwnerAppointmentPageoneView();
    case 2:
      return isTenant ? SearchView() : PropertyOwnerPropertiesView();
    // return isTenant ? SearchView() : PropertyOwnerAnalyticView();
    case 3:
      return SettingsView();
    default:
      return isTenant ? HomeView() : PropertyOwnerHomePageView();
  }
}
