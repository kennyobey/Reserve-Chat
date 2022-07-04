import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import 'package:stacked/stacked.dart';

import '../../../utility/assets.dart';
import 'user_profile_pageViewModel.dart';

class UserProfilePageView extends StatelessWidget {
  const UserProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserProfilePageViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(700, 120.0)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/client1.png"),
                    ),

                    //resavation\assets\images\lady image.jpg
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceTiny,
                      Text(
                        "Queen Ameh",
                        style: AppStyle.kHeading1.copyWith(color: kBlack),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 20,
                          ),
                          horizontalSpaceTiny,
                          Text(
                            "Los Angeles, US",
                            style: AppStyle.kBodyRegularW500
                                .copyWith(color: kBlack),
                          ),
                        ],
                      ),
                      verticalSpaceRegular,
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            height: 60.0,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "I am a traveler and just a happy person \n Welcome",
                                style: AppStyle.kBodyRegularBlack15
                                    .copyWith(color: kBlack),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor, // background
                              onPrimary: kWhite, // foreground
                            ),
                            onPressed: () {},
                            child: Text('Message'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kWhite, // background
                              onPrimary: kPrimaryColor, // foreground
                            ),
                            onPressed: () {},
                            child: Text('Chat'),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => UserProfilePageViewModel(),
    );
  }
}

//kBodyRegularBlack14W500
