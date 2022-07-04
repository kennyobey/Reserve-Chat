import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_dojah_financial/flutter_dojah_financial.dart';
import 'dart:convert';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/colors.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "Flutter Demo",
//         theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // Try running your application with "flutter run". You"ll see the
//           // application has a blue toolbar. Then, without quitting the app, try
//           // changing the primarySwatch below to Colors.green and then invoke
//           // “hot reload" (press “r" in the console where you ran “flutter run",
//           // or simply save your changes to “hot reload" in a Flutter IDE).
//           // Notice that the counter didn"t reset back to zero; the application
//           // is not restarted.
//           primarySwatch: Colors.blue,
//         ),
//         home: const HomePage());
//   }
// }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(""),
            backgroundColor: kWhite,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: kPrimaryColor,
                ))),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            child: Center(
              child: TextButton(
                child: ResavationButton(
                  width: MediaQuery.of(context).size.width,
                  title: 'Click Here To Verify',
                  buttonColor: Colors.transparent,
                  borderColor: kPrimaryColor,
                  titleColor: kPrimaryColor,
                ),
                onPressed: () {
                  final userData = {
                    "first_name": "Kehinde",
                    "last_name": "Ade",
                    "dob": "1998-03-08",
                    "residence_country": "Nigeria"
                  };

                  final configObj = {
                    "debug": "true",
                    // "mobile": true,
                    // "otp": false,
                    // "selfie": true,
                    // "aml": false,
                    // "webhook": true,
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

                  const referenceId = "123456789012a";

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
                },
              ),
            ),
          ),
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
        ])));
  }
}
