import 'package:flutter/material.dart';

import '../models/util_box.dart';
import '../models/box_info.dart';

class BoxLayout extends StatelessWidget {
  final List<BoxInfo> displayBoxInfos;
  
  final List<Color> boxColorPalette = [
    Color.fromRGBO(225, 188, 41, 0.8),
    Colors.green,
    Colors.blue,
    Colors.pink
  ];

  BoxLayout(this.displayBoxInfos);

  UtilBox createDisplayBox(int index, double boxWidth, double boxHeight) {
    UtilBox box;
    BoxInfo targetBoxInfo = displayBoxInfos[index];
    Color _boxColor, _textColor;
    if (targetBoxInfo.boxColor == null) {
      _boxColor = boxColorPalette[index % boxColorPalette.length];
      _textColor = Colors.white;
    } else {
      _boxColor = targetBoxInfo.boxColor;
      _textColor = targetBoxInfo.textColor;
    }
    if (targetBoxInfo.boxType == BoxType.URLBox) {
      box = URLBox(
          boxColor: _boxColor,
          textColor: _textColor,
          boxWidth: boxWidth,
          boxHeight: boxHeight,
          title: targetBoxInfo.boxTitle,
          iconData: targetBoxInfo.iconData,
          boxUrl: targetBoxInfo.boxUrl);
    } else if (targetBoxInfo.boxType == BoxType.AppBox) {
      box = URLBox(
        boxColor: _boxColor,
        textColor: _textColor,
        boxWidth: boxWidth,
        boxHeight: boxHeight,
        title: targetBoxInfo.boxTitle,
        iconData: targetBoxInfo.iconData,
        boxUrl: targetBoxInfo.boxUrl,
      );
    } else if (targetBoxInfo.boxType == BoxType.PreMadeBox) {
      // TODO: Implement Premade box

    }
    return box;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double marginSize = 10.0;
    double boxAspectRatio = 0.85;
    double padding = 10.0;
    double boxWidth = (screenWidth - (padding * 2) - marginSize) / 2;
    double boxHeight = boxWidth / boxAspectRatio;
    return displayBoxInfos.length == 0
        ? Center(child: Text('Please add a box!'))
        : GridView.count(
            padding: EdgeInsets.all(padding),
            crossAxisCount: 2,
            crossAxisSpacing: marginSize,
            mainAxisSpacing: marginSize,
            childAspectRatio: boxAspectRatio,
            children: List.generate(
              displayBoxInfos.length,
              (index) {
                return GestureDetector(
                  onTap: () {},
                  child: createDisplayBox(index, boxWidth, boxHeight),
                );
              },
            ),
          );
  }
}
