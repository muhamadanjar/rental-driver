import 'dart:async';

import 'package:driver/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class DriverMap extends StatefulWidget {
  @override
  _DriverMapState createState() => _DriverMapState();

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(3.6422756, 98.5294038),
    zoom: 11.0,
  );
}

class _DriverMapState extends State<DriverMap> {
  GoogleMapController mapController;

  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  
  Set<Marker> _markers;
  Set<Polyline> _polylines;

  Completer<GoogleMapController> _controller = Completer();

  PolylineId selectedPolyline;

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  LatLng _origin;
  LatLng _destination;
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  String googleAPIKey = google_web_api;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        initialCameraPosition: DriverMap._cameraPosition,
        markers: _markers,
        polylines: _polylines,
        onMapCreated: _onMapCreated,
      ),
    );
  }
  @override
  void initState() {
    setSourceAndDestinationIcons();
    super.initState();
  }

  void setSourceAndDestinationIcons() async {
      sourceIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/driving_pin.png');
      destinationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'assets/images/destination_map_marker.png');
    }

  void _onMapCreated(GoogleMapController controller) async{
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor){
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(){
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red, points: polylineCoordinates
    );
    polylines[id] = polyline;
    
  }

  _getPolyline() async{
    
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(google_web_api,
        _origin.latitude, _origin.longitude, _destination.latitude, _destination.longitude);
    if(result.isNotEmpty){
      result.forEach((PointLatLng point){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  setPolylines() async {

        List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
            googleAPIKey,
            _origin.latitude,
            _origin.longitude,
            _destination.latitude,
            _destination.longitude);
        if (result.isNotEmpty) {
          // loop through all PointLatLng points and convert them
          // to a list of LatLng, required by the Polyline
          result.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        }

      setState(() {
          // create a Polyline instance
          // with an id, an RGB color and the list of LatLng pairs
          Polyline polyline = Polyline(
              polylineId: PolylineId("poly"),
              color: Color.fromARGB(255, 40, 122, 198),
              points: polylineCoordinates);

          // add the constructed polyline as a set of points
          // to the polyline set, which will eventually
          // end up showing up on the map
          _polylines.add(polyline);
      });
  }
}