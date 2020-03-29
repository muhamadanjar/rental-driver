import 'package:flutter/material.dart';
import 'package:driver/ui/style/custom_box_decoration.dart';
import 'package:driver/ui/style/custom_text.dart';


class CustomRegistrationButton extends StatelessWidget {
  final String _title;
  final bool _enable;

  CustomRegistrationButton(this._title, this._enable);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: (_enable)?CustomBoxDecoration.registrationButton:CustomBoxDecoration.registrationDisableButton,
      child: MaterialButton(
          padding: EdgeInsets.all(16),
          child:Text(
            _title,
            style: CustomText.bold14White,
          ), onPressed: () {},
        ),
      );
  }
}