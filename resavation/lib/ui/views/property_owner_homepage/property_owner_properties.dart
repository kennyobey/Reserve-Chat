import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:stacked/stacked.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyOwnerProperties
    extends ViewModelWidget<PropertyOwnerHomePageViewModel> {
  const PropertyOwnerProperties({Key? key}) : super(key: key);

  Column buildErrorBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
    final textTheme = Theme.of(context).textTheme;
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
          'No properties yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly create a new property by listing your space above',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget buildBody(PropertyOwnerHomePageViewModel model) {
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

  Widget buildSuccessBody(List<Property> allContent,
      PropertyOwnerHomePageViewModel model, BuildContext context) {
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
                  // showItemDialog(appointment, context);
                },
              );
            },
            itemCount: allContent.length,
          );
  }

  @override
  Widget build(BuildContext context, PropertyOwnerHomePageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleListTile(
          onTap: () {
            // model.goToAppointmentList();
          },
          visibility: true,
          title: 'Your Properties',
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
