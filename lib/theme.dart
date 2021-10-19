import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double figmaFont = 2/3;
const double mobileFont = 3/4;
const double mobileIcon = 4/5;

TextStyle textStyle(double width, Color color, FontWeight? weight, double fontSize) {
  return GoogleFonts.workSans(
    textStyle: TextStyle(
      color: color,
      fontWeight: weight,
      fontSize: width <= 767 ? fontSize * figmaFont * mobileFont : fontSize * figmaFont
    ),
  );
}