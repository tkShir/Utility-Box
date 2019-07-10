import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/box_info.dart';
import '../models/box_info.dart';
import '../screens/box_create.dart';

// class BoxAdminPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _BoxAdminPageState();
//   }
// }

class BoxAdminPage extends StatefulWidget {
  static const String pageRoute = 'adminBox';
  @override
  State<StatefulWidget> createState() {
    return _BoxAdminPageState();
  }
}

class _BoxAdminPageState extends State<BoxAdminPage> {
  @override
  Widget build(BuildContext context) {
    final BoxInfoProvider boxData = Provider.of<BoxInfoProvider>(context);
    List<BoxInfo> boxInfos = boxData.boxInfos;

    return Scaffold(
        appBar: AppBar(
          title: Text("Testing - Admin Page"),
        ),
        body: boxInfos.length == 0
            ? Center(child: Text("Please add a box first"))
            : ReorderableListView(
                children: _buildList(context, boxData, boxInfos),
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    boxData.switchOrder(oldIndex, newIndex);
                  });
                },
              ));
  }
}

List<Widget> _buildList(
    BuildContext context, BoxInfoProvider boxData, List<BoxInfo> boxInfos) {
  List<Widget> listTiles = [];
  for (int i = 0; i < boxInfos.length; i++) {
    listTiles.add(Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(boxInfos[i].boxTitle),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          boxData.deleteBox(i);
        }
      },
      background: Container(color: Colors.red),
      child: ListTile(
        title: Text(boxInfos[i].boxTitle),
        leading: Icon(boxInfos[i].iconData),
        trailing: Icon(Icons.edit),
        onTap: () {
          Navigator.of(context).pushNamed(BoxCreatePage.pageRoute,
              arguments: {'boxInfo': boxInfos[i], 'index': i});
        },
      ),
    ));
  }
  return listTiles;
}
