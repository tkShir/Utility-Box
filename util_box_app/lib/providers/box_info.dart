import 'package:flutter/material.dart';

import '../models/box_info.dart';
import '../util/t_c_logo_icons.dart';
import '../util/default_assets.dart';

class BoxInfoProvider with ChangeNotifier {
  List<String> hello = [''];
  bool _displayDefaultBox = true;
  List<BoxInfo> _defaultBoxInfos = defaultBoxInfos;
  List<BoxInfo> _boxInfos = [];

  List<BoxInfo> get boxInfos {
    if (_displayDefaultBox) {
      return [...(_defaultBoxInfos + _boxInfos)];
    }
    return [..._boxInfos];
  }

  void addBox(BoxInfo boxInfo) {
    _boxInfos.add(boxInfo);
  }

  void deleteBox(int index) {
    _boxInfos.removeAt(index);
  }

  void editBox(BoxInfo boxInfo, int index) {
    if (_displayDefaultBox) {
      index > _defaultBoxInfos.length - 1
          ? _boxInfos[index - _defaultBoxInfos.length] = boxInfo
          : _defaultBoxInfos[index] = boxInfo;
    } else {
      _boxInfos[index] = boxInfo;
    }
  }
}
