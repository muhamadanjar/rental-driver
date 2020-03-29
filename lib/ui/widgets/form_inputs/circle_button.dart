import 'package:flutter/material.dart';
import 'package:driver/ui/style/custom_box_decoration.dart';
import 'package:driver/ui/style/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleButton extends StatelessWidget {
  final String _title;
  final String _imgPath;
  final Color _btnColor;

  CircleButton(this._title, this._imgPath, this._btnColor);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: _btnColor, shape: BoxShape.circle),
          child: SvgPicture.asset(_imgPath),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Text(
            _title,
            style: CustomText.medium12,
          ),
        )
      ],
    );
  }
}