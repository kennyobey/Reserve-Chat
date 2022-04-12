import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/home/home_viewmodel.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              verticalSpaceMedium,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: model.goToPropertyOwnerProfileView,
                      child: CircleAvatar(
                        radius: 20, // Image radius
                        backgroundImage: AssetImage(Assets.profile_image),
                      ),
                    ),
                    horizontalSpaceSmall,
                    Text(
                      'Hello Steven',
                      style: AppStyle.kBodyRegularBlack14W600,
                    ),
                    Spacer(),
                    Icon(Icons.notifications_none_outlined),
                  ],
                ),
              ),
              verticalSpaceMedium,
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find a',
                        style: AppStyle.kHeading0,
                      ),
                      Text(
                        'Suitable Apartment',
                        style: AppStyle.kHeading2,
                      ),
                      verticalSpaceMedium,
                      FindYourLocation(
                        onTap: model.goToFilterView,
                      ),
                      verticalSpaceMedium,
                      TitleListTile(
                        onTap: model.goToProfileProductListView,
                        title: 'Categories',
                      ),
                      verticalSpaceMedium,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final category in model.categories) ...[
                              CategoryCard(
                                image: category.image,
                                category: category.category,
                                onTap: (){
                                  category.featureReady? model.goToPropertySearch() : model.showComingSoon();
                                },
                              ),
                              horizontalSpaceSmall,
                            ],
                          ],
                        ),
                      ),
                      verticalSpaceMedium,
                      TitleListTile(
                        onTap: model.goToProfileProductListView,
                        title: 'Top Cities',
                      ),
                      verticalSpaceSmall,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final city in model.topCities) ...[
                              TopCityCard(
                                image: city.image,
                                numberOfProperties: city.numberOfProperties,
                                location: city.location,
                              ),
                              horizontalSpaceSmall,
                            ]
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    this.category = '',
    required this.image,
    this.onTap
  }) : super(key: key);

  final String category;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: ResavationImage(
                  image: image,
                ),
              ),
            ),
            Text(
              category,
              style: AppStyle.kBodyBold.copyWith(
                color: kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopCityCard extends StatelessWidget {
  const TopCityCard({
    Key? key,
    required this.location,
    required this.image,
    required this.numberOfProperties,
  }) : super(key: key);

  final String location;
  final String image;
  final int numberOfProperties;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: ResavationImage(
                image: image,
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: AppStyle.kBodySmallBold.copyWith(
                    color: kWhite,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  numberOfProperties.toString() + ' Properties',
                  style: AppStyle.kBodySmallRegular.copyWith(
                    color: kWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleListTile extends StatelessWidget {
  const TitleListTile({
    Key? key,
    this.title = '',
    this.onTap,
  }) : super(key: key);

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyle.kSubHeading,
        ),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'See All',
            style: AppStyle.kBodySmallRegular12.copyWith(
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}