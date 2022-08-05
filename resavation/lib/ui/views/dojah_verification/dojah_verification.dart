import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_dojah_financial/flutter_dojah_financial.dart';
import 'package:focus_detector/focus_detector.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/views/dojah_verification/dojah_verification_viewModel.dart';
import 'package:stacked/stacked.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

Map<dynamic, dynamic> envVars = Platform.environment;

class _VerificationPageState extends State<VerificationPage> {
// final appId= envVars["appId"]; //your application ID
// final publicKey = envVars[‘publicKey"]; //your public key

  final appId = "62b4cea40fdea6003489d12d"; //your application ID
  final publicKey = "test_pk_JacLtoqjU8KiWc7nbeAFO4DF8"; //your public key

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: BackButton(
        color: Colors.black,
      ),
    );
  }

  Padding buildBottomBar(DojahVerificationViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (model.userHasNotFilledProfile)
            Expanded(
              child: ResavationElevatedButton(
                  child: Text("Update Profile"),
                  onPressed: () {
                    model.editProfileScreen();
                  }),
            ),
          if (!model.userHasNotFilledProfile)
            Expanded(
              child: ResavationElevatedButton(
                  child: Text("Verify Account"),
                  onPressed: () {
                    final userData = {
                      "first_name": model.userProfile?.firstName,
                      "last_name": model.userProfile?.lastName,
                      "dob": DateFormat('yyyy-MM-dd')
                          .format(model.userProfile!.dateOfBirth!),
                      "residence_country": model.userProfile?.country,
                    };

                    final configObj = {
                      "debug": "true",
                      /* "mobile": true,
                    "otp": false,
                    "selfie": true,
                    "aml": false,
                    "webhook": true, */
                      "review_process": "Automatic",
                      "pages": [
                        //  { "page": "phone-number", "config": { "verification": true } },
                        {
                          "page": "government-data",
                          "config": {
                            "bvn": false,
                            "nin": true,
                            "dl": false,
                            "mobile": false,
                            "otp": false,
                            "selfie": false
                          }
                        },
                        {
                          "page": "selfie",
                          "config": {"verification": true}
                        },
                        // {"page": "address"},
                        // {
                        //   "page": "id",
                        //   "config": {"passport": false, "dl": true}
                        // }
                      ]
                    };

                    final metaData = {
                      "user_id": "81828289191919193882",
                    };

                    // const referenceId = "123456789012a";

                    DojahFinancial? _dojahFinancial;
                    //Use your appId and publicKey
                    _dojahFinancial = DojahFinancial(
                      appId: appId,
                      publicKey: publicKey,
                      type: "custom",
                      userData: userData,
                      metaData: metaData,
                      config: configObj,

                      // referenceId: referenceId
                    );

                    print(json.encode(configObj));
                    print(json.encode(configObj));
                    print(userData);
                    print(configObj);
                    _dojahFinancial.open(context,
                        onSuccess: (result) => print(result),
                        // onClose: (close) => print("Widget Closed"),
                        onError: (error) => print(error));
                  }),
            )
        ],
      ),
    );
  }

  Widget buildErrorBody() {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Center(
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

  Widget buildProfileNeeded(DojahVerificationViewModel model) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'No Profile Found!',
            style: bodyText1,
          ),
          const SizedBox(
            height: 5,
            width: double.infinity,
          ),
          Text(
            'In order to verify your account you need to first update your names, DOB and country ',
            textAlign: TextAlign.center,
            style: bodyText2,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget buildLoadingWidget() {
    return Center(
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DojahVerificationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: model.isLoading || model.hasErrorOnData
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : buildBottomBar(model),
        body: FocusDetector(
          onFocusGained: () {
            model.getProfile();
          },
          child: model.isLoading
              ? buildLoadingWidget()
              : model.hasErrorOnData
                  ? buildErrorBody()
                  : model.userHasNotFilledProfile
                      ? buildProfileNeeded(model)
                      : buildBody(model),
        ),
      ),
      viewModelBuilder: () => DojahVerificationViewModel(),
    );
  }

  Widget buildBody(DojahVerificationViewModel model) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        const Spacer(),
        Text(
          'Profile Verification',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          "To verify your account, please click the verify account button below. You will be asked to verify your profile details as well as some official documents. ",
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ]),
    );
  }
}

// Container(
//   child: TextButton(
//     child: const Text(
//       "Link Widget",
//       style: TextStyle(fontSize: 20.0),
//     ),
//     onPressed: () {
//       final userData = {
//         "first_name": "Chijioke",
//         "last_name": "Nna",
//         "dob": "2022-03-12"
//       };
//       final configObj = {
//         "debug": true,
//         "mobile": true,
//       };
//       DojahFinancial? _dojahFinancial;

