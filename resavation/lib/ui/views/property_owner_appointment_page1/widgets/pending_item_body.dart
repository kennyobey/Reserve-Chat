import 'package:flutter/material.dart';
import 'package:resavation/model/appointment.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/views/appointment_booking/appointment_booking_viewmodel.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/colors.dart';

class PendingItemBody extends StatefulWidget {
  final List<Appointment> appointments;
  final Function(Appointment) onAccepted;
  final Function(Appointment) onDeclined;

  const PendingItemBody(
      {Key? key,
      required this.appointments,
      required this.onAccepted,
      required this.onDeclined})
      : super(key: key);

  @override
  State<PendingItemBody> createState() => _PendingItemBodyState();
}

class _PendingItemBodyState extends State<PendingItemBody> {
  @override
  Widget build(BuildContext context) {
    return widget.appointments.isEmpty
        ? buildEmptyBody(context)
        : ListView.builder(
            itemBuilder: (ctx, index) {
              final appointment = widget.appointments[index];
              return PendingItem(
                appointment: appointment,
                onPressed: () async {
                  final result = await showUpcominItemDialog(appointment);
                  if (result is bool) {
                    if (result) {
                      final shouldAccept = await showAcceptAppointmentDialog();
                      if (shouldAccept is bool && shouldAccept) {
                        widget.onAccepted(appointment);
                      }
                    } else {
                      final shouldDecline =
                          await showDeclineAppointmentDialog();
                      if (shouldDecline is bool && shouldDecline) {
                        widget.onDeclined(appointment);
                      }
                    }
                  }
                },
                onDeclined: () async {
                  final shouldDecline = await showDeclineAppointmentDialog();
                  if (shouldDecline is bool && shouldDecline) {
                    widget.onDeclined(appointment);
                  }
                },
                onAccepted: () async {
                  final shouldAccept = await showAcceptAppointmentDialog();
                  if (shouldAccept is bool && shouldAccept) {
                    widget.onAccepted(appointment);
                  }
                },
              );
            },
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            itemCount: widget.appointments.length,
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
          'There are currently no upcoming appointments',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  showUpcominItemDialog(Appointment appointment) async {
    Widget acceptButton = TextButton(
      child: Text("Accept"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
    Widget declineButton = TextButton(
      child: Text("Decline"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Appointment Details"),
      titlePadding: EdgeInsets.only(left: 8, top: 8, right: 8),
      contentPadding: EdgeInsets.only(left: 8, right: 8, top: 5),
      content: Text(
          'You have a pending appointment request from  ${appointment.tenantName} on  ${getFormattedTime(appointment.appointmentDate ?? 0)}, ${getAppointmentHour(appointment.appointmentStartTime ?? 0)}-${getAppointmentHour(appointment.appointmentEndTime ?? 0)} to check out your property at ${appointment.location}'),
      actions: [
        declineButton,
        acceptButton,
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

  showAcceptAppointmentDialog() async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Accept"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Accept Appointment"),
      titlePadding: EdgeInsets.only(left: 8, top: 8, right: 8),
      contentPadding: EdgeInsets.only(left: 8, right: 8, top: 5),
      content: Text(
          "Do you want to accept this  appointment for the specified time?"),
      actions: [
        cancelButton,
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

  showDeclineAppointmentDialog() async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Decline"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Decline Appointment"),
      content: Text("Do you want to decline this  appointment?"),
      titlePadding: EdgeInsets.only(left: 8, top: 8, right: 8),
      contentPadding: EdgeInsets.only(left: 8, right: 8, top: 5),
      actions: [
        cancelButton,
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
}

class PendingItem extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onPressed;
  final VoidCallback onAccepted;
  final VoidCallback onDeclined;
  const PendingItem(
      {Key? key,
      required this.appointment,
      required this.onPressed,
      required this.onAccepted,
      required this.onDeclined})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.propertyName ?? '',
                style: AppStyle.kBodyRegularBlack16W600,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${getFormattedTime(appointment.appointmentDate ?? 0)}, ${getAppointmentHour(appointment.appointmentStartTime ?? 0)}-${getAppointmentHour(appointment.appointmentEndTime ?? 0)}',
                style: AppStyle.kBodyRegularBlack14,
              ),
              verticalSpaceSmall,
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ResavationImage(
                      image: appointment.tenantImage ?? '',
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    child: Text(
                      appointment.tenantName ?? '',
                      style: AppStyle.kBodyRegularBlack14,
                    ),
                  ),
                  horizontalSpaceSmall,
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: onAccepted,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kGreen,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Accept',
                        style: AppStyle.kBodySmallRegular12
                            .copyWith(color: kWhite),
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: onDeclined,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Decline',
                        style: AppStyle.kBodySmallRegular12
                            .copyWith(color: kWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
