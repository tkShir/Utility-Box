import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './box.dart';
import './box_info.dart';
import './box_layout.dart';

class Home extends StatelessWidget {
  List<BoxInfo> _exampleBoxInfos = [
    BoxInfo(
      boxTitle: "Student Link",
      boxType: BoxType.URLBox,
      iconData: Icons.school,
      boxURL: 'http://www.bu.edu/studentlink',
      boxColor: Color.fromRGBO(225, 188, 41, 0.8),
      textColor: Colors.white,
    ),
    BoxInfo(
        boxTitle: "Testing 2",
        boxType: BoxType.URLBox,
        iconData: Icons.all_inclusive),
    BoxInfo(
      boxTitle: "Line",
      boxType: BoxType.URLBox,
      boxURL: 'https://line.me/R/nv/chat',
      iconData: Icons.message,
    ),
    BoxInfo(boxTitle: "Testing 4", boxType: BoxType.UtilBox),
  ];

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Taka's Utility App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: deviceHeight * 0.2,
            child: Text("Hello, This is  a Placeholder"),
          ),
          Expanded(
            child: BoxLayout(_exampleBoxInfos),
          ),
        ],
      ),
    );
  }
}
