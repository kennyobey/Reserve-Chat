import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:stacked/stacked.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../shared/spacing.dart';
import '../../../../model/appointment.dart';
import '../../../shared/text_styles.dart';
import '../../appointment_booking/appointment_booking_viewmodel.dart';
import '../home_viewmodel.dart';
import 'items.dart';

class HomeUserAppointment extends ViewModelWidget<HomeViewModel> {
  const HomeUserAppointment({Key? key}) : super(key: key);

  Column buildErrorBody(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occured with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
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
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        Text(
          'No data!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'You curretly have no upcoming appointments',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget buildBody(HomeViewModel model) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: getTenantAppointments(model.userData.email),
      builder: ((context, asyncDataSnapshot) {
        if (asyncDataSnapshot.hasError) {
          return buildErrorBody(context);
        }

        if (asyncDataSnapshot.hasData) {
          final queryData = asyncDataSnapshot.data;
          final List<Appointment> userAppointments = queryData?.docs
                  .map(
                    (documentSnapshot) => Appointment.fromMap(
                      documentSnapshot.data(),
                    ),
                  )
                  .toList() ??
              [];

          return buildSuccessBody(userAppointments, model, context);
        } else {
          return buildLoadingWidget();
        }
      }),
    );
  }

  Widget buildLoadingWidget() {
    return Container(
      height: 300,
      width: double.infinity,
      alignment: Alignment.center,
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

  Widget buildSuccessBody(
      List<Appointment> allContent, HomeViewModel model, BuildContext context) {
    return allContent.isEmpty
        ? buildEmptyBody(context)
        : ListView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final appointment = allContent[index];
              return HomeAppointmentItem(
                appointment: appointment,
                onPressed: () async {
                  showItemDialog(appointment, context);
                },
              );
            },
            itemCount: allContent.length,
          );
  }

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleListTile(
          onTap: () {
            model.goToAppointmentList();
          },
          visibility: true,
          title: 'Your Appointments',
        ),
        verticalSpaceSmall,
        buildBody(model),
      ],
    );
  }
}

class HomeAppointmentItem extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onPressed;
  const HomeAppointmentItem(
      {Key? key, required this.appointment, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = appointment.status == AppointmentStatus.Declined
        ? Colors.red
        : appointment.status == AppointmentStatus.Passed
            ? Colors.blueGrey
            : appointment.status == AppointmentStatus.Booked
                ? Colors.green
                : kBlack;

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 1,
      margin: const EdgeInsets.only(left: 3, right: 3, bottom: 8),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.propertyName ?? '',
                style: AppStyle.kBodyRegularBlack15W500.copyWith(
                  color: color,
                ),
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Text(
                    '${getAppointmentHour(appointment.appointmentStartTime ?? 0)} - ${getAppointmentHour(appointment.appointmentEndTime ?? 0)}',
                    style: AppStyle.kBodyRegularBlack14W500.copyWith(
                      color: color,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    appointment.status.name,
                    style: AppStyle.kBodyRegularBlack14.copyWith(
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
