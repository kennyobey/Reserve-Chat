import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:stacked/stacked.dart';
import 'make_payment_viewmodel.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MakePaymentView extends StatelessWidget {
  final double planAmount;
  final String subscriptionCode;
  const MakePaymentView(
      {Key? key, required this.planAmount, required this.subscriptionCode})
      : super(key: key);

  Widget build(BuildContext context) {
    return ViewModelBuilder<MakePaymentViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: buildAppBar(),
          body: buildBody(model, context),
        );
      },
      viewModelBuilder: () => MakePaymentViewModel(
        planAmount,
        subscriptionCode,
      ),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Make Payment",
      backEnabled: true,
      centerTitle: false,
    );
  }

  Column buildErrorBody(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
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
          'An error occurred with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
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

  Widget buildBody(MakePaymentViewModel model, BuildContext context) {
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasErrorOnData) {
      return buildErrorBody(context);
    } else {
      return _MakPaymentBrowserBody(paymentUrl: model.webLink);
    }
  }
}

class _MakPaymentBrowserBody extends StatefulWidget {
  final String paymentUrl;
  const _MakPaymentBrowserBody({Key? key, required this.paymentUrl})
      : super(key: key);

  @override
  State<_MakPaymentBrowserBody> createState() => __MakPaymentBrowserBodyState();
}

class __MakPaymentBrowserBodyState extends State<_MakPaymentBrowserBody> {
  final GlobalKey webViewKey = GlobalKey();
  int currentProgress = 0;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          height: (currentProgress > 0 && currentProgress < 100) ? 4 : 0,
          width: currentProgress * width / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                colors: [kPrimaryColor.withOpacity(0.8), kPrimaryColor]),
          ),
        ),
        Expanded(
          child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(
              url: Uri.parse(widget.paymentUrl),
            ),
            initialOptions: options,
            onLoadStart: (controller, url) {},
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                currentProgress = progress;
              });
            },
          ),
        ),
      ],
    );
  }
}
