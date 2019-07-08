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
}
