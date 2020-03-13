  
import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/pages/profile.dart';
import 'package:driver/ui/themes/styles.dart';
import 'package:driver/utils/rental.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'profile_image.dart';
BuildContext _ctx;
class TopAccountInfo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    _ctx = context;
    Size deviceSize = MediaQuery.of(context).size;
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Card(
            elevation: 3.0,
            margin: EdgeInsets.symmetric(
              horizontal: deviceSize.width * 0.03,
              vertical: deviceSize.height * 0.02,
            ),
            child: Container(
              alignment: Alignment.center,
              height: deviceSize.height * 0.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ProfileImage(),
                      buildAcountDetail(model.user.name,model.account.saldo.toString(),model.account.noAnggota),
                    ],
                  ),
                  Container(
                    height: 8.0,
                    width: 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }

  Widget buildAcountDetail(name,saldo,noAnggota){
    return Container(
      padding: EdgeInsets.only(
        left: 15.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 3.0,
              ),
              Text(
                saldo == null ? "0": RentalUtils.formatRupiah(saldo),
                style: TextStyle(
                  fontSize: 20.0,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(_ctx, MaterialPageRoute(builder: (_)=>ProfilePage()));
                },
                child: Icon(
                  Icons.remove_red_eye,
                  color: Colors.teal.shade200,
                  size: 20.0,
                ),
              )
            ],
          ),
          Text(
            noAnggota,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
