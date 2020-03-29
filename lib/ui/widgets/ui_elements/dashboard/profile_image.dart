import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/themes/styles.dart';
import 'package:driver/ui/views/base_view.dart';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double height, width;
  final Color color;
  ProfileImage({this.height = 100.0, this.width = 100.0, this.color = primaryColor});
  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
      builder:(context,child,model)=> Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          image: DecorationImage(
            image: AssetImage('assets/images/avatar5.png'),
            fit: BoxFit.contain,
          ),
          border: Border.all(
            color: color,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}
