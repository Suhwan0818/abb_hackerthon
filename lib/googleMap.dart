// ignore_for_file: camel_case_types, file_names

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class customGoogleMap extends StatefulWidget {
  const customGoogleMap({super.key});

  @override
  State<customGoogleMap> createState() => _customGoogleMapState();
}

class _customGoogleMapState extends State<customGoogleMap> {
  late LatLng _currentPosition = const LatLng(37.5519, 126.9918);
  final Set<Marker> _marker = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadMarkers();
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _marker.add(Marker(
        markerId: const MarkerId('current_location'),
        position: _currentPosition,
      ));
    });
  }

  void _loadMarkers() async {
    String jsonString = await rootBundle.loadString('assets/db.json');
    List<dynamic> data = jsonDecode(jsonString);
    for (var item in data) {
      _marker.add(Marker(
        markerId: MarkerId(item['name']),
        position: LatLng(item['latitude'], item['longitude']),
        infoWindow: InfoWindow(title: item['name']),
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20), // 위 아래로 10의 패딩 적용
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
