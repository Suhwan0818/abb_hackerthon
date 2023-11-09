// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class customGoogleMap extends StatefulWidget {
  const customGoogleMap({super.key});

  @override
  State<customGoogleMap> createState() => _customGoogleMapState();
}

class _customGoogleMapState extends State<customGoogleMap> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 375,
      height: 400,
      child: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(35.8714354, 128.601445), zoom: 11),
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
