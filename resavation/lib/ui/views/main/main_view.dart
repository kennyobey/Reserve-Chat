import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/views/favorite/favorite_view.dart';
import 'package:resavation/ui/views/home/home_view.dart';
import 'package:resavation/ui/views/main/main_viewmodel.dart';
import 'package:resavation/ui/views/search/search_view.dart';
import 'package:resavation/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';

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
            child: getViewForIndex(model.currentIndex)),
        bottomNavigationBar: BottomNavigationBar(
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
                Icons.favorite_border,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: '',
            ),
          ],
        ),
      ),
      viewModelBuilder: () => MainViewModel(),
    );
  }
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return HomeView();
    case 1:
      return FavoriteView();
    case 2:
      return SearchView();
    case 3:
      return SettingsView();
    default:
      return HomeView();
  }
}
