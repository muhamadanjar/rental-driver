import 'dart:async';

import 'package:dio/dio.dart';
import 'package:driver/models/order.dart';
import 'package:driver/models/responseapi.dart';
import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/themes/styles.dart';
import 'package:driver/ui/views/base_view.dart';
import 'package:driver/ui/widgets/ui_elements/driverMap.dart';
import 'package:driver/utils/sizedconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:scoped_model/scoped_model.dart';

class DetilOrder extends StatefulWidget {
  @override
  _DetilOrderState createState() => _DetilOrderState();
}

class _DetilOrderState extends State<DetilOrder> {
  LocationData _startLocation;
  LocationData _currentLocation;
  Location _locationService = new Location();

  StreamSubscription<LocationData> _locationSubscription;

  bool _permission = false;
  Order _order;
  String curOrderId;
  String statusOrder;

  String error;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Rental"),
        centerTitle: true,
      ),
      body: Container(
        child: BaseView<MainModel>(
            model: MainModel(),
            builder: (BuildContext context, Widget widget, MainModel model) {
              return model.isOrdered
                  ? Stack(
                      children: <Widget>[
//                DriverMap(),
                        Positioned(
                            bottom: 0,
                            left: 10,
                            right: 10,
                            child: _buildCard(model))
                      ],
                    )
                  : Card(
                      elevation: 8,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                          alignment: Alignment.center,
                          height: SizeConfig.blockHeight * 15,
                          child: Text("Tidak ada transaksi")),
                    );
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ScopedModel.of<MainModel>(context).checkOrder();

    initLocation();
  }

  initLocation() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status activated: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission result: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initLocation();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }

  slowRefresh() async {
    _locationSubscription.cancel();
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.BALANCED, interval: 10000);
    _locationSubscription =
        _locationService.onLocationChanged().listen((LocationData result) {
      if (mounted) {
        setState(() {
          _currentLocation = result;
        });
      }
    });
  }

  onRefresh(MainModel model) async {
    await model.checkOrder();
  }

  onChangeStatusOrder(Function change) async {
    var status =
        (ScopedModel.of<MainModel>(context).currentOrder.orderStatus + 1)
            .toString();
    var current =
        ScopedModel.of<MainModel>(context).currentOrder.orderId.toString();
    FormData fm = new FormData();
    fm.fields.add(MapEntry('order_id', current));
    fm.fields.add(MapEntry('status', status));
    print(current);
    print(status);
    ResponseApi response = await change(fm);
    print(response.message);
  }

  onCancelOrder(Function change) async {
    FormData fm = new FormData();
    fm.fields.add(MapEntry('order_id', curOrderId));
    fm.fields.add(MapEntry('status', Order.statusCANCEL));
    ResponseApi response = await change(fm);
    print(response.status);
  }

  Widget _buildCard(MainModel model) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Card(
            elevation: 8,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                          ),
                          child: Center(
                              child: Text(
                            "Pemesanan 0001",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                        ),
                        SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 100
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: <Widget>[
                                    Text("Tanggal Pesanan"),
                                    Text("Tanggal Pesanan"),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: <Widget>[
                                    Text("Tanggal Pesanan"),
                                    Text("Tanggal Pesanan"),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Lokasi Awal"),
                                  Text("Place 1"),
                                ]),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Lokasi Tujuan"),
                                  Text("Place 1"),
                                ]),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Harga"),
                                  Text("Rp."),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: Color(0xFFF100550),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              MaterialButton(
                                color: primaryColor,
                                onPressed: () {
//              onChangeStatusOrder(model.changeStatusOrder);
//              model.checkOrder();
                                },
                                child: Text("Jemput"),
                              ),
                              MaterialButton(
                                color: Color(0xFFFFF0000),
                                onPressed: () {
//              onCancelOrder(model.changeStatusOrder);
                                },
                                child: Text(
                                  "Batalkan",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
