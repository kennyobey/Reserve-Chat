import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';
import '../../shared/dump_widgets/resavation_app_bar.dart';
import '../../shared/spacing.dart';
import '../../shared/text_styles.dart';
import 'appointment_page_viewmodel.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentPageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: buildAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                verticalSpaceSmall,
                Container(
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
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: model.currentTabPosition == 0
                                ? Colors.black
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Upcoming',
                            style: AppStyle.kBodyRegularBlack14W500.copyWith(
                                color: model.currentTabPosition == 0
                                    ? kWhite
                                    : kBlack),
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
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: model.currentTabPosition == 1
                                ? Colors.black
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Pass',
                            style: AppStyle.kBodyRegularBlack14W500.copyWith(
                                color: model.currentTabPosition == 1
                                    ? kWhite
                                    : kBlack),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                verticalSpaceMedium,
                Expanded(
                  child: buildBodyItem(model),
                ),
              ],
            ),
          )),
      viewModelBuilder: () => AppointmentPageViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Your Appointment",
      centerTitle: false,
    );
  }

  Widget buildBodyItem(AppointmentPageViewModel model) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return model.currentTabPosition == 0 ? UpcomingItem() : PassItem();
      },
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      itemCount: 9,
    );
  }
}

class UpcomingItem extends StatelessWidget {
  const UpcomingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Appointment Request',
          style: AppStyle.kBodyRegularBlack16W600,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '7 May 2022, 9:00AM - 11:30AM',
          style: AppStyle.kBodyRegularBlack14,
        ),
        verticalSpaceSmall,
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: Text(
                'Lorem Ispidium',
                style: AppStyle.kBodyRegularBlack14,
              ),
            ),
            horizontalSpaceSmall,
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Accept',
                style: AppStyle.kBodySmallRegular12.copyWith(color: kWhite),
              ),
            ),
            horizontalSpaceSmall,
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Decline',
                style: AppStyle.kBodySmallRegular12.copyWith(color: kWhite),
              ),
            ),
          ],
        )
      ]),
    );
  }
}

class PassItem extends StatelessWidget {
  const PassItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Appointment Request',
          style: AppStyle.kBodyRegularBlack16W600,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '7 May 2022, 9:00AM - 11:30AM',
          style: AppStyle.kBodyRegularBlack14,
        ),
        verticalSpaceSmall,
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: Text(
                'Lorem Ispidium',
                style: AppStyle.kBodyRegularBlack14,
              ),
            ),
            horizontalSpaceSmall,
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Review',
                style: AppStyle.kBodySmallRegular12.copyWith(color: kWhite),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
