import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {

  static TextStyle kHeading0 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 2,
  );

  static TextStyle kHeading1 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 2,
  );

  static TextStyle kHeading2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    height: 2,
  );

  static TextStyle kHeading3 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 2,
  );

  static TextStyle kHeading4 = GoogleFonts.philosopher(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 2,
  );

  static TextStyle kSubHeading = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 13,
    height: 2,
  );


  static TextStyle kBodyRegular = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.5,
  );

  static TextStyle kBodyRegularW500 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.5,
  );

  static TextStyle kBodyRegularBlack14 = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 1.5,
    color: Colors.black,
  );

  static TextStyle kBodyRegularBlack14W500 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.5,
    color: Colors.black,
  );

  static TextStyle kBodyRegularBlack14W600 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.5,
    color: Colors.black,
  );
  static TextStyle kBodyBold = kBodyRegular.copyWith(fontWeight: FontWeight.bold );
  static TextStyle kBodyBoldBlack = kBodyRegular.copyWith(fontWeight: FontWeight.bold, color: Colors.black);

  //static TextStyle kBodyBoldBlack = kBodyRegular.copyWith(fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle kBodySmallRegular = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal,
    fontSize: 13,
    height: 1.5,
  );

  static TextStyle kBodySmallRegular12W500 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.5,
  );

  static TextStyle kBodySmallRegular12 = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    height: 1.5,
  );

  static TextStyle kBodySmallRegular12W300 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    height: 1.5,
  );

  static TextStyle kBodySmallRegular11W300 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300,
    fontSize: 11,
    height: 1.5,
  );

  static TextStyle kBodySmallBold = kBodyRegular.copyWith(fontWeight: FontWeight.bold);


}
