// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_acceptbutton/property_owner_acceptbuttonViewModel.dart';

import 'package:stacked/stacked.dart';

import '../property_owner_acceptbuttonViewItems/property_owner_acceptbuttonItemsView.dart';
import '../property_owner_acceptbuttonViewItemsPass/property_owner_acceptbuttonItemsPassView.dart';

class PropertyOwnerAcceptbuttonView extends StatelessWidget {
  const PropertyOwnerAcceptbuttonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAcceptbuttonViewModel>.reactive(
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
                        style: AppStyle.kHeading0.copyWith(color: kBlack),
                      ),
                    ],
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(55),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 224, 221, 221))),
                        child: TabBar(
                          labelStyle:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: kBlack,
                                    fontFamily: "Montserrat",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                          unselectedLabelColor: kBlack,
                          unselectedLabelStyle:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: kBlack,
                                    fontFamily: "Montserrat",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          // indicatorColor: Colors.white,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: kBlack),
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
                  PropertyOwnerAcceptbuttonItemsView(
                    pageName: 'Upcoming',
                  ),
                  PropertyOwnerAcceptbuttonItemsPassView(
                    pageName: 'Pass',
                  )
                ])),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAcceptbuttonViewModel(),
    );
  }
}
