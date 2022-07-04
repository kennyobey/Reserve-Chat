import 'package:flutter/material.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_sort.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  // AlgoliaAPI algoliaAPI = AlgoliaAPI();
  // String _searchText = "";
  // List<SearchHit> _hitsList = [];

/*   Future<void> _getSearchResult(String query) async {
    try {
      final response = await algoliaAPI.search(query);
      if (response != null) {
        final hitsList = (response['hits'] as List).map((json) {
          return SearchHit.fromJson(json);
        }).toList();
        setState(() {
          _hitsList = hitsList;
        });
      } else {
        setState(() {
          _hitsList = [];
        });
      }
    } catch (exception) {
      setState(() {
        _hitsList = [];
      });
    }
  } */

  @override
  void initState() {
    super.initState();
    /*    _textFieldController.addListener(() {
      if (_searchText != _textFieldController.text) {
        setState(() {
          _searchText = _textFieldController.text;
        });
        _getSearchResult(_searchText);
      }
    });
    _getSearchResult(''); */
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: buildAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                FindYourLocation(
                  controller: model.textFieldController,
                  onTap: model.goToFilterView,
                ),
                verticalSpaceSmall,
                const Divider(),
                SortProperty(
                  noOfProperties: model.properties.length,
                  sortByTitle: 'Default Order',
                ),
                const Divider(),
                verticalSpaceSmall,
                Expanded(
                  child: buildBody(model),
                ),
              ],
            ),
          )),
      viewModelBuilder: () => SearchViewModel(),
    );
  }

  ResavationAppBar buildAppBar() {
    return ResavationAppBar(
      title: "Search",
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

  Widget buildBody(SearchViewModel model) {
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

  Widget buildBodyItem(List<Property> properties, SearchViewModel model) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              final property = properties[index];

              return PropertyCard(
                id: property.id ?? -1,
                onTap: () => model.goToPropertyDetails(property),
                image: property.propertyImages?[0].imageUrl ?? '',
                amountPerYear: property.spacePrice ?? 0,
                propertyName: property.propertyName ?? '',
                address: property.address ?? '',
                numberOfBathrooms: property.bathTubCount ?? 0,
                numberOfBedrooms: property.bedroomCount ?? 0,
                squareFeet: property.surfaceArea ?? 0.0,
                isFavoriteTap: property.favourite ?? false,
                onFavoriteTap: () async {
                  try {
                    await model.onFavoriteTap(property);
                  } catch (exception) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(exception.toString())));
                  }
                },
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
        const Spacer(),
        Text(
          'No property yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly check back later for the specified property',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }
}

/* class AlgoliaAPI {
  static const platform = const MethodChannel('com.algolia/api');

  Future<dynamic> search(String query) async {
    try {
      var response =
          await platform.invokeMethod('search', ['instant_search', query]);
      return jsonDecode(response);
    } on PlatformException catch (_) {
      return null;
    }
  }
} */

/* class SearchHit {
  final String name;
  final String image;

  SearchHit(this.name, this.image);

  static SearchHit fromJson(Map<String, dynamic> json) {
    return SearchHit(json['name'], json['image']);
  }
}
 */
