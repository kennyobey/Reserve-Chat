import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';
import 'refresh_token_viewmodel.dart';

class RefreshTokenView extends StatelessWidget {
  const RefreshTokenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RefreshTokenViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.blue,
              valueColor: AlwaysStoppedAnimation(kWhite),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => RefreshTokenViewModel(),
    );
  }
}
