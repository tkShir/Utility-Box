import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilBox extends StatelessWidget {
  final Color boxColor;
  final Color textColor;
  final double sampleBoxHeight = 231.42;
  final double boxWidth;
  final double boxHeight;
  final String title;
  final IconData iconData;
  final IconData _defaultIcon = Icons.laptop_windows;
  UtilBox({
    @required this.boxWidth,
    @required this.boxHeight,
    @required this.title,
    this.iconData,
    @required this.boxColor,
    @required this.textColor,
  });

  // double boxWidth = (availWidth * 0.95) / 2;
  // double boxHeight = (availHeight * 0.95) / 2;

  @override
  Widget build(BuildContext context) {
    IconData iconDataBuild = iconData;

    if (iconDataBuild == null) {
      iconDataBuild = _defaultIcon;
    }
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: boxHeight * 0.25, bottom: boxHeight * 0.15),
            child: Icon(
              iconDataBuild,
              size: boxHeight * 0.3,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 22 * boxHeight / sampleBoxHeight,
            ),
          ),
        ],
      ),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: boxColor,
      ),
    );
  }
}

class URLBox extends UtilBox {
  final String boxUrl;

  URLBox(
      {double boxHeight,
      double boxWidth,
      Color boxColor,
      Color textColor,
      @required String title,
      IconData iconData,
      @required this.boxUrl})
      : super(
          boxColor: boxColor,
          boxWidth: boxWidth,
          boxHeight: boxHeight,
          title: title,
          iconData: iconData,
          textColor: textColor,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: super.build(context),
    );
  }

  _launchURL() async {
    if (await canLaunch(boxUrl)) {
      await launch(boxUrl);
    } else {
      throw 'Could not launch $boxUrl';
    }
  }
}



