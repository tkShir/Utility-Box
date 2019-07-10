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

  Widget buildSideDrawer(BuildContext context, BoxInfoProvider boxData) {
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
          // SwitchListTile(
          //   title: Text("Emergency Mode"),
          //   value: _isEmergency,
          //   activeColor: Color(0xFFB00020),
          //   onChanged: (bool value) {
          //     setState(() {
          //       boxData.toggleDisplayDefaultBox();
          //       //_isEmergency = value;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BoxInfoProvider boxData = Provider.of<BoxInfoProvider>(context);
    List<BoxInfo> _boxInfo = boxData.boxInfos;

    if (!boxData.loadedBoxes) {
      boxData.toggleLoadedBox();
      boxData.loadAllBoxes().then((bool value) {
        setState(() {
          _boxInfo = boxData.boxInfos;
        });
      });
    }

    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: buildSideDrawer(context, boxData),
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
          "Utility Box App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: deviceHeight * 0.1,
            child: Center(
              child: Text(
                "Welcome to the box App\nAdd your own Box\nEdit your own box\nEnjoy!",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: _isEmergency
                ? Center(
                    child: Text("EMERGENCY MODE"),
                  )
                : BoxLayout(_boxInfo),
          ),
        ],
      ),
    );
  }
}
