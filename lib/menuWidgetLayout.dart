// ignore_for_file: file_names

import 'package:abb_hackerthon/listPageLayout.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: const EdgeInsets.only(right: 0), // 여기를 수정하였습니다.
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ]),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '지도',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewScreen()),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 35,
              margin: const EdgeInsets.only(left: 0),
              decoration: const BoxDecoration(
                color: Color(0xFFFaFaFa),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '리스트',
                    style: TextStyle(
                        color: Color.fromARGB(255, 187, 187, 187),
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
