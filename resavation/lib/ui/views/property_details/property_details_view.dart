import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/filter/filter_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PropertyDetailsView extends StatelessWidget {
  const PropertyDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
            // title: "Filter",
            ),
        body: Center(
          child: Text(
            'Filter View',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => FilterViewModel(),
    );
  }
}
