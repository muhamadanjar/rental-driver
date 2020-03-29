import 'package:flutter/cupertino.dart';

class CustomBoxDecoration {
  static BoxDecoration registrationBox = BoxDecoration(
      color: Color(0xff71ab3c),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
      )
  );

  static BoxDecoration registrationButton = BoxDecoration(
    color: Color(0xff096d5c),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static BoxDecoration registrationDisableButton = BoxDecoration(
    color: Color(0xff727272),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

}