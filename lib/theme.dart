import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme() {
  return TextTheme(
    headline1: GoogleFonts.openSans(
        fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
    headline2: GoogleFonts.openSans(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
    bodyText1: GoogleFonts.openSans(
        fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
    bodyText2:
        GoogleFonts.openSans(fontSize: 14.0, color: Colors.black), //더 보기 폰트
    subtitle1: GoogleFonts.openSans(fontSize: 15.0, color: Colors.black),
    subtitle2: GoogleFonts.openSans(
        fontSize: 10.0, color: Colors.red, fontWeight: FontWeight.bold),
  );
}

AppBarTheme appTheme() {
  return AppBarTheme(
    centerTitle: false,
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0.0,
    toolbarTextStyle: TextTheme(
      headline6: GoogleFonts.nanumGothic(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ).bodyText2,
    titleTextStyle: TextTheme(
      headline6: GoogleFonts.nanumGothic(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ).headline6,
  );
}

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(),
    appBarTheme: appTheme(),
    primaryColor: Colors.blue,
  );
}
