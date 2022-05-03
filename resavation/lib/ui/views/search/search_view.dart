import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_card.dart';
import 'package:resavation/ui/shared/dump_widgets/properties_sort.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  AlgoliaAPI algoliaAPI = AlgoliaAPI();
  String _searchText = "";
  List<SearchHit> _hitsList = [];

  TextEditingController _textFieldController = TextEditingController();

  Future<void> _getSearchResult(String query) async {
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
  }

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      if (_searchText != _textFieldController.text) {
        setState(() {
          _searchText = _textFieldController.text;
        });
        _getSearchResult(_searchText);
      }
    });
    _getSearchResult('');
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: ResavationAppBar(
            title: "Search",
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                FindYourLocation(
                  controller: _textFieldController,
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

  Widget buildBody(SearchViewModel model) {
    final properties = model.properties;
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final property = properties[index];
        return PropertyCard(
          id: property.id,
          onTap: () => model.goToPropertyDetails(property),
          image: property.image,
          amountPerYear: property.amountPerYear,
          location: property.location,
          address: property.address,
          numberOfBathrooms: property.numberOfBedrooms,
          numberOfBedrooms: property.numberOfBathrooms,
          squareFeet: property.squareFeet,
          isFavoriteTap: property.isFavoriteTap,
          onFavoriteTap: () => model.onFavoriteTap(property),
        );
      },
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      itemCount: properties.length,
    );
  }
}

class AlgoliaAPI {
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
}

class SearchHit {
  final String name;
  final String image;

  SearchHit(this.name, this.image);

  static SearchHit fromJson(Map<String, dynamic> json) {
    return SearchHit(json['name'], json['image']);
  }
}
