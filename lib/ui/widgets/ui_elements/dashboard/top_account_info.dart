  
import 'package:driver/models/user.dart';
import 'package:driver/models/user_saldo.dart';
import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/pages/profile.dart';
import 'package:driver/ui/themes/styles.dart';
import 'package:driver/ui/views/base_view.dart';
import 'package:driver/utils/rental.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'profile_image.dart';
BuildContext _ctx;
class TopAccountInfo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return BaseView<MainModel>(
      model: MainModel(),
      onModelReady: (MainModel model){
        model.getUser();
        model.getLastTransaksi();
      },
      builder: (context, child, MainModel model){
        User _user = model.user;
        UserSaldo _account = model.account;
        return view(context,_user,_account);
      },
      
    );
  }

  Widget view(BuildContext context,User user,UserSaldo account){
    Size deviceSize = MediaQuery.of(context).size;
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
                buildAcountDetail(user,account),
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
  }

  Widget buildAcountDetail(User user,UserSaldo account){
    String saldo = account.saldo.toString() ?? '0';
    String noAnggota = account.noAnggota ?? 'No Anggota';
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
            user.name.toUpperCase(),
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
                RentalUtils.formatRupiah(saldo),
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
