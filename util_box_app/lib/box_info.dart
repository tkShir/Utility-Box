import 'package:flutter/material.dart';

enum BoxType { UtilBox, URLBox, AppBox }

class BoxInfo extends Object {
  final String boxTitle;
  final IconData iconData;
  final BoxType boxType;
  final String boxURL;
  final String appName;

  BoxInfo({
    @required this.boxTitle,
    this.iconData,
    @required this.boxType,
    this.boxURL,
    this.appName,
  });   
}
