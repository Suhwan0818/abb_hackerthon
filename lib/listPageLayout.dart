// ignore_for_file: file_names, camel_case_types
import 'dart:convert';
import 'package:abb_hackerthon/listMenuWidgetLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadTourList(),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  '나만 아는 명소',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.amber),
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const ListMenuWidget(),
                      ...snapshot.data!,
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator(); // 로딩 중일 때는 로딩 인디케이터를 표시
          }
        });
  }

  Future<List<Widget>> _loadTourList() async {
    String jsonString = await rootBundle.loadString('assets/db.json');
    List<dynamic> data = jsonDecode(jsonString);
    List<Widget> tourLists = [];
    for (var item in data) {
      tourLists.add(tourList(
        type: item['type'],
        name: item['name'],
        perce: item['perce'],
      ));
    }
    return tourLists;
  }
}

class tourList extends StatefulWidget {
  final String type;
  final String name;
  final int perce;

  const tourList(
      {Key? key, required this.type, required this.name, required this.perce})
      : super(key: key);

  @override
  _tourListState createState() => _tourListState();
}

class _tourListState extends State<tourList> {
  @override
  Widget build(BuildContext context) {
    String status;
    Color color;

    if (widget.perce <= 25) {
      status = "원활";
      color = Colors.green;
    } else if (widget.perce <= 50) {
      status = "보통";
      color = Colors.lightGreen;
    } else if (widget.perce <= 75) {
      status = "혼잡";
      color = Colors.orange;
    } else {
      status = "복잡";
      color = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 75,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.type,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      widget.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '전일 대비 ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: '${widget.perce}%',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
