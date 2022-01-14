import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/booking_submission/booking_submission_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BookingSubmissionView extends StatelessWidget {
  const BookingSubmissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingSubmissionViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Booking Details",
        ),
        body: Center(
          child: Text(
            'Booking Submission',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => BookingSubmissionViewModel(),
    );
  }
}
