import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/box_info.dart';
import '../util/default_assets.dart';

class BoxInfoProvider with ChangeNotifier {
  bool _loadedBoxes = false;
  static bool _displayDefaultBox = false;
  List<BoxInfo> _boxInfos = _displayDefaultBox ? [...defaultBoxInfos] : [];

  List<BoxInfo> get boxInfos {
    return [..._boxInfos];
  }

  bool get loadedBoxes {
    return _loadedBoxes;
  }

  void toggleLoadedBox() {
    if (!_loadedBoxes) {
      _loadedBoxes = true;
    }
  }

  void toggleDisplayDefaultBox() {
    _displayDefaultBox = !_displayDefaultBox;
    notifyListeners();
  }

  void addBox(BoxInfo boxInfo) {
    _boxInfos.add(boxInfo);
    saveAllBoxes();
    notifyListeners();
  }

  void deleteBox(int index) {
    _boxInfos.removeAt(index);
    saveAllBoxes();
    notifyListeners();
  }

  void editBox(BoxInfo boxInfo, int index) {
    _boxInfos[index] = boxInfo;
    saveAllBoxes();
    notifyListeners();
  }

  void switchOrder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final BoxInfo removedBox = _boxInfos.removeAt(oldIndex);
    _boxInfos.insert(newIndex, removedBox);
    saveAllBoxes();
    notifyListeners();
  }

  Future<bool> saveAllBoxes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> convertedBoxInfos = [];
    for (int i = 0; i < _boxInfos.length; i++) {
      convertedBoxInfos.add(convertBoxInfoToMap(_boxInfos[i]));
    }
    String encodedBoxInfojson = json.encode(convertedBoxInfos);
    prefs.setString('boxInfos', encodedBoxInfojson);
    notifyListeners();
  }

  Future<bool> loadAllBoxes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonBoxInfos = prefs.getString('boxInfos');
    if (jsonBoxInfos == null) {
      return false;
    } else {
      try {
        List<dynamic> decodedBoxInfos = json.decode(jsonBoxInfos);
        for (int i = 0; i < decodedBoxInfos.length; i++) {
          _boxInfos.add(converMapstoBoxInfo(decodedBoxInfos[i]));
        }
        print("Loaded");
        return true;
      } catch (error) {
        print(error);
        return false;
      }
    }
  }

  BoxInfo converMapstoBoxInfo(Map decodedBoxInfos) {
    BoxInfo boxInfo = BoxInfo(
      boxTitle: decodedBoxInfos['boxTitle'],
      boxColor: colorFromString(decodedBoxInfos['boxColor']),
      textColor: colorFromString(decodedBoxInfos['textColor']),
      iconData: iconFromString(decodedBoxInfos['iconData']),
      boxType: boxTypeFromString(decodedBoxInfos['boxType']),
      boxUrl: decodedBoxInfos['boxUrl'],
      appName: decodedBoxInfos['appName'] == "null"
          ? null
          : decodedBoxInfos['appName'],
    );
    return boxInfo;
  }

  Color colorFromString(String colorString) {
    if (colorString == "null") {
      return null;
    }
    String valueString =
        colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color color = new Color(value);
    return color;
  }

  IconData iconFromString(String iconString) {
    IconData iconData =
        IconData(int.parse(iconString), fontFamily: 'MaterialIcons');
    return iconData;
  }

  BoxType boxTypeFromString(String boxTypeString) {
    if (boxTypeString == "BoxType.URLBox") {
      return BoxType.URLBox;
    } else if (boxTypeString == "BoxType.AppBox") {
      return BoxType.AppBox;
    } else if (boxTypeString == "BoxType.PreMadeBox") {
      return BoxType.PreMadeBox;
    } else {
      return BoxType.URLBox;
    }
  }

  Map<String, String> convertBoxInfoToMap(BoxInfo boxInfo) {
    // final String boxTitle;
    // final Color boxColor;
    // final Color textColor;
    // final IconData iconData;
    // final BoxType boxType;
    // final String boxUrl;
    // final String appName;
    Map<String, String> boxInfoMap = {
      'boxTitle': boxInfo.boxTitle,
      'boxColor': boxInfo.boxColor.toString(),
      'textColor': boxInfo.textColor.toString(),
      'iconData': boxInfo.iconData.codePoint.toString(),
      'boxType': boxInfo.boxType.toString(),
      'boxUrl': boxInfo.boxUrl,
      'appName': boxInfo.appName.toString(),
    };
    return boxInfoMap;
  }
}
