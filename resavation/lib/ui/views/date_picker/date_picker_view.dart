import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/date_picker/date_picker_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DatePickerView extends StatelessWidget {
  const DatePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DatePickerViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Apply for rent",
        ),
        body: Center(
          child: Text(
            'Data Picker',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => DatePickerViewModel(),
    );
  }
}
