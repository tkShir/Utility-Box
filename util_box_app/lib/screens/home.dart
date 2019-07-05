import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/box_create.dart';

import '../models/box_info.dart';
import '../screens/box_admin.dart';
import '../ui_elem/box_layout.dart';
import '../Util/t_c_logo_icons.dart';
import '../providers/box_info.dart';

class HomePage extends StatefulWidget {
  static const String pageRoute = '/';
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool _isEmergency = false;

  Widget buildSideDrawer(BuildContext context) {
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
              Navigator.of(context).pop();
              Navigator.pushNamed(context, BoxAdminPage.pageRoute);
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text("Emergency Mode"),
            value: _isEmergency,
            activeColor: Color(0xFFB00020),
            onChanged: (bool value) {
              setState(() {
                _isEmergency = value;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final boxData = Provider.of<BoxInfoProvider>(context);
    final List<BoxInfo> _exampleBoxInfo = boxData.boxInfos;

    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: buildSideDrawer(context),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(BoxCreatePage.pageRoute);
            },
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Taka's Utility App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: deviceHeight * 0.2,
            child: Text("Hello, This is  a Placeholder"),
          ),
          Expanded(
            child: _isEmergency
                ? Center(
                    child: Text("EMERGENCY MODE"),
                  )
                : BoxLayout(_exampleBoxInfo),
          ),
        ],
      ),
    );
  }
}
