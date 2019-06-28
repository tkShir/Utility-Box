import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './home.dart';

void main() {
  //debugPaintSizeEnabled = true;
  //debugPaintBaselinesEnabled = true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(56, 172, 255, 1.0),
        accentColor: Color.fromRGBO(239, 112, 163, 1.0),
      ),
      routes: {
        '/': (BuildContext context) => Home(),
      },
    );
  }
}
