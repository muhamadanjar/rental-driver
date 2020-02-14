import 'package:flutter/material.dart';
class CardOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    Card(
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFF27A08B)),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),

        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, .9),
          ),
          padding: EdgeInsets.only(left: 16, top: 18, bottom: 0),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: < Widget > [
              Container(
                child: Image(
                  image: AssetImage("assets/images/ic_list_inbox.png"),
                ),
              ),

              SizedBox(width: 16, ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: < Widget > [
                    Text(
                      "Transaksi Transfer KOIN",
                      style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.black, fontFamily: 'NeoSansPro-Medium'),
                    ),
                    Divider(height: 2, ),
                    Text(
                      "01-11-2018  NAMA TUJUAN TRANSFER",
                      style: TextStyle(
                        fontSize: 10.0, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'NeoSansPro-Reguler'),
                    ),
                  ],
                ),
              )
            ],
          )
        ),
    );
  }
}