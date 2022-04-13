// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_add_cover_photo/property_owner_add_cover_photoViewModel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerAddCoverPhotosView extends StatelessWidget {
  const PropertyOwnerAddCoverPhotosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAddCoverPhotosViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Center(
                  child: Text(
                    'Add Photos',
                    style: AppStyle.kBodyBold,
                  ),
                ),
                verticalSpaceMedium,
                // model.showAddedPhoto() != null?Wrap(
                //   children: model.showAddedPhoto().value!.map((imageOne){
                //     return Container(
                //         child:Container(
                //           height: 96, width:169,
                //           child: Image.file(File(imageOne.path)),
                //         )
                //     );
                //   }).toList(),
                // ):Container(),
                Center(
                  child: Row(
                    children: [
                      Expanded(child: _coverPhoto()),
                      horizontalSpaceTiny,
                      Expanded(child: _Photo())
                    ],
                  ),
                ),
                verticalSpaceTiny,
                _Photo(),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child: Text(
                        'Back',
                        style: AppStyle.kBodyRegular,
                      ),
                      color: kWhite,
                      textColor: kBlack,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Spacer(),
                    FlatButton(
                      child: Text(
                        'Next',
                        style: AppStyle.kBodyRegular,
                      ),
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        model.goToPropertyOwnerPaymentView();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAddCoverPhotosViewModel(),
    );
  }
}

Widget _coverPhoto() {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(border: Border.all(color: kGray), color: kGray),
    width: 169,
    height: 86.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: kGray), color: kBlack),
            height: 26,
            width: 83,
            child: FlatButton(
              child: Text(
                'Cover',
                style: AppStyle.kBodySmallRegular11W300.copyWith(color: kWhite),
              ),
              color: kChatTextColor,
              textColor: kBlack,
              onPressed: () {},
            ),
          ),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          height: 23,
          width: 60,
          child: FlatButton(
            child: Text(
              'Edit',
              style: AppStyle.kBodySmallRegular11W300,
            ),
            color: kWhite,
            textColor: kBlack,
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}

Widget _Photo() {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(border: Border.all(color: kGray), color: kGray),
    width: 169,
    height: 86.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(),
        Container(
          height: 23,
          width: 60,
          child: FlatButton(
            child: Text(
              'Edit',
              style: AppStyle.kBodySmallRegular11W300,
            ),
            color: kWhite,
            textColor: kBlack,
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}
