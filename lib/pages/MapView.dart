import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewFood extends StatefulWidget {
  final BitmapDescriptor icon;
  const MapViewFood({super.key,required this.icon});
  @override
  State<MapViewFood> createState() => _MapViewFood();
}

class _MapViewFood extends State<MapViewFood> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final CameraPosition _initialCamera= const CameraPosition(
    target: LatLng(40.363603060685826, -3.690581293030221),
    zoom: 5.8,
  );
  //icon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "assets/images/ic_map.png");
  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCamera,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
               Marker(
                  markerId:  const MarkerId("Tasty Dash"),
                  icon:widget.icon,
                  position:  const LatLng(40.363603060685826, -3.690581293030221)),
               Marker(
                  markerId:  const MarkerId("Tasty Dash"),
                  icon:widget.icon,
                  position:  const LatLng(37.235278, -5.403717)),
                Marker(
                  markerId:  const MarkerId("Tasty Dash"),
                  icon:widget.icon,
                  position:  const LatLng(37.797792, -6.581940))
            },
    );
  }
}
/*
control? const Center(
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
*/