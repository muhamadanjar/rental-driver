import 'package:flutter/cupertino.dart';

class CustomRoundRec {

  static BoxDecoration greenButton = BoxDecoration(
    color: Color(0xff096d5c),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static BoxDecoration whiteButton = BoxDecoration(
    color: Color(0xfffff),
    border: Border.all(color: Color(0xff096d5c)),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static BoxDecoration whiteButtonSmall = BoxDecoration(
    color: Color(0xfffff),
    border: Border.all(color: Color(0xff096d5c)),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  static BoxDecoration greenButtonSmall = BoxDecoration(
    color: Color(0xff71ab3c),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

}