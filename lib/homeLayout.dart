// ignore_for_file: file_names
import 'dart:async';

import 'package:abb_hackerthon/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'googleMap.dart';

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '재난알림이',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
            )),
        body: Center(
          child: Column(children: <Widget>[
            NowLocation(),
            WeatherAndAlert(),
            customGoogleMap(),
            AlertState(),
          ]),
        ));
  }
}

class NowLocation extends StatefulWidget {
  const NowLocation({super.key});

  @override
  _NowLocationState createState() => _NowLocationState();
}

class _NowLocationState extends State<NowLocation> {
  String _location = "현재 위치";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String locationName =
        await _getLocationName(position.latitude, position.longitude);
    setState(() {
      _location = locationName;
    });
  }

  _getLocationName(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      return pos.locality;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11.0, right: 11.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Icon(Icons.my_location),
            SizedBox(
              width: 5,
            ),
            Text('현재 위치 = 대구 중구'),
          ],
        ),
      ),
    );
  }
}

class WeatherAndAlert extends StatelessWidget {
  const WeatherAndAlert({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 11.0, right: 11.0, top: 11.0, bottom: 11.0),
      child: Row(
        children: [
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Text('날씨'),
          )),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Text('위험도'),
          )),
        ],
      ),
    );
  }
}

class AlertState extends StatefulWidget {
  const AlertState({super.key});

  @override
  State<AlertState> createState() => _AlertStateState();
}

class _AlertStateState extends State<AlertState> {
  int _counter = 0;
  int _targetNumber = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  void _requestNotificationPermissions() async {
    final status = await NotificationService().requestNotificationPermissions();
    if (status.isDenied && context.mounted) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('알림 권한이 거부되었습니다.'),
                content: Text('알림을 받으려면 앱 설정에서 권한을 허용해야 합니다.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('설정'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      openAppSettings();
                    },
                  ),
                  TextButton(
                    child: Text('취소'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: _toggleTimer,
        child: Text(_timer?.isActive == true ? '정지' : '시작'),
      ),
    );
  }

  void _toggleTimer() {
    if (_timer?.isActive == true) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _counter++;
        if (_counter == 10) {
          NotificationService().showNotification();
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }
}
