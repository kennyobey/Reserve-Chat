import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/favorite/favorite_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'Favorite View',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => FavoriteViewModel(),
    );
  }
}
