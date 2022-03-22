// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_appointment_itemView/property_owner_appointment_itemView.dart';
import 'package:resavation/ui/views/property_owner_appointment_page1/appointment_pageoneViewModel.dart';

import 'package:resavation/ui/views/property_owner_homepage/property_owner_homepageViewModel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerAppointmentPageoneView extends StatelessWidget {
  PropertyOwnerAppointmentPageoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAppointmentPageoneViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
                backgroundColor: kWhite,
                appBar: AppBar(
                  backgroundColor: kWhite,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  title: Row(
                    children: [
                      verticalSpaceExtraLarge,
                      Text(
                        'Your Appointment',
                        style: AppStyle.kBodyRegular.copyWith(color: kBlack),
                      ),

                      //Tool tip
                      Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kWhite,
                            boxShadow: [
                              BoxShadow(color: kGray, blurRadius: 10)
                            ]),
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'InterRegular',
                            fontSize: 10,
                            color: Colors.black),
                        preferBelow: false,
                        message:
                            'Your customers are the\npeople you sell products\nor services to',
                      ),
                    ],
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(55),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: kGray)),
                        child: TabBar(
                          labelStyle:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: kBlack,
                                    fontFamily: "InterRegular",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                          unselectedLabelColor: kBlack,
                          unselectedLabelStyle:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: kBlack,
                                    fontFamily: "InterRegular",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          // indicatorColor: Colors.white,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: kPrimaryColor),
                          tabs: [
                            Tab(
                              text: 'Upcoming',
                            ),
                            Tab(text: 'Pass'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                body: TabBarView(children: <Widget>[
                  PropertyOwnerAppointmentItemView(
                    pageName: 'Upcoming',
                  ),
                  PropertyOwnerAppointmentItemView(
                    pageName: 'Pass',
                  )
                ])),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAppointmentPageoneViewModel(),
    );
  }
}

class Merchants {}

class Customers {}

//  @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<PropertyOwnerAppointmentPageoneViewModel>.reactive(
//       builder: (context, model, child) => SafeArea(
//         child: Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 24,
//               vertical: 15,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 verticalSpaceMedium,
//                 Text(
//                   'Your Appointment',
//                   style: AppStyle.kBodyBold,
//                 ),
//                 verticalSpaceMedium,
//                 Row(
//                   children: [
//                     _Upcoming(""),
//                   ],
//                 ),
//                 verticalSpaceMedium,
//                 Column(
//                   children: [
//                     _buildTextField2(''),
//                   ],
//                 ),
//                 Spacer(),
//                 ResavationButton(
//                   width: MediaQuery.of(context).size.width,
//                   title: 'Continue',
//                   onTap: () {
//                     model.goToPropertyOwnerHomePageView();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       viewModelBuilder: () => PropertyOwnerAppointmentPageoneViewModel(),
//     );
//   }
// }

// Widget _buildTextField(String label) {
//   const maxLines = 5;
//   return Container(
//     padding: EdgeInsets.all(10.0),
//     decoration: BoxDecoration(
//       border: Border.all(color: kGray),
//     ),
//     width: 60,
//     height: maxLines * 14.0,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Step 1",
//           style: TextStyle(color: kGray),
//         ),
//         Text(
//           "Choose Document",
//           style: AppStyle.kBodyBold,
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildTextField2(String label) {
//   const maxLines = 5;
//   return Container(
//     padding: EdgeInsets.all(10.0),
//     decoration: BoxDecoration(border: Border.all(color: kGray)),
//     width: 360,
//     height: maxLines * 14.0,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Take a Selfe",
//           style: AppStyle.kBodyBold,
//         ),
//       ],
//     ),
//   );
// }

// Widget _Upcoming(String label) {
//   return Container(
//     padding: EdgeInsets.all(10.0),
//     decoration: BoxDecoration(
//         border: Border.all(color: kGray),
//         borderRadius: BorderRadius.all(Radius.circular(5))),
//     width: 340,
//     height: 70.0,
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           child: Center(child: Text("Hello")),
//         ),
//         Spacer(),
//         Container(
//           width: 130,
//           height: 70,
//           color: kBlack,
//           child: Center(
//             child: Text(
//               "Hello",
//               style: TextStyle(color: kWhite),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }