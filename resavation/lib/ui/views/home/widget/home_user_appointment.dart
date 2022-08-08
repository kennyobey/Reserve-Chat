import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:shimmer/shimmer.dart';
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

  Widget buildBody(HomeViewModel model, BuildContext context) {
    if (model.tenantAppointmentLoading) {
      return buildLoadingWidget();
    } else if (model.tenantAppointmentHasError) {
      return buildErrorBody(context);
    } else {
      return buildSuccessBody(model.tenantAppointmentModel, model, context);
    }
  }

  Widget buildLoadingWidget() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return HomeAppointmentItem(
          appointment: Appointment(),
          shimmerEnabled: true,
          onPressed: () {},
        );
      },
      itemCount: 3,
    );
  }

  showItemDialog(Appointment appointment, BuildContext context) async {
    String content = '';

    if (appointment.status == AppointmentStatus.Declined) {
      content = 'Your appointment was declined';
    } else if (appointment.status == AppointmentStatus.Passed) {
      content = 'Your appointment has passed';
    } else if (appointment.status == AppointmentStatus.Booked) {
      content = 'Your appointment has been approved';
    } else if (appointment.status == AppointmentStatus.Pending) {
      content =
          'Your appointment is pending, please check back later for updated information';
    }

    Dialog dialog = Dialog(
      backgroundColor: Colors.transparent,
      elevation: 5,
      child: Material(
        color: Colors.transparent,
        child: Card(
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (appointment.propertyName ?? ''),
                  style: AppStyle.kBodyRegularBlack16W600.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  '• ' + (appointment.location ?? ''),
                  style: AppStyle.kBodyRegularBlack14.copyWith(
                    color: kBlack.withOpacity(0.6),
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  '• ${getFormattedTime2(appointment.appointmentDate ?? 0)}, ${getAppointmentHour(appointment.appointmentStartTime ?? 0).toUpperCase()}-${getAppointmentHour(appointment.appointmentEndTime ?? 0).toUpperCase()}',
                  style: AppStyle.kBodyRegularBlack14.copyWith(
                    color: kBlack.withOpacity(0.6),
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  '• ' + (appointment.landOwnerName ?? ''),
                  style: AppStyle.kBodyRegularBlack14.copyWith(
                    color: kBlack.withOpacity(0.6),
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  '• ' + content,
                  style: AppStyle.kBodyRegularBlack14.copyWith(
                    color: kBlack.withOpacity(0.6),
                  ),
                ),
                verticalSpaceSmall,
              ],
            ),
          ),
        ),
      ),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Item Dialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
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
        buildBody(model, context),
      ],
    );
  }
}

class HomeAppointmentItem extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onPressed;
  final bool shimmerEnabled;
  const HomeAppointmentItem({
    Key? key,
    required this.appointment,
    required this.onPressed,
    this.shimmerEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 1,
      margin: const EdgeInsets.only(left: 3, right: 3, bottom: 8),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          child: shimmerEnabled
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: shimmerBody(),
                )
              : buildBody(),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget shimmerBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: kPrimaryColor,
          width: double.infinity,
          height: 20,
        ),
        verticalSpaceTiny,
        Container(
          color: kPrimaryColor,
          width: double.infinity,
          height: 20,
        ),
      ],
    );
  }

  Column buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (appointment.propertyName ?? ''),
          style: AppStyle.kBodyRegularBlack16W600.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                '${getFormattedTime2(appointment.appointmentDate ?? 0)} - ${getAppointmentHour(appointment.appointmentStartTime ?? 0).toUpperCase()} to ${getAppointmentHour(appointment.appointmentEndTime ?? 0).toUpperCase()}',
                style: AppStyle.kBodyRegularBlack14.copyWith(
                  color: kBlack.withOpacity(0.6),
                ),
              ),
            ),
            horizontalSpaceTiny,
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text(
                appointment.status.name,
                style: AppStyle.kBodyRegularBlack14.copyWith(
                  color: kBlack,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
