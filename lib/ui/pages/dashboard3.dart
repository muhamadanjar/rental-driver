import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/themes/styles.dart';
import 'package:driver/ui/widgets/ui_elements/dashboard/categories.dart';
import 'package:driver/ui/widgets/ui_elements/dashboard/last_transaction.dart';
import 'package:driver/ui/widgets/ui_elements/dashboard/top_account_info.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class Dashboard3 extends StatefulWidget {
  @override
  _Dashboard3State createState() => _Dashboard3State();
}

class _Dashboard3State extends State<Dashboard3> {

  @override
  void initState() {
    ScopedModel.of<MainModel>(context).getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            color: primaryColor,
            height: deviceSize.height * 0.1,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: deviceSize.width * 0.03,
            ),
            child: Column(
              children: <Widget>[
                TopAccountInfo(),
                Flexible(
                  fit: FlexFit.tight,
                  child: RefreshIndicator(
                      onRefresh: () => onRefresh(ScopedModel.of<MainModel>(context)),
                      child: ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        Categories(),
                        LastTransactions(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
          // TopAccountInfo()
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome!',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'DRIVER'.toUpperCase(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          )
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Image.asset('assets/images/flutter.png'),
          tooltip: 'QR Scan',
          onPressed: () {},
        ),
      ],
    );
  }

  Future onRefresh(MainModel onGenerate){
    try {
      onGenerate.getUser();
      // onGenerate.getLastTransaksi();  
      
      return Future.delayed(Duration(seconds: 5));
    } catch (e) {
      print("response from api $e");
      
    }
    
    
  }
}