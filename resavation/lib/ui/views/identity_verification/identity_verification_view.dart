import 'package:flutter/material.dart';
import 'package:resavation/ui/views/identity_verification/identity_verification_viewmodel.dart';
import 'package:stacked/stacked.dart';

class IdentityVerification extends StatelessWidget {
  const IdentityVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IdentityVerificationViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Container(),
        ),
      ),
      viewModelBuilder: () => IdentityVerificationViewModel(),
    );
  }
}
