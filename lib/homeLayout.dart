// ignore_for_file: file_names
import 'dart:async';
import 'package:abb_hackerthon/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'googleMap.dart';
import 'carouselLayout.dart';
import 'menuWidgetLayout.dart';

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            '나만 아는 명소',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          actions: const <Widget>[AlertState()],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              Carousel(),
              NowLocation(),
              WeatherAndAlert(),
              MenuWidget(),
              customGoogleMap(),
            ]),
          ),
        ));
  }
}

class NowLocation extends StatefulWidget {
  const NowLocation({super.key});

  @override
  _NowLocationState createState() => _NowLocationState();
}

class _NowLocationState extends State<NowLocation> {
  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _checkPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    }
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String? locationName =
        await _getLocationName(position.latitude, position.longitude);
    setState(() {});
  }

  Future<String?> _getLocationName(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      return pos.locality;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11.0, right: 11.0, top: 13.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
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
      padding: const EdgeInsets.all(11.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '날씨',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wb_cloudy,
                          color: Colors.blue), // 원하는 아이콘을 선택하세요.
                      Text('흐림'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '주변 추천 관광지',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_cafe_rounded,
                          color: Colors.brown), // 원하는 아이콘을 선택하세요.
                      Text('대구 리시트'),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _requestNotificationPermissions() async {
    final status = await NotificationService().requestNotificationPermissions();
    if (status.isDenied && context.mounted) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('알림 권한이 거부되었습니다.'),
                content: const Text('알림을 받으려면 앱 설정에서 권한을 허용해야 합니다.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('설정'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      openAppSettings();
                    },
                  ),
                  TextButton(
                    child: const Text('취소'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: _toggleTimer,
        child: Icon(
          _timer?.isActive == true
              ? Icons.notifications
              : Icons.notifications_off,
          color: Colors.black,
        ),
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
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
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
