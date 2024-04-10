import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewFood extends StatefulWidget {
  @override
  State<MapViewFood> createState() => _MapViewFood();
}

class _MapViewFood extends State<MapViewFood> {
  late Completer<GoogleMapController> _controller;
  late CameraPosition _initialCamera;
  late BitmapDescriptor icon;
  @override
  void initState() {
    super.initState();
  }
@override
  void dispose() {
    super.dispose();
  }
  Future<void> reload() async{
    _controller = Completer<GoogleMapController>();
    _initialCamera = const CameraPosition(
      target: LatLng(40.363603060685826, -3.690581293030221),
      zoom: 5.8,
    );
    icon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "assets/images/ic_map.png");
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return FutureBuilder(
        future: reload(), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return  Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
            child:const Center(
              child: CircularProgressIndicator(),
      )
          );
        }
        if(snapshot.hasError){
          return  Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            )
          );
        }else{
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCamera,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                  markerId: const MarkerId("Tasty Dash"),
                  icon:icon,
                  position: const LatLng(40.363603060685826, -3.690581293030221)),
              Marker(
                  markerId: const MarkerId("Tasty Dash"),
                  icon:icon,
                  position: const LatLng(37.235278, -5.403717)),
              Marker(
                  markerId: const MarkerId("Tasty Dash"),
                  icon:icon,
                  position: const LatLng(37.797792, -6.581940))
            },
          );
        }
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