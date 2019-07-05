import 'package:flutter/material.dart';
import 'package:util_box_app/screens/box_admin.dart';

Widget buildSideDrawer(BuildContext context) {
  bool _isEmergency = false;
  return Drawer(
    child: Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('Choose'),
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Boxes'),
          onTap: () {
            Navigator.pushNamed(context, BoxAdminPage.pageRoute);
          },
        ),
        Divider(),
        SwitchListTile(
          title: Text("Emergency Mode"),
          value: _isEmergency,
          onChanged: (bool value) {
            _isEmergency = !_isEmergency;
          },
        ),
      ],
    ),
  );
}
