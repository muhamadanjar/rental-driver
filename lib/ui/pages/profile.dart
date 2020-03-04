import 'package:driver/scope/main_model.dart';
import 'package:driver/utils/rental.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
          child: RefreshIndicator(
            onRefresh: () => onRefesh(ScopedModel.of<MainModel>(context)),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildInfo(context),
                Divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tell customers a little about yourself",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 200,
                        height: 40,
                        margin: EdgeInsets.only(bottom: 5),
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          color: Colors.white,
                          borderRadius:BorderRadius.all(const Radius.circular(2.0)),
                        ),
                        child: Text('Tambah Keterangan',style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Divider(),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Tanggapan",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "Lihat Semua",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _buildInfo(BuildContext context){
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        String saldo = model.user != null ? (model.user.account != null ? model.user.account.saldo.toString() : '0' ):'0';
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      model.user != null ? model.user.email :'DriverName',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Trips",
                      style:TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  width: 1,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.black12))),
                ),
                InkWell(
                  onTap: (){
                    // Navigator.pushNamed(context, RoutePaths.Topup);
                  },
                  child: Column(
                    children: <Widget>[
                      Text(
                        RentalUtils.formatRupiah(saldo),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Saldo",
                        style:TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        );
      }
    );
  }

  Future<Null> onRefesh(MainModel model) async{
    await model.getUser();
  }
}