import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../views/main/main_viewmodel.dart';
import '../colors.dart';
import '../text_styles.dart';

class BottomNavBar extends ViewModelWidget<MainViewModel> {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  BottomNavigationBar buildBottomNavigationBar(MainViewModel model) {
    return BottomNavigationBar(
      selectedItemColor: kPrimaryColor,
      iconSize: 28,
      type: BottomNavigationBarType.fixed,
      currentIndex: model.currentIndex,
      onTap: model.setIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            model.returnUserType()
                ? Icons.favorite_border
                : Icons.calendar_view_month_outlined,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(model.returnUserType() ? Icons.search : Icons.analytics),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: '',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, MainViewModel model) {
    /*   var textTheme = Theme.of(context).textTheme;

    final bodyText2 =
    textTheme.bodyText2!.copyWith(fontSize: 16, color: kButtonColor);
*/
    return BottomNavigationBar(
      items: [
        buildItem(
          0,
          'Home',
          model,
          Icons.home,
        ),
        buildItem(
          1,
          model.returnUserType() ? 'Favourite' : 'Appointments',
          model,
          model.returnUserType()
              ? Icons.favorite_border
              : Icons.calendar_view_month_outlined,
        ),
        buildItem(2, model.returnUserType() ? 'Search' : 'Analytics', model,
            model.returnUserType() ? Icons.search : Icons.analytics),
        buildItem(3, 'Settings', model, Icons.settings_outlined),
      ],

      selectedItemColor: kPrimaryColor,
      iconSize: 26,
      // type: BottomNavigationBarType.fixed,
      currentIndex: model.currentIndex,
      onTap: model.setIndex,
      unselectedItemColor: const Color(0xffa19797),
      selectedFontSize: 16,
      selectedLabelStyle: AppStyle.kBodyRegularBlack14,
      unselectedLabelStyle: AppStyle.kBodyRegularBlack14,
      unselectedFontSize: 14,
      elevation: 5,
      // backgroundColor: kWhiteColor,
    );
  }

  BottomNavigationBarItem buildItem(
      int index, String title, MainViewModel controller, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: title,
    );
  }
}
