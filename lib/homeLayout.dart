// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
        body: const Center(
          child: Column(children: <Widget>[
            NowLocation(),
            WeatherAndAlert(),
            customGoogleMap(),
            Text('알림 OFF')
          ]),
        ));
  }
}

class NowLocation extends StatelessWidget {
  const NowLocation({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11.0, right: 11.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(10)),
          child: const Row(
            children: <Widget>[
              Icon(Icons.my_location),
              SizedBox(
                width: 5,
              ),
              Text("현재 위치")
            ],
          )),
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
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(10)),
            child: const Text('날씨'),
          )),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(10)),
            child: const Text('위험도'),
          )),
        ],
      ),
    );
  }
}
