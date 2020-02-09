import 'package:driver/models/history.dart';
import 'package:driver/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class HisCard extends StatelessWidget {
  final HisDetails hisDetails;
  final formatCurrency = NumberFormat.simpleCurrency(locale: "id_ID");
  final formatDate = DateFormat.yMMMd('en_us');

  HisCard({this.hisDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(color: hisBorderColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0),
                          color: Colors.blueAccent,
                        ),
                        child: Text("Promo",style: TextStyle(color: Colors.white),),
                      ),
                      Text("${(hisDetails.date)}")
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                    Text("${hisDetails.origin}"),
                    SizedBox(height: 5.0,),
                    Text("${hisDetails.origin}"),
                  ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Text(
                        '${formatCurrency.format(hisDetails.tripTotal)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "(${formatCurrency.format(hisDetails.tripTotal)})",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
//          Positioned(
//            top: 10.0,
//            right: 0.0,
//            child: Container(
//              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//              child: Text(
//                '${hisDetails.discount}%',
//                style: TextStyle(
//                    color: appTheme.primaryColor,
//                    fontSize: 14.0,
//                    fontWeight: FontWeight.bold),
//              ),
//              decoration: BoxDecoration(
//                color: discountBackgroundColor,
//                borderRadius: BorderRadius.all(
//                  Radius.circular(10.0),
//                ),
//              ),
//            ),
//          )
        ],
      ),
    );
  }
}