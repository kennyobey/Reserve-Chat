import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details_header.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

import '../messages/messages_viewmodel.dart';
import 'co_working_space_aboutViewModel.dart';

enum RadioPlans { daily, monthly, weekly }

class CoWorkingSpaceAboutView extends StatefulWidget {
  CoWorkingSpaceAboutView({
    Key? key,
  }) : super(key: key);

  @override
  State<CoWorkingSpaceAboutView> createState() =>
      _CoWorkingSpaceAboutViewState();
}

class _CoWorkingSpaceAboutViewState extends State<CoWorkingSpaceAboutView> {
  RadioPlans _plans = RadioPlans.daily;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoWorkingSpaceAboutViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            // buildHeader(model, context),
            buildDescription(model, context),
            buildAmenity(model),
            buildLocation(model),
          ],
        ),
        bottomSheet: planButton(context, model),
      ),
      viewModelBuilder: () => CoWorkingSpaceAboutViewModel(),
    );
  }

  Container buildBottomBar(CoWorkingSpaceAboutViewModel model) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.center,
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Expanded(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("Starting at", style: AppStyle.kBodySmallRegular12W500),
          //       Text(
          //         '${String.fromCharCode(8358)} ${oCcy.format(model.property?.spacePrice ?? 0)}',
          //         style: AppStyle.kBodyRegularBlack14.copyWith(
          //             color: Colors.black,
          //             fontSize: 18,
          //             fontWeight: FontWeight.w600),
          //       )
          //     ],
          //   ),
          // ),
          ResavationElevatedButton(
            child: Text('Confirm'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  SliverList buildLocation(CoWorkingSpaceAboutViewModel model) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceSmall,
            Text(
              'Location',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Expanded(
                  child: Text(
                    model.property?.address ?? '',
                    style: AppStyle.kBodyRegularBlack15,
                  ),
                ),
                verticalSpaceTiny,
                ResavationElevatedButton(
                  child: Text("Go to Map"),
                  onPressed: () {
                    model.goToMapView();
                  },
                ),
              ],
            ),
            verticalSpaceMedium,
            Text(
              'House Rule(s)',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceSmall,
            Text(
              'No Party',
              style: AppStyle.kBodyRegularBlack14,
            ),
            Text(
              'No Smoking',
              style: AppStyle.kBodyRegularBlack14,
            ),
            /*  ...?property?.houseRules
                .map(
                  (rule) => Row(
                    children: [
                      Text(
                        '- $rule',
                        style: AppStyle.kBodySmallRegular12,
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                )
                .toList(), */
            verticalSpaceMassive,
          ],
        ),
      ),
    ]));
  }

  SliverGrid buildAmenity(CoWorkingSpaceAboutViewModel model) {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 0,
      crossAxisSpacing: 4,
      childAspectRatio: 4,
      children: model.amenities
          .map(
            (amenity) => AmenitiesItem(
              iconData: amenity.iconData,
              title: amenity.title,
            ),
          )
          .toList(),
    );
  }

  SliverList buildDescription(
      CoWorkingSpaceAboutViewModel model, BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceSmall,
                Text(
                  model.property?.propertyName ?? 'Eleko Estate',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
                Text(
                  model.property?.address ?? '11, Cheveron Drive, Lekki',
                  style: AppStyle.kBodySmallRegular12W300,
                ),
                verticalSpaceSmall,
                PropertyDetails(
                  title: model.property?.propertyCategory ?? 'Eleko Estate',
                  numberOfBedrooms: model.property?.bedroomCount ?? 0,
                  numberOfBathrooms: model.property?.bathTubCount ?? 0,
                  squareFeet: (model.property?.surfaceArea ?? 0) + .0,
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: 25, // Image radius
                        backgroundImage: AssetImage(Assets.profile_image2),
                      ),
                      onTap: () => model.goToPropertyOwnersProfileView(),
                    ),
                    horizontalSpaceSmall,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adeyemo Stephen",
                          style: AppStyle.kBodyRegularBlack16W600,
                        ),
                        Text(
                          "Co Working Space",
                          style: AppStyle.kBodyRegularBlack14,
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Settig up chatroom, please wait')),
                        );
                        final chatModel = await MessagesViewModel.createChat(
                            'otitemitope6@gmail.com',
                            " property?.ownerProfileName ?? ''",
                            'https://firebasestorage.googleapis.com/v0/b/oh2020-a8512.appspot.com/o/images%2Fothers%2FEXCEEDING%20EXPECTATIONS%20DAY%202%2F49834?alt=media&token=6a9c3239-f222-44d1-ab9f-a87a9a3fd960');
                        model.gotToChatRoomView(chatModel);
                      },
                      child: Icon(
                        Icons.message_rounded,
                        color: Colors.black38,
                        size: 20,
                      ),
                    ),
                    horizontalSpaceSmall,
                    GestureDetector(
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Setting up chatroom, please wait')),
                        );
                        final chatModel = await MessagesViewModel.createChat(
                            'otitemitope6@gmail.com',
                            " property?.ownerProfileName ?? ''",
                            'https://firebasestorage.googleapis.com/v0/b/oh2020-a8512.appspot.com/o/images%2Fothers%2FEXCEEDING%20EXPECTATIONS%20DAY%202%2F49834?alt=media&token=6a9c3239-f222-44d1-ab9f-a87a9a3fd960');
                        model.gotToChatRoomView(chatModel);
                      },
                      child: Icon(
                        Icons.call,
                        size: 20,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
                verticalSpaceMedium,
                Text(
                  'Description',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
                verticalSpaceSmall,
                Text(
                    model.property?.description ??
                        'dfnjcnkewnkldmlckmlkmfntklnvklndejkncfdjxcnskjnfknxjnsdfjnjnvdnklcndlmedxkmvklermklmkslkdfnjnvknlkanelkfnklnvlkfmglkmdklfmlkmflkvmflf',
                    style: AppStyle.kBodySmallRegular12),
                verticalSpaceMedium,
                Text(
                  'Amenities',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

/*   SliverPersistentHeader buildHeader(
      CoWorkingSpaceAboutViewModel model, BuildContext context) {
    return SliverPersistentHeader(
        floating: true,
        delegate: PropertyDetailsHeader(
          onBackTap: model.navigateBack,
          propertyImages: model.property?.propertyImages ?? [],
          isFavoriteTap: model.property?.favourite ?? false,
          onFavoriteTap: () async {
            try {
              await model.onFavouriteTap();
            } catch (exception) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(exception.toString())));
            }
          },
        ));
  } */
}

class AmenitiesItem extends StatelessWidget {
  const AmenitiesItem({
    Key? key,
    this.title = '',
    required this.iconData,
  }) : super(key: key);
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            iconData,
            color: kGray,
          ),
          horizontalSpaceSmall,
          Text(
            title,
            style: AppStyle.kBodySmallRegular12W500,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

Widget planButton(BuildContext context, CoWorkingSpaceAboutViewModel model) {
  return ResavationElevatedButton(
      child: Text("Choose Plan"),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Choose your Plan",
                      style: AppStyle.kBodyRegularBlack16W600,
                    ),
                    verticalSpaceRegular,
                    buildNumberOfDays(model),
                    verticalSpaceTiny,
                    buildNumberOfWeeks(model),
                    verticalSpaceTiny,
                    buildNumberOfMonths(model),
                    verticalSpaceRegular,
                    Center(
                      child: ResavationElevatedButton(
                        child: Text('Continue to Checkout'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            });
      });
}

PlanSelection buildNumberOfDays(CoWorkingSpaceAboutViewModel model) {
  return PlanSelection(
    title: "Daily",
    amount: "#2000/day",
    value: model.numberOfDays,
    onPositiveTap: () => model.onPositiveNumberOfDaysTap(),
    onNegativeTap: () => model.onNegativeNumberOfDaysTap(),
    widget: Radio(
        value: RadioPlans.daily,
        groupValue: _plans,
        onChanged: (RadioPlans) {}),
  );
}

PlanSelection buildNumberOfWeeks(CoWorkingSpaceAboutViewModel model) {
  return PlanSelection(
    title: "Weekly (Mon/Friday)",
    amount: "#7000/week",
    value: model.numberOfDays,
    onPositiveTap: () => model.onPositiveNumberOfDaysTap(),
    onNegativeTap: () => model.onNegativeNumberOfDaysTap(),
    widget: Radio(
        value: RadioPlans.daily,
        groupValue: _plans,
        onChanged: (RadioPlans) {}),
  );
}

mixin _plans {}

PlanSelection buildNumberOfMonths(CoWorkingSpaceAboutViewModel model) {
  return PlanSelection(
    title: "Monthly",
    amount: "#25000/month",
    value: model.numberOfDays,
    onPositiveTap: () => model.onPositiveNumberOfDaysTap(),
    onNegativeTap: () => model.onNegativeNumberOfDaysTap(),
    widget: Radio(
        value: RadioPlans.daily,
        groupValue: _plans,
        onChanged: (RadioPlans) {}),
  );
}

class PlanSelection extends StatelessWidget {
  const PlanSelection({
    Key? key,
    this.title,
    this.amount,
    this.onNegativeTap,
    this.onPositiveTap,
    this.value,
    this.widget,
  }) : super(key: key);
  final String? amount;
  final String? title;
  final int? value;
  final Function()? onNegativeTap;
  final Function()? onPositiveTap;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(0.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: AppStyle.kBodySmallRegular12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount!,
                style: AppStyle.kBodySmallRegular12,
              ),
              Row(
                children: [
                  IncrementPlans(
                    icon: Icons.remove,
                    onTap: onNegativeTap,
                  ),
                  Text(value.toString()),
                  IncrementPlans(
                    icon: Icons.add,
                    onTap: onPositiveTap,
                  ),
                  Container(
                    child: widget,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSpaceFurnished(
      BuildContext context, CoWorkingSpaceAboutViewModel model) {
    return FilterListTile(
      onChanged: model.setSpaceFurnished,
    );
  }
}

// widget used to increase/decrease the plans value
class IncrementPlans extends StatelessWidget {
  const IncrementPlans({Key? key, this.icon, this.onTap}) : super(key: key);

  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: kGray),
              borderRadius: BorderRadius.circular(10.0)),
          child: Icon(
            icon,
            color: kGray,
            size: 12,
          ),
        ),
      ),
    );
  }
}

class FilterListTile extends StatefulWidget {
  final Function(bool?) onChanged;

  const FilterListTile({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<FilterListTile> createState() => _FilterListTileState();
}

class _FilterListTileState extends State<FilterListTile> {
  bool? _groupValue;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = Iterable<int>.generate(3).map((e) => FocusNode()).toList();

    _focusNodes[0].requestFocus();
  }

  Widget buildRadio(bool value, FocusNode focusNode) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Radio<bool>(
                groupValue: _groupValue,
                value: value,
                onChanged: (bool? value) {
                  widget.onChanged(value);
                  setState(() {
                    _groupValue = value;
                  });
                },
                hoverColor: kWhite,
                activeColor: kPrimaryColor,
                focusColor: kPrimaryColor,
                splashRadius: 25,
                toggleable: true,
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                focusNode: focusNode),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRadio(true, _focusNodes[0]),
        buildRadio(true, _focusNodes[0]),
        buildRadio(true, _focusNodes[0]),
      ],
    );
  }
}
