import 'package:driver/models/order.dart';
import 'package:driver/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
class HisCard extends StatelessWidget {
  final Order hisDetails;
  final formatCurrency = NumberFormat.simpleCurrency(locale: "id_ID");
  final formatDate = DateFormat.yMMMd('en_us');

  HisCard({this.hisDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 3,
          child: Row(
            children: <Widget>[
              Container(
                height: 125,
                width: 110,
                padding:EdgeInsets.only(left: 0, top: 10, bottom: 70, right: 20),
                child:Container(
                  color: Colors.deepOrange,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "item.discount",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Discount",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "item.title",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                    Text(
                      "item.catagory",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Text(
                      "item.place",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.pink,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.pink,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.pink,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.pink,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.pink,
                          size: 18,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("item.ratings", style: TextStyle(
                          fontSize: 13
                        ),),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Ratings", style: TextStyle(fontSize: 13),),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
    );
  }
}