import 'dart:ui';

import 'package:flutter/material.dart';

class CustomInputDecoration {
  static const String defaultFont = "NeoSansW1gMedium";
  static const int primaryColor = 0xff096d5c;


  static TextStyle bold20Primary = TextStyle(
      color: Color(primaryColor),
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFont
  );

  static TextStyle bold20 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFont
  );

  static TextStyle regular12White = TextStyle(
      color: Colors.white,
      fontFamily: defaultFont,
      fontSize: 12
  );

  static TextStyle regular14 = TextStyle(
      fontSize: 14,
      fontFamily: defaultFont,
  );

  static TextStyle regular14White = TextStyle(
      color: Colors.white,
      fontFamily: defaultFont,
      fontSize: 14
  );

  static TextStyle regular24White = TextStyle(
      color: Colors.white,
      fontFamily: defaultFont,
      fontSize: 24
  );

  static TextStyle registrationHint = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontFamily: defaultFont,
      fontSize: 13
  );
}