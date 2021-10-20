import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

const double figmaFont = 2/3;
const double mobileFont = 3/4;
const double mobileIcon = 4/5;


const double breakpoint = 767;
const double mobile = 2/3;

const FontWeight thin = FontWeight.w100;
const FontWeight extralight = FontWeight.w200;
const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semibold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extrabold = FontWeight.w800;
const FontWeight black = FontWeight.w900;

const FontStyle italic = FontStyle.italic;

TextStyle textStyle(double width, Color color, FontWeight? weight, double fontSize) {
  return GoogleFonts.workSans(
    textStyle: TextStyle(
      color: color,
      fontWeight: weight,
      fontSize: width <= 767 ? fontSize * figmaFont * mobileFont : fontSize * figmaFont
    ),
  );
}