import 'package:driver/ui/themes/styles.dart';
import 'package:driver/utils/sizedconfig.dart';
import 'package:flutter/material.dart';
class ViewUbahPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: SizeConfig.blockHeight * 85,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Password Lama',
                  style: headerStyle,
                  
                ),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    
                  ),
                ),
                Divider(),
                Text(
                  'Password Baru',
                  style: headerStyle,
                ),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(),
                ),
                Divider(),
                Text(
                  'Ulangi Password Baru',
                  style: headerStyle,
                ),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 1,
              right: 1,
              child: SizedBox(
                width: double.infinity,
                height: SizeConfig.blockHeight *10, 
                child: RaisedButton(
                  onPressed: null,
                  child: Text("Ubah Data",style: mediumTextStyle,),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}