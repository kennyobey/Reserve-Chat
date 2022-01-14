import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/map/map_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(),
        body: Center(
          child: Text(
            'Map View',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => MapViewModel(),
    );
  }
}
