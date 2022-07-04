import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:stacked/stacked.dart';
import '../../../model/appointment.dart';
import '../../shared/colors.dart';
import '../../shared/dump_widgets/resavation_image.dart';
import '../../shared/spacing.dart';
import 'appointment_booking_viewmodel.dart';
import '../../shared/text_styles.dart';

class AppointmentBookingPage extends StatefulWidget {
  final AppointmentBookingDetails? appointmentBookingDetails;
  const AppointmentBookingPage({
    Key? key,
    this.appointmentBookingDetails,
  }) : super(key: key);

  @override
  State<AppointmentBookingPage> createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentBookingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: buildBody(model),
      ),
      viewModelBuilder: () => AppointmentBookingViewModel(),
    );
  }

  Widget buildBody(AppointmentBookingViewModel model) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    verticalSpaceSmall,
                    Text(
                      'Pick Appointment Date',
                      style: AppStyle.kBodyRegularBlack15W500,
                    ),
                    verticalSpaceSmall,
                    const Divider(),
                    verticalSpaceSmall,
                    CalendarDatePicker(
                      initialDate: model.initialData,
                      firstDate: model.initialData,
                      lastDate: DateTime(model.initialData.year + 1),
                      onDateChanged: model.onDateChanged,
                    ),
                    verticalSpaceSmall,
                    const Divider(),
                    verticalSpaceSmall,
                    Text(
                      'Pick Appointment Time',
                      style: AppStyle.kBodyRegularBlack15W500,
                    ),
                    verticalSpaceSmall,
                    const Divider(),
                    verticalSpaceSmall,
                    buildBodyItem(model),
                  ],
                ),
              ),
            ),
            verticalSpaceSmall,
            SizedBox(
              width: double.infinity,
              child: ResavationElevatedButton(
                child: Text("Book Appointment"),
                onPressed: () async {
                  if (model.selectedAppointment == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Please select an appointment date and time'),
                      ),
                    );
                    return;
                  }

                  final result = await showPickAppointmentDialog();
                  if (result == true) {
                    model.pickAppointment(
                      location: widget.appointmentBookingDetails?.location,
                      ownerEmail: widget.appointmentBookingDetails?.ownerEmail,
                      ownerName: widget.appointmentBookingDetails?.ownerName,
                      propertyName:
                          widget.appointmentBookingDetails?.propertyName,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Appointment sent, please check back later for confirmation status'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBodyItem(AppointmentBookingViewModel model) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: getOwnerAppointmentSchedule(
        widget.appointmentBookingDetails?.ownerEmail ?? '',
        model.selectedStartDate.millisecondsSinceEpoch,
        model.selectedEndDate.millisecondsSinceEpoch,
      ),
      builder: (ctx, asyncDataSnapshot) {
        if (asyncDataSnapshot.hasError) {
          return buildErrorBody(ctx);
        }
        if (asyncDataSnapshot.hasData) {
          return buildBodItem(asyncDataSnapshot, model);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  ListView buildBodItem(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> asyncDataSnapshot,
      AppointmentBookingViewModel model) {
    final queryData = asyncDataSnapshot.data;
    final List<Appointment> userAppointments = queryData?.docs
            .map(
              (documentSnapshot) => Appointment.fromMap(
                documentSnapshot.data(),
              ),
            )
            .toList() ??
        [];

    final allAppointments = getLandOwnerAvailiableSlots(userAppointments);
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final appointment = allAppointments[index];
        return AppointmentBookingItem(
          appointment: appointment,
          isSelected: model.isAppointmentSelected(appointment),
          onPressed: () {
            model.onSelectedAppointmentChanged(appointment);
          },
        );
      },
      itemCount: allAppointments.length,
    );
  }

  Widget buildLoadingWidget() {
    return Container(
      height: 500,
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

  Widget buildErrorBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
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
            'An error occured with the data fetch, please try again later',
            textAlign: TextAlign.center,
            style: bodyText2,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  AppBar buildAppBar(AppointmentBookingViewModel model) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  showPickAppointmentDialog() async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Pick Appointment"),
      content: Text("Would you love to pick an appointment for this time?"),
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

class AppointmentBookingItem extends StatelessWidget {
  final Appointment appointment;
  final bool isSelected;
  final VoidCallback onPressed;
  const AppointmentBookingItem(
      {Key? key,
      required this.appointment,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(left: 3, right: 3, bottom: 8),
      child: InkWell(
        onTap: appointment.status == AppointmentStatus.Free ? onPressed : null,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? kPrimaryColor : Colors.transparent,
              width: isSelected ? 2 : 0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
          child: Row(
            children: [
              Text(
                '${getAppointmentHour(appointment.appointmentStartTime ?? 0)} - ${getAppointmentHour(appointment.appointmentEndTime ?? 0)}',
                style: AppStyle.kBodyRegularBlack15W500.copyWith(
                    color: appointment.status != AppointmentStatus.Free
                        ? Colors.red
                        : kBlack),
              ),
              const Spacer(),
              Text(
                appointment.status == AppointmentStatus.Free
                    ? 'Availiable'
                    : 'Occuppied',
                style: AppStyle.kBodyRegularBlack14.copyWith(
                    color: appointment.status != AppointmentStatus.Free
                        ? Colors.red
                        : kBlack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
