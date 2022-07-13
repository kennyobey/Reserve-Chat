import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resavation/model/appointment.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_appointment_page1/property_owner_appointment_pageoneViewModel.dart';
import 'package:resavation/ui/views/property_owner_appointment_page1/widgets/active_item_body.dart';
import 'package:resavation/ui/views/property_owner_appointment_page1/widgets/pass_item_body.dart';
import 'package:resavation/ui/views/property_owner_appointment_page1/widgets/pending_item_body.dart';
import 'package:stacked/stacked.dart';

class PropertyOwnerAppointmentPageoneView extends StatefulWidget {
  const PropertyOwnerAppointmentPageoneView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerAppointmentPageoneView> createState() =>
      _PropertyOwnerAppointmentPageoneViewState();
}

class _PropertyOwnerAppointmentPageoneViewState
    extends State<PropertyOwnerAppointmentPageoneView> {
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAppointmentPageoneViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: getOwnerAppointments(model.userData.email),
          builder: ((context, asyncDataSnapshot) {
            if (asyncDataSnapshot.hasError) {
              return buildErrorBody(context);
            }

            if (asyncDataSnapshot.hasData) {
              final queryData = asyncDataSnapshot.data;
              final List<Appointment> allAppointments = queryData?.docs
                      .map(
                        (documentSnapshot) => Appointment.fromMap(
                          documentSnapshot.data(),
                        ),
                      )
                      .toList() ??
                  [];
              return buildBody(model, allAppointments);
            } else {
              return buildLoadingWidget();
            }
          }),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAppointmentPageoneViewModel(),
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

  Padding buildBody(PropertyOwnerAppointmentPageoneViewModel model,
      List<Appointment> allAppointments) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          verticalSpaceSmall,
          buildIndicators(model),
          verticalSpaceMedium,
          Expanded(
            child: buildBodyItem(model, allAppointments),
          ),
        ],
      ),
    );
  }

  Container buildIndicators(PropertyOwnerAppointmentPageoneViewModel model) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: [
        Expanded(
          child: InkWell(
            onTap: () {
              model.onTabItemPressed(0);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: model.currentTabPosition == 0
                    ? Colors.black
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Pending',
                style: AppStyle.kBodyRegularBlack14W500.copyWith(
                    color: model.currentTabPosition == 0 ? kWhite : kBlack),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              model.onTabItemPressed(1);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: model.currentTabPosition == 1
                    ? Colors.black
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Active',
                style: AppStyle.kBodyRegularBlack14W500.copyWith(
                    color: model.currentTabPosition == 1 ? kWhite : kBlack),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              model.onTabItemPressed(2);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: model.currentTabPosition == 2
                    ? Colors.black
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Pass',
                style: AppStyle.kBodyRegularBlack14W500.copyWith(
                    color: model.currentTabPosition == 2 ? kWhite : kBlack),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Your Appointment",
      centerTitle: false,
      backEnabled: false,
    );
  }

  Widget buildBodyItem(PropertyOwnerAppointmentPageoneViewModel model,
      List<Appointment> allAppointments) {
    final activeItems = <Appointment>[];
    final pendingItems = <Appointment>[];
    final passItems = <Appointment>[];

    allAppointments.forEach((element) {
      if (element.status == AppointmentStatus.Declined ||
          element.status == AppointmentStatus.Passed) {
        passItems.add(element);
      } else if (element.status == AppointmentStatus.Booked) {
        activeItems.add(element);
      } else if (element.status == AppointmentStatus.Pending) {
        pendingItems.add(element);
      }
    });

    return PageView.builder(
      itemBuilder: ((context, index) {
        if (index == 0) {
          return PendingItemBody(
              appointments: pendingItems,
              onAccepted: (appointment) {
                model.acceptDeclineAppointment(
                    appointment, AppointmentStatus.Booked);
              },
              onDeclined: (appointment) {
                model.acceptDeclineAppointment(
                    appointment, AppointmentStatus.Declined);
              });
        } else if (index == 1) {
          return ActiveItemBody(appointments: activeItems);
        } else {
          return PassItemBody(appointments: passItems);
        }
      }),
      itemCount: 3,
      onPageChanged: model.onPageChanged,
      controller: model.getPageController,
    );
  }
}
