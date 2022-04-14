import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  // text style with 24px font size
  static TextStyle kHeading1 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 2,
  );

  // text style with 18px font size
  static TextStyle kHeading4 = GoogleFonts.philosopher(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 2,
  );

  static TextStyle kHeading0 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 2,
  );

  static TextStyle kHeading2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    height: 2,
  );

  // text style with 16px font size
  static TextStyle kHeading3 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 2,
  );

  static TextStyle kBodyRegularW500 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.5,
  );

  static TextStyle kBodyRegular = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.5,
  );

  // text style with 15px font size
  static TextStyle kBodyRegularBlack15 = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    height: 1.5,
    color: Colors.black,
  );

  // text style with 14px font size
  static TextStyle kBodyRegularBlack14W600 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
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

  static TextStyle kBodyRegularBlack14 = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 1.5,
    color: Colors.black,
  );

  // text style with 13px font size
  static TextStyle kSubHeadingW600 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 13,
    height: 2,
  );

  static TextStyle kSubHeading = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 13,
    height: 2,
  );

  static TextStyle kBodySmallRegular = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal,
    fontSize: 13,
    height: 1.5,
  );

  // text style with 12px font size
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

  // text style with 11px font size
  static TextStyle kBodySmallRegular11W300 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300,
    fontSize: 11,
    height: 1.5,
  );

  static TextStyle kBodySmallRegular11W400 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 1.5,
  );

  static TextStyle kBodySmallRegular11W500 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 1.5,
  );

  // text style with 10px font size
  static TextStyle kBodySmallRegular10W400 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.5,
  );

  static TextStyle kBodyBold =
      kBodyRegular.copyWith(fontWeight: FontWeight.bold);
  static TextStyle kBodyBoldBlack =
      kBodyRegular.copyWith(fontWeight: FontWeight.bold, color: Colors.black);

  //static TextStyle kBodyBoldBlack = kBodyRegular.copyWith(fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle kBodySmallBold =
      kBodyRegular.copyWith(fontWeight: FontWeight.bold);
}
