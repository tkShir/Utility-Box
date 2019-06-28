import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './box.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Taka's Utility App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text("Hello, This is  a Placeholder"),
      ),
    );
  }

  Widget _buildBox(String title, double availWidth, double availHeight,
      double screenRatioHeight,
      {Color color, String link, IconData iconData}) {
    if (iconData == null) {
      iconData = Icons.ac_unit;
    }
    double boxWidth = (availWidth * 0.95) / 2;
    double boxHeight = (availHeight * 0.95) / 2;
    print(boxHeight);
    return Container(
      width: boxWidth,
      height: boxHeight,
      child: Column(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: boxHeight * 0.3, bottom: boxHeight * 0.15),
            child: Icon(
              iconData,
              size: boxHeight * 0.3,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20 * boxHeight / 231.42,
            ),
          ),
        ],
      ),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
    );
  }
}
