import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final BitmapDescriptor icon;

  const MapView({super.key, required this.icon});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final CameraPosition _initialCamera = const CameraPosition(
    target: LatLng(40.363603060685826, -3.690581293030221),
    zoom: 5,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialCamera,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: {
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(40.363603060685826, -3.690581293030221)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(37.235278, -5.403717)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(37.797792, -6.581940)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(36.138605, -5.343482)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(36.139927, -5.355039)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(36.182222, -5.491986)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(37.797792, -6.581940)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(36.516126, -4.887488)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(37.777700, -3.788151)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(37.777700, -3.788151)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(36.886578, -2.422885)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(37.777700, -3.788151)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(37.948973, -1.203196)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(38.987237, -1.867012)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(37.777700, -3.788151)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(38.966476, -5.856374)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(41.615344, -4.784401)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(43.001365, -7.552075)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(40.312628, -3.762907)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(40.491271, -3.685424)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(41.613380, -0.914315)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(41.601966, 0.571358)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(41.494159, 2.095264)),
        Marker(
            markerId: const MarkerId("Tasty Dash"),
            icon: widget.icon,
            position: const LatLng(41.303087, 2.052408)),
      },
    );
  }
}
