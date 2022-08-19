import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'user_profile_viewModel.dart';
import 'package:focus_detector/focus_detector.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({
    Key? key,
  }) : super(key: key);
  //final EditProfileModel content;

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  // EditProfileModel? content;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserProfileViewModel>.reactive(
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
          child: model.hasErrorOnData
              ? buildErrorBody()
              : model.isLoading
                  ? buildLoadingWidget()
                  : buildBody(model),
        ),
      ),
      viewModelBuilder: () => UserProfileViewModel(),
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

  Padding buildBody(UserProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceSmall,
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: ResavationImage(
                        image: model.userData.imageUrl,
                      ),
                    ),
                  ),
                  verticalSpaceMedium,
                  buildProfileItems(context, model),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildBottomBar(UserProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ResavationElevatedButton(
                child: Text("Verify"),
                onPressed: () {
                  model.goToVerificationPage();
                }),
          ),
          horizontalSpaceMedium,
          Expanded(
            child: ResavationElevatedButton(
                child: Text("Edit Profile"),
                onPressed: () {
                  model.goToEditProfileView();
                }),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: BackButton(
        color: Colors.black,
      ),
      title: Text(
        'User Profile',
        style: AppStyle.kHeading0,
      ),
    );
  }

  Widget buildProfileItems(BuildContext context, UserProfileViewModel model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Divider(),
      verticalSpaceTiny,
      Text(
        'Personal Information Data',
        style: AppStyle.kHeading3,
      ),
      verticalSpaceTiny,
      const Divider(),
      verticalSpaceSmall,
      Text(
        'First Name',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.firstName ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'Last Name',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.lastName ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'About Me',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.aboutMe ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'Date Of Birth',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceSmall,
      Text(
        model.userProfile?.dateOfBirth == null
            ? ''
            : DateFormat('dd-MM-yyyy').format(model.userProfile!.dateOfBirth!),
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'Email',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.email ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'Phone Number',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.phoneNumber ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'Gender',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.gender ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'Occupation',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.occupation ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceSmall,
      const Divider(),
      verticalSpaceTiny,
      Text(
        'Personal Information Data',
        style: AppStyle.kHeading3,
      ),
      verticalSpaceTiny,
      const Divider(),
      verticalSpaceSmall,
      Text(
        'Country',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.country ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'State',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.state ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'City',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.city ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'Address',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.address ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMedium,
      Text(
        'Postal Code',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceTiny,
      Text(
        model.userProfile?.postalCode ?? "",
        style: AppStyle.kBodyRegularBlack12W500.copyWith(color: kBlack),
      ),
      verticalSpaceMassive,
    ]);
  }
}
