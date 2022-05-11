import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/views/audio_call/pickup_screen.dart';

import '../../../app/app.locator.dart';
import '../../../model/call_model.dart';
import '../../../services/core/user_type_service.dart';
import 'call_methods.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final _userTypeService = locator<UserTypeService>();

  final CallMethods callMethods = CallMethods();

  PickupLayout({
    required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: callMethods.callStream(uid: _userTypeService.userData.email),
      builder: (context, snapshot) {
        if (snapshot.data != null &&
            snapshot.hasData &&
            snapshot.data!.data() != null) {
          CallModel call = CallModel.fromMap(snapshot.data!.data()!);
          if (!call.hasDialled) {
            return PickupScreen(call: call);
          }
        }
        return scaffold;
      },
    );
  }
}
