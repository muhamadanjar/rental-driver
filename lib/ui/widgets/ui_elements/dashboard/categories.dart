import 'package:driver/ui/pages/detil_order.dart';
import 'package:driver/ui/pages/profile.dart';
import 'package:driver/ui/pages/request_saldo.dart';
import 'package:driver/ui/widgets/ui_elements/dashboard/category.dart';

import 'package:flutter/material.dart';

import '../heading.dart';

import '../../../../utils/prefs.dart';



class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Heading(
          title: 'would you like to?',
        ),
        SizedBox(
          height: 25.0,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            // primary: true,
            children: categories
                .map((item) => InkWell(
                  onTap: (){ 
                    if (item['id']=='transfer') {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RequestSaldoPage()));
                    }else if (item['id']=='transaksi') {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>DetilOrder()));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfilePage()));
                    }
                  },
                  child: Category(
                    title: item['title'],
                    image: item['image'],
                  ),
                ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
