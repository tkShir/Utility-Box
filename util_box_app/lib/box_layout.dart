import 'package:flutter/material.dart';
import 'dart:math';

import './box.dart';
import './box_info.dart';

class BoxLayout extends StatelessWidget {
  final List<BoxInfo> displayBoxInfos;
  List<UtilBox> displayBoxes;
  int gridAmount;
  int gridDim;

  BoxLayout(this.displayBoxInfos) {
    int boxAmount = displayBoxInfos.length;
    gridAmount = _ceilToNearestSquare(boxAmount);
    gridDim = sqrt(gridAmount).toInt();
  }

  List<UtilBox> createDisplayBoxes(List<BoxInfo> displayBoxInfo) {
    for (int i = 0; i >= displayBoxInfo.length; i++) {
      BoxInfo targetBoxInfo = displayBoxInfo[i];
      if (targetBoxInfo.boxType == BoxType.UtilBox) {
        UtilBox box = UtilBox();
      } else if (targetBoxInfo.boxType == BoxType.URLBox) {
        URLBox box = URLBox();
      } else if (targetBoxInfo.boxType == BoxType.AppBox) {
        AppBox box = AppBox();
      }
    }

    return [];
  }

  int _ceilToNearestSquare(int i) {
    int count = 1;
    int countSquared = 1;
    while (i > countSquared) {
      count++;
      countSquared = pow(count, 2).toInt();
    }
    return countSquared;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(
        100,
        (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline,
            ),
          );
        },
      ),
    );
  }
}
