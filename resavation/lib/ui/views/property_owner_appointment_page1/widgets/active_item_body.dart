import 'package:flutter/material.dart';
import 'package:resavation/model/appointment.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/views/appointment_booking/appointment_booking_viewmodel.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/colors.dart';

class ActiveItemBody extends StatefulWidget {
  final List<Appointment> appointments;

  const ActiveItemBody({Key? key, required this.appointments})
      : super(key: key);

  @override
  State<ActiveItemBody> createState() => _ActiveItemBodyState();
}

class _ActiveItemBodyState extends State<ActiveItemBody> {
  @override
  Widget build(BuildContext context) {
    return widget.appointments.isEmpty
        ? buildEmptyBody(context)
        : ListView.builder(
            itemBuilder: (ctx, index) {
              final appointment = widget.appointments[index];
              return ActiveItem(
                appointment: appointment,
                onPressed: () => showActiveItemDialog(appointment),
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

  showActiveItemDialog(Appointment appointment) async {
    Widget continueButton = TextButton(
      child: Text("Okay"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      titlePadding: EdgeInsets.only(left: 8, top: 8, right: 8),
      contentPadding: EdgeInsets.only(left: 8, right: 8, top: 5),
      title: Text("Appointment Details"),
      content: Text(
          'You have an appointment with ${appointment.tenantName} on  ${getFormattedTime(appointment.appointmentDate ?? 0)}, ${getAppointmentHour(appointment.appointmentStartTime ?? 0)}-${getAppointmentHour(appointment.appointmentEndTime ?? 0)} to check out your property at ${appointment.location}'),
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
}

class ActiveItem extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onPressed;

  const ActiveItem(
      {Key? key, required this.appointment, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                    )),
                horizontalSpaceSmall,
                Expanded(
                  child: Text(
                    appointment.tenantName ?? '',
                    style: AppStyle.kBodyRegularBlack14,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    appointment.status.name,
                    style: AppStyle.kBodySmallRegular12.copyWith(color: kWhite),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
