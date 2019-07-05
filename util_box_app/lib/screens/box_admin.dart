import 'package:flutter/material.dart';

// class BoxAdminPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _BoxAdminPageState();
//   }
// }

class BoxAdminPage extends StatelessWidget {
  static const String pageRoute = 'adminBox';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing - Admin Page"),
      ),
      body: Center(
        child: Text("Test - Admin"),
      ),
    );
  }
}
