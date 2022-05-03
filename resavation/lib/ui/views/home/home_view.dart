import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Center(
              child: GestureDetector(
                onTap: model.goToEditProfileView,
                child: Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: ResavationImage(
                    image: model.userData.imageUrl ?? '',
                  ),
                ),
              ),
            ),
            title: Text(
              'Welcome ${model.userData.firstName.toUpperCase()}',
              style: AppStyle.kBodyRegularBlack14W600,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  model.goToMessage();
                },
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Find a\n',
                    style:
                        AppStyle.kHeading0.copyWith(color: kBlack, height: 1.5),
                    children: [
                      TextSpan(
                        text: 'Suitable Apartment',
                        style: AppStyle.kHeading2
                            .copyWith(color: kBlack, height: 1.5),
                      ),
                    ],
                  ),
                ),
                verticalSpaceMedium,
                FindYourLocation(
                  onTap: model.goToFilterView,
                ),
                verticalSpaceMedium,
                TitleListTile(
                  onTap: model.goToProfileProductListView,
                  visibility: true,
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
                          onTap: () {
                            category.featureReady
                                ? model.goToPropertySearch()
                                : model.showComingSoon();
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
                  visibility: true,
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
          )),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key, this.category = '', required this.image, this.onTap})
      : super(key: key);

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
    required this.visibility,
    this.onTap,
  }) : super(key: key);

  final String title;
  final void Function()? onTap;
  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyle.kSubHeadingW600,
        ),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Visibility(
            visible: visibility,
            child: Text(
              'See All',
              style: AppStyle.kBodySmallRegular12W500.copyWith(
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
