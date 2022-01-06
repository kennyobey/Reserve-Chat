import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'Home View',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
