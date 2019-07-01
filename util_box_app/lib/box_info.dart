import 'package:flutter/material.dart';

enum BoxType {
  UtilBox,
  URLBox,
}

class BoxInfo extends Object {
  final String boxTitle;
  final Color boxColor;
  final Color textColor;
  final IconData iconData;
  final BoxType boxType;
  final String boxURL;
  final String appName;

  BoxInfo({
    @required this.boxTitle,
    this.boxColor,
    this.textColor,
    this.iconData,
    @required this.boxType,
    this.boxURL,
    this.appName,
  });
}
