import 'package:flutter/material.dart';
import 'package:resavation/model/owner_booked_property/content.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/views/property_owner_homepage/widget/property_owner_booked_properties.dart';
import '../../shared/text_styles.dart';
import 'property_owner_booked_properties_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';

class PropertyOwnerBookedPropertiesView extends StatefulWidget {
  const PropertyOwnerBookedPropertiesView({
    Key? key,
  }) : super(key: key);

  @override
  State<PropertyOwnerBookedPropertiesView> createState() =>
      _PropertyOwnerBookedPropertiesViewState();
}

class _PropertyOwnerBookedPropertiesViewState
    extends State<PropertyOwnerBookedPropertiesView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerBookedPropertiesViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const Divider(),
              verticalSpaceTiny,
              Row(
                children: [
                  Text(
                    model.properties.length.toString(),
                    style: AppStyle.kSubHeading.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                  Text(
                    '  item(s)',
                    style: AppStyle.kSubHeading,
                  ),
                  Spacer(),
                ],
              ),
              verticalSpaceTiny,
              const Divider(),
              verticalSpaceSmall,
              Expanded(
                child: buildBody(model),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerBookedPropertiesViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: 'Tenant Request(s)',
      backEnabled: true,
      centerTitle: false,
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

  Widget buildOldLoadingWidget() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

  Column buildErrorBody() {
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

  Widget buildBody(PropertyOwnerBookedPropertiesViewModel model) {
    final properties = model.properties;
    if (model.isLoading) {
      return buildLoadingWidget();
    } else if (model.hasErrorOnData) {
      return buildErrorBody();
    } else if (properties.isEmpty) {
      return buildEmptyBody();
    } else {
      return buildBodyItem(properties, model);
    }
  }

  Widget buildBodyItem(List<OwnerBookedPropertyContent> properties,
      PropertyOwnerBookedPropertiesViewModel model) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              final property = properties[index];

              return PropertyOwnerBookedPropertyCard(
                content: property,
                onTap: () => model.goToPropertyDetails(property),
              );
            },
            controller: model.scrollController,
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            itemCount: properties.length,
          ),
        ),
        if (model.isLoadingOldData) buildOldLoadingWidget(),
      ],
    );
  }

  Column buildEmptyBody() {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        Text(
          'No  booked properties yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly check back later for request(s) on your properties',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
