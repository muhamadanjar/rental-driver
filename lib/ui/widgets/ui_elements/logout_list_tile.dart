import 'package:driver/ui/pages/dashboard2.dart';
import 'package:driver/utils/prefs.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../../scope/main_model.dart';

class LogoutListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            model.logout();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>DashboardTwoPage()));
//            Navigator.pushReplacementNamed(context, RoutePaths.Index);d
          },
        );
      },
    );
  }
}
