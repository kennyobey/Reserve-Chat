import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static TextStyle kHeading1 = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 2,
  );

  static TextStyle kBodyRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.5,
  );
  static TextStyle kBodyBold = kBodyRegular.copyWith(fontWeight: FontWeight.bold);
  static TextStyle kBodyBoldBlack = kBodyRegular.copyWith(fontWeight: FontWeight.bold, color: Colors.black);

  //static TextStyle kBodyBoldBlack = kBodyRegular.copyWith(fontWeight: FontWeight.bold, color: Colors.black);


  static TextStyle kBodySmallRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 1.5,
  );

  static TextStyle kBodySmallRegularBlack = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 1.5,
    color: Colors.black,
  );
  static TextStyle kBodySmallBold = kBodyRegular.copyWith(fontWeight: FontWeight.bold);


}
