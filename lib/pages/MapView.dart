import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewFood extends StatefulWidget {
  @override
  State<MapViewFood> createState() => _MapViewFood();
}

class _MapViewFood extends State<MapViewFood> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};
  List<LatLng> posciones = [];
  Set<Polyline> polylines = {};
  bool control=true;
  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(40.363603060685826, -3.690581293030221),
    zoom: 5.8,
  );
  late BitmapDescriptor icon=BitmapDescriptor.defaultMarker;
  @override
  void initState() {
    super.initState();
    posciones.addAll([
      const LatLng(30.363603060685826, -3.690581293030221),
      const LatLng(34.363603060685826, -3.690581293030221)
    ]);
    Future.delayed(const Duration(seconds:1), () async {
      icon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "assets/images/ic_map.png");
      setState(() {
        control=false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child:control? const Center(
        child:  CircularProgressIndicator(
          color: Colors.black38,
          strokeWidth: 6,
        ),
      ): GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialCamera,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
              markerId: MarkerId("Tasty Dash"),
              icon:icon,
              position: LatLng(40.363603060685826, -3.690581293030221)),
          Marker(
              markerId: MarkerId("Tasty Dash"),
              icon:icon,
              position: LatLng(37.235278, -5.403717)),
          Marker(
              markerId: MarkerId("Tasty Dash"),
              icon:icon,
              position: LatLng(37.797792, -6.581940))
        },
      ),
    );
  }


}
