import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/views/audio_call/pickup_screen.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../model/call_model.dart';
import '../../../services/core/user_type_service.dart';
import 'call_methods.dart';

class AppPickUpLayout extends StatelessWidget {
  final CallMethods callMethods = CallMethods();

  AppPickUpLayout();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppPickUpViewModel>.reactive(
      builder: (context, model, child) {
        return model.getUserEmail.isEmpty
            ? SizedBox(
                height: 0,
                width: 0,
              )
            : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: callMethods.callStream(
                  uid: model.getUserEmail,
                ),
                builder: (context, snapshot) {
                  if (snapshot.data != null &&
                      snapshot.hasData &&
                      snapshot.data!.data() != null) {
                    CallModel call = CallModel.fromMap(snapshot.data!.data()!);

                    final callTime = call.callUtcTime;
                    final currentTime =
                        DateTime.now().toUtc().millisecondsSinceEpoch;
                    if (!call.hasDialled && currentTime <= callTime + 180000) {
                      return PickupScreen(call: call);
                    }
                  }
                  return SizedBox(
                    height: 0,
                    width: 0,
                  );
                },
              );
      },
      viewModelBuilder: () => AppPickUpViewModel(),
    );
  }
}

class AppPickUpViewModel extends BaseViewModel {
  final _userService = locator<UserTypeService>();

  get getUserEmail => _userService.userData.email;
}
