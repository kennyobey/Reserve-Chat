import 'package:flutter/material.dart';
import 'package:resavation/ui/views/main/main_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Main View'),
        ),
      ),
      viewModelBuilder: () => MainViewModel(),
    );
  }
}
