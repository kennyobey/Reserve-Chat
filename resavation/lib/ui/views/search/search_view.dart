import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'Search View',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => SearchViewModel(),
    );
  }
}
