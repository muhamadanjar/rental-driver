  
import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/widgets/ui_elements/transactions.dart';
import 'package:driver/utils/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../heading.dart';


class LastTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Heading(
          title: 'Transaksi Terakhir',
        ),
        SizedBox(
          height: 25.0,
        ),
        ScopedModelDescendant<MainModel>(
          builder:(context,child,MainModel model){
            print("Transaksi ${model.transactions}");
            return Flexible(
              child: Container(
                // color: Colors.red,
                height: deviceSize.height * 0.3,
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  physics: BouncingScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, int index) => Transaction(transaction: transactions[index],),
                ),
              ),
            );
          }
        ),
      ],
    );
  }
}
