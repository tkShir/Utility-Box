import 'package:flutter/material.dart';

import '../models/box_info.dart';
import 't_c_logo_icons.dart';

final Map<String, IconData> defaultIconChoice = {
  '': Icons.check_box_outline_blank,
  'Utility': Icons.build,
  'Educational': Icons.edit,
  'Informative': Icons.new_releases,
  'Random': Icons.help
};

final List<String> defaultCategories = [
  '',
  'Utility',
  'Educational',
  'Informative',
  'Random'
];

final List<BoxInfo> defaultBoxInfos = [
  BoxInfo(
    boxTitle: "Student Link",
    boxType: BoxType.URLBox,
    iconData: Icons.school,
    boxUrl: 'http://www.bu.edu/studentlink',
    boxColor: Color.fromRGBO(225, 188, 41, 0.8),
    textColor: Colors.white,
  ),
  defaultAppBox['LINE'],
  defaultAppBox['GMail'],
  BoxInfo(
    boxTitle: "TechCrunch",
    boxType: BoxType.URLBox,
    boxUrl: 'https://techcrunch.com/',
    iconData: TCLogo.tc_logo,
  ),
];

final Map<String, BoxInfo> defaultAppBox = {
  'LINE': BoxInfo(
    boxTitle: "Line",
    boxType: BoxType.URLBox,
    iconData: Icons.message,
    boxUrl: 'https://line.me/R/nv/chat',
  ),
  'GMail': BoxInfo(
    boxTitle: "GMail",
    boxType: BoxType.URLBox,
    boxUrl: 'googlegmail://',
    iconData: Icons.mail,
  ),
};