//       //Use your appId and publicKey
//       _dojahFinancial = DojahFinancial(
//         appId: appId,
//         publicKey: publicKey,
//         type:
//             "link", //"verification", "identification", "verification", "liveness"
//         userData: userData,
//         config: configObj,
//       ); //Type can be link, identification, verification
//       _dojahFinancial.open(context,
//           onSuccess: (result) => print(result),
//           // onClose: (close) => print("Widget Closed"),
//           // ignore: avoid_print
//           onError: (error) => print("widget Error" + error));
//     },
//   ),
// ),
// Container(
//   child: TextButton(
//     child: const Text(
//       "Payment Widget",
//       style: TextStyle(fontSize: 20.0),
//     ),
//     onPressed: () {
//       final userData = {
//         "first_name": "Chijioke",
//         "last_name": "Nna",
//         "dob": "2022-03-12"
//       };
//       final configObj = {
//         "debug": true,
//         "mobile": true,
//       };

//       DojahFinancial? _dojahFinancial;
//       //Use your appId and publicKey
//       _dojahFinancial = DojahFinancial(
//         appId: appId,
//         publicKey: publicKey,

//         type:
//             "payment", //"verification", "identification", "verification", "liveness"
//         userData: userData,
//         config: configObj,
//         amount: 100,
//       ); //Type can be link, identification, verification
//       _dojahFinancial.open(context,
//           onSuccess: (result) => print(result),
//           onClose: (close) => print("Widget Closed"),
//           onError: (error) => print(error));
//     },
//   ),
// ),
// Container(
//   child: TextButton(
//     child: const Text(
//       "Identification Widget",
//       style: TextStyle(fontSize: 20.0),
//     ),
//     onPressed: () {
//       final userData = {
//         "first_name": "Chijioke",
//         "last_name": "Nna",
//         "dob": "2022-03-12"
//       };
//       final configObj = {
//         "debug": true,
//         "mobile": true,
//         "otp": true,
//         "selfie": true,
//         "aml": false,
//         "review_process":
//             "Automatic", // Possible values are "Automatic" and "Manual"
//       };

//       DojahFinancial? _dojahFinancial;
//       //Use your appId and publicKey
//       _dojahFinancial = DojahFinancial(
//         appId: appId,
//         publicKey: publicKey,
//         type:
//             "identification", //"verification", "identification", "verification", "liveness"
//         userData: userData,
//         config: configObj,
//       ); //Type can be link, identification, verification
//       _dojahFinancial.open(context,
//           onSuccess: (result) => print(result),
//           onClose: (close) => print("Widget Closed"),
//           onError: (error) => print(error));
//     },
//   ),
// ),
// Container(
//   child: TextButton(
//     child: const Text(
//       "Verification Widget",
//       style: TextStyle(fontSize: 20.0),
//     ),
//     onPressed: () {
//       final userData = {
//         "first_name": "Chijioke",
//         "last_name": "Nna",
//         "dob": "2022-03-12"
//       };
//       final configObj = {
//         "debug": true,
//         "mobile": true,
//         "otp": true,
//         "selfie": true,
//       };

//       DojahFinancial? _dojahFinancial;
//       //Use your appId and publicKey
//       _dojahFinancial = DojahFinancial(
//         appId: appId,
//         publicKey: publicKey,
//         type:
//             "verification", //"verification", "identification", "verification", "liveness"
//         userData: userData,
//         config: configObj,
//       ); //Type can be link, identification, verification
//       _dojahFinancial.open(context,
//           onSuccess: (result) => print(result),
//           onClose: (close) => print("Widget Closed"),
//           onError: (error) => print(error));
//     },
//   ),
// ),
//           Container(
//             child: TextButton(
//               child: const Text(
//                 "Liveness Widget",
//                 style: TextStyle(fontSize: 20.0),
//               ),
//               onPressed: () async {
//                 final userData = {
//                   "first_name": "Chijioke",
//                   "last_name": "Nna",
//                   "dob": "2022-03-12"
//                 };
//                 final configObj = {
//                   "debug": true,
//                   "mobile": true,
//                 };

// //             var status = await Permission.camera.status;
// //             if (status.isDenied) {
// //   // We didn"t ask for permission yet or the permission has been denied before but not permanently.
// // }
//                 DojahFinancial? _dojahFinancial;

//                 //Use your appId and publicKey
//                 _dojahFinancial = DojahFinancial(
//                   appId: appId,
//                   publicKey: publicKey,
//                   type:
//                       "liveness", //a"verification", "identification", "verification", "liveness"
//                   userData: userData,
//                   config: configObj,
//                 ); //Type can be link, identification, verification
//                 _dojahFinancial.open(context,
//                     onSuccess: (result) => print(result),
//                     onClose: (close) => print("Widget Closed"),
//                     onError: (error) => print(error));
//               },
//             ),
//           ),
