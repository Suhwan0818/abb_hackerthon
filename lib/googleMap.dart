// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class customGoogleMap extends StatefulWidget {
  const customGoogleMap({super.key});

  @override
  State<customGoogleMap> createState() => _customGoogleMapState();
}

class _customGoogleMapState extends State<customGoogleMap> {
  late LatLng _currentPosition = const LatLng(35.8714354, 128.601445);
  Set<Marker> _marker = Set<Marker>();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _marker.add(Marker(
        markerId: MarkerId('current_location'),
        position: _currentPosition,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20), // 위 아래로 10의 패딩 적용
      child: SizedBox(
        width: 375,
        height: 400,
        child: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: _currentPosition, zoom: 14),
          mapType: MapType.normal,
          markers: _marker,
        ),
      ),
    );
  }
}
