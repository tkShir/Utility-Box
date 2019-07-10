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
  ),
  defaultAppsInfo['LINE'],
  defaultAppsInfo['Gmail'],
  BoxInfo(
    boxTitle: "TechCrunch",
    boxType: BoxType.URLBox,
    boxUrl: 'https://techcrunch.com/',
    iconData: TCLogo.tc_logo,
  ),
];

final List<String> defaultApps = [
  '',
  'LINE',
  'Gmail',
  'Google Maps',
  'Facebook',
  'YouTube',
  'WhatsApp',
  'Instagram',
  'Twitter',
  'Snapchat'
];

final Map<String, BoxInfo> defaultAppsInfo = {
  '': BoxInfo(
      boxTitle: '',
      boxType: BoxType.AppBox,
      iconData: Icons.check_box_outline_blank,
      boxUrl: ''),
  'LINE': BoxInfo(
    boxTitle: "LINE",
    boxType: BoxType.AppBox,
    iconData: Icons.message,
    boxUrl: 'https://line.me/R/nv/chat',
  ),
  'Gmail': BoxInfo(
    boxTitle: "Gmail",
    boxType: BoxType.AppBox,
    boxUrl: 'googlegmail://app',
    iconData: Icons.mail,
  ),
  'Google Maps': BoxInfo(
    boxTitle: 'Google Maps',
    boxType: BoxType.AppBox,
    boxUrl: 'googlemaps://app',
    iconData: Icons.map,
  ),
  'Facebook': BoxInfo(
    boxTitle: 'Facebook',
    boxType: BoxType.AppBox,
    boxUrl: 'fb://app',
    iconData: Icons.face,
  ),
  'YouTube': BoxInfo(
    boxTitle: 'YouTube',
    boxType: BoxType.AppBox,
    boxUrl: 'youtube://app',
    iconData: Icons.ondemand_video,
  ),
  'WhatsApp': BoxInfo(
    boxTitle: 'WhatsApp',
    boxType: BoxType.AppBox,
    boxUrl: 'googlegmail://app',
    iconData: Icons.message,
  ),
  'Instagram': BoxInfo(
    boxTitle: 'Instagram',
    boxType: BoxType.AppBox,
    boxUrl: 'instagram://app',
    iconData: Icons.camera,
  ),
  'Twitter': BoxInfo(
    boxTitle: 'Twitter',
    boxType: BoxType.AppBox,
    boxUrl: 'twitter://app',
    iconData: Icons.message,
  ),
  'Snapchat': BoxInfo(
    boxTitle: 'Snapchat',
    boxType: BoxType.AppBox,
    boxUrl: 'snapchat://app',
    iconData: Icons.camera_alt,
  ),
};
