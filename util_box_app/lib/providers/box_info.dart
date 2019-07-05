import 'package:flutter/material.dart';

import '../models/box_info.dart';
import '../util/t_c_logo_icons.dart';

class BoxInfoProvider with ChangeNotifier {
  List<String> hello = [''];
  List<BoxInfo> _boxInfos = [];
  List<BoxInfo> _exBoxInfo = [
    BoxInfo(
      boxTitle: "Student Link",
      boxType: BoxType.URLBox,
      iconData: Icons.school,
      boxUrl: 'http://www.bu.edu/studentlink',
      boxColor: Color.fromRGBO(225, 188, 41, 0.8),
      textColor: Colors.white,
    ),
    BoxInfo(
      boxTitle: "Line",
      boxType: BoxType.URLBox,
      iconData: Icons.message,
      boxUrl: 'https://line.me/R/nv/chat',
    ),
    BoxInfo(
      boxTitle: "GMail",
      boxType: BoxType.URLBox,
      boxUrl: 'googlegmail://',
      iconData: Icons.mail,
    ),
    BoxInfo(
      boxTitle: "TechCrunch",
      boxType: BoxType.URLBox,
      boxUrl: 'https://techcrunch.com/',
      iconData: TCLogo.tc_logo,
    ),
  ];
  List<BoxInfo> get exampleInfo {
    return [..._exBoxInfo];
  }

  List<BoxInfo> get boxInfos {
    return [..._boxInfos];
  }
}
