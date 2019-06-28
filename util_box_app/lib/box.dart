import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UtilBox extends StatelessWidget {
  final double sampleBoxHeight = 231.42;

  final double boxHeight;
  final double boxWidth;
  final String title;
  final IconData iconData;
  final IconData _defaultIcon = Icons.laptop_windows;
  UtilBox({this.boxWidth, this.boxHeight, this.title, this.iconData});

  // double boxWidth = (availWidth * 0.95) / 2;
  // double boxHeight = (availHeight * 0.95) / 2;

  @override
  Widget build(BuildContext context) {
    IconData iconDataBuild = iconData;

    if (iconDataBuild == null) {
      iconDataBuild = _defaultIcon;
    }
    return Container(
      width: boxWidth,
      height: boxHeight,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: boxHeight * 0.35, bottom: boxHeight * 0.15),
            child: Icon(
              iconDataBuild,
              size: boxHeight * 0.3,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22 * boxHeight / sampleBoxHeight,
            ),
          ),
        ],
      ),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
    );
  }
}

class URLBox extends UtilBox {
  final String boxUrl;

  URLBox(
      {double boxHeight,
      double boxWidth,
      String title,
      String url,
      IconData iconData,
      this.boxUrl})
      : super(
          boxWidth: boxWidth,
          boxHeight: boxHeight,
          title: title,
          iconData: iconData,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {}, child: super.build(context));
  }
}

class AppBox extends UtilBox {
  final String appName;
  AppBox(
      {double boxHeight,
      double boxWidth,
      String title,
      String url,
      IconData iconData,
      this.appName})
      : super(
          boxWidth: boxWidth,
          boxHeight: boxHeight,
          title: title,
          iconData: iconData,
        );
}
