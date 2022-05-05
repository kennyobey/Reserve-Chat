// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_add_cover_photo/property_owner_add_cover_photoViewModel.dart';

import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/resavation_button.dart';
import '../property_owner_add_photos/property_owner_add_photosViewModel.dart';

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
                // Center(
                //   child: Row(
                //     children: [
                //       _coverPhoto(),
                //       horizontalSpaceTiny,
                //       // Expanded(child: _Photo())
                //     ],
                //   ),
                // ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 2.2),
                  itemBuilder: (_, index) {
                    List<String> data = model.imageContainer;
                    print(".........$data");
                    return coverPhoto(
                        imageUrl: data[index],
                        isCover: (index == 0) ? true : false);
                  },
                  itemCount: model.imageContainer.length,
                ),
                verticalSpaceTiny,
                ResavationButton(
                  onTap: () {
                    model.pickFiles();
                  },
                  title: 'Add photos',
                  titleColor: kWhite,
                  buttonColor: kPrimaryColor,
                  //  borderColor: kp,
                ),
                // _Photo(),
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

Widget coverPhoto({required String imageUrl, required bool isCover}) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        border: Border.all(color: kGray),
        color: kGray,
        image: DecorationImage(
          image: FileImage(File(imageUrl)),
          fit: BoxFit.cover,
        )),
    width: 169,
    height: 86.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (isCover)
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kGray), color: kBlack),
                height: 26,
                width: 65,
                child: FlatButton(
                  child: Text(
                    'Cover',
                    style: AppStyle.kBodySmallRegular11W300
                        .copyWith(color: kWhite),
                  ),
                  color: kChatTextColor,
                  textColor: kBlack,
                  onPressed: () {},
                ),
              )
            : Container(),
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
