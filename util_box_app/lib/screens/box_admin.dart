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

class BoxAdminPage extends StatelessWidget {
  static const String pageRoute = 'adminBox';

  @override
  Widget build(BuildContext context) {
    final BoxInfoProvider boxData = Provider.of<BoxInfoProvider>(context);
    List<BoxInfo> boxInfos = boxData.boxInfos;

    return Scaffold(
      appBar: AppBar(
        title: Text("Testing - Admin Page"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: boxInfos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(boxInfos[index].boxTitle),
            leading: Icon(boxInfos[index].iconData),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pushNamed(BoxCreatePage.pageRoute, arguments: boxInfos[index]);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
