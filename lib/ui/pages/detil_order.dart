import 'dart:async';

import 'package:driver/ui/widgets/card_order.dart';
import 'package:driver/ui/widgets/ui_elements/driverMap.dart';
import 'package:driver/utils/sizedconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

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

  String error;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Rental"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            DriverMap(),
            Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: CardOrder()
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

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
}