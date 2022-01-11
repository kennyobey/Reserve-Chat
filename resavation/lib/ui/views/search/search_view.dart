import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              verticalSpaceLarge,
              FindYourLocation(),
            ],
          ),
        )),
      ),
      viewModelBuilder: () => SearchViewModel(),
    );
  }
}
