import 'package:flutter/material.dart';

enum BoxType {
  AppBox,
  URLBox,
  PreMadeBox,
}

class BoxInfo extends Object {
  final String boxTitle;
  final Color boxColor;
  final Color textColor;
  final IconData iconData;
  final BoxType boxType;
  final String boxUrl;
  final String appName;

  BoxInfo({
    @required this.boxTitle,
    this.boxColor,
    this.textColor,
    this.iconData,
    @required this.boxType,
    this.boxUrl,
    this.appName,
  });
}
