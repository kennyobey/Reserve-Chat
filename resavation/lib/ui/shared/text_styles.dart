import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static TextStyle kHeading1 = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    height: 30,
  );

  static TextStyle kBodyRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 18,
    height: 24 / 16,
  );
  static TextStyle kBodyBold = kBodyRegular.copyWith(fontWeight: FontWeight.bold);

  static TextStyle kBodySmallRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    height: 18,
  );
  static TextStyle kBodySmallBold = kBodyRegular.copyWith(fontWeight: FontWeight.bold);
}
