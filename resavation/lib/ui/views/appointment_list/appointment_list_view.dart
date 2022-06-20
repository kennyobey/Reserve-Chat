import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/appointment_booking/appointment_booking_viewmodel.dart';
import 'package:resavation/ui/views/appointment_list/appointment_list_viewmodel.dart';

import 'package:stacked/stacked.dart';

import '../../../model/appointment.dart';
import '../../shared/colors.dart';
import '../home/widget/home_user_appointment.dart';

class AppointmentListView extends StatelessWidget {
  const AppointmentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentListViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: buildAppBar(),
          body: buildBody(model, context),
        );
      },
      viewModelBuilder: () => AppointmentListViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Appointments",
      centerTitle: false,
    );
  }

  Column buildErrorBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occurred with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Column buildEmptyBody(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'No appointments yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly check back later for updates on your appointments',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Center buildLoadingWidget() {
    return const Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

  Padding buildBody(AppointmentListViewModel model, BuildContext context) {
    final userAppointments = model.userAppointments;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          verticalSpaceTiny,
          const Divider(),
          Row(
            children: [
              Text(
                userAppointments.length.toString(),
                style: AppStyle.kSubHeading.copyWith(
                  color: kPrimaryColor,
                ),
              ),
              Text(
                ' Appointment(s)',
                style: AppStyle.kSubHeading,
              ),
              Spacer(),
            ],
          ),
          const Divider(),
          verticalSpaceSmall,
          Expanded(
            child: buildBodyItem(userAppointments, model, context),
          ),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  showItemDialog(Appointment appointment, BuildContext context) async {
    Widget continueButton = TextButton(
      child: Text("Okay"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    String content = '';

    if (appointment.status == AppointmentStatus.Declined) {
      content =
          'Your appointment with ${appointment.landOwnerName} on  ${getFormattedTime(appointment.appointmentDate ?? 0)}, ${getAppointmentHour(appointment.appointmentStartTime ?? 0)}-${getAppointmentHour(appointment.appointmentEndTime ?? 0)} for the propery at ${appointment.location} was declined';
    } else if (appointment.status == AppointmentStatus.Passed) {
      content =
          'Your appointment with ${appointment.landOwnerName} on  ${getFormattedTime(appointment.appointmentDate ?? 0)}, ${getAppointmentHour(appointment.appointmentStartTime ?? 0)}-${getAppointmentHour(appointment.appointmentEndTime ?? 0)} for the propery at ${appointment.location} has passed';
    } else if (appointment.status == AppointmentStatus.Booked) {
      content =
          'Your appointment with ${appointment.landOwnerName} on  ${getFormattedTime(appointment.appointmentDate ?? 0)}, ${getAppointmentHour(appointment.appointmentStartTime ?? 0)}-${getAppointmentHour(appointment.appointmentEndTime ?? 0)} for the propery at ${appointment.location} has been approved';
    } else if (appointment.status == AppointmentStatus.Pending) {
      content =
          'Your appointment with ${appointment.landOwnerName} on  ${getFormattedTime(appointment.appointmentDate ?? 0)}, ${getAppointmentHour(appointment.appointmentStartTime ?? 0)}-${getAppointmentHour(appointment.appointmentEndTime ?? 0)} for the propery at ${appointment.location} is pending, please check back later for updated information';
    }

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      titlePadding: EdgeInsets.only(left: 8, top: 8, right: 8),
      contentPadding: EdgeInsets.only(left: 8, right: 8, top: 5),
      title: Text("Appointment Details"),
      content: Text(content),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return result;
  }

  Widget buildBodyItem(List<Appointment> userAppointments,
      AppointmentListViewModel model, BuildContext context) {
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasErrorOnData) {
      return buildErrorBody(context);
    } else if (userAppointments.isEmpty) {
      return buildEmptyBody(context);
    } else {
      return ListView.builder(
        itemBuilder: (_, index) {
          final appointment = userAppointments[index];
          return HomeAppointmentItem(
            appointment: appointment,
            onPressed: () async {
              showItemDialog(appointment, context);
            },
          );
        },
        padding: const EdgeInsets.all(0),
        physics: const BouncingScrollPhysics(),
        itemCount: userAppointments.length,
      );
    }
  }
}
