import 'dart:async';

import 'package:dio/dio.dart';
import 'package:driver/models/order.dart';
import 'package:driver/models/responseapi.dart';
import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/themes/styles.dart';
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

        child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context,Widget widget,MainModel model){

            return model.isOrdered ? Stack(
            children: <Widget>[
                DriverMap(),
                Positioned(
                bottom: 0,
                left: 10,
                right: 10,
                child: Card(
                  elevation: 5.0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFF27A08B)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 16, top: 18, bottom: 0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text("${model.currentOrder.orderCode}"),
                        ),
                        Text("${_currentLocation.latitude.toString()} ${_currentLocation.longitude.toString()}"),

                        MaterialButton(
                          color: primaryColor,
                          onPressed: (){
                            onChangeStatusOrder(model.changeStatusOrder);
                            model.checkOrder();
                          },
                          child: Text("Jemput"),
                        ),
                        MaterialButton(
                          color: Color(0xFFFFF0000),
                          onPressed: (){
                            onCancelOrder(model.changeStatusOrder);
                          },
                          child: Text("Batalkan"),
                        )

                      ],
                    ),
                  ),
                )
              )
            ],
          ):Card(
            elevation: 8,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              alignment: Alignment.center,
              height: SizeConfig.blockHeight * 15,
              child: Text("Tidak ada transaksi")
              ),
            );
          }

        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ScopedModel.of<MainModel>(context).checkOrder();
  
    initLocation();
  }

  initLocation() async{
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
  onRefresh(MainModel model) async{
    await model.checkOrder();
  }
  onChangeStatusOrder(Function change) async{
    var status = (ScopedModel.of<MainModel>(context).currentOrder.orderStatus+1).toString();
    var current = ScopedModel.of<MainModel>(context).currentOrder.orderId.toString();
    FormData fm = new FormData();
    fm.fields.add(MapEntry('order_id',current));
    fm.fields.add(MapEntry('status',status));
    print(current);
    print(status);
    ResponseApi response = await change(fm);
    print(response.message);
  }

  onCancelOrder(Function change) async{
    FormData fm = new FormData();
    fm.fields.add(MapEntry('order_id',curOrderId));
    fm.fields.add(MapEntry('status',Order.statusCANCEL));
    ResponseApi response = await change(fm);
    print(response.status);
  }
}