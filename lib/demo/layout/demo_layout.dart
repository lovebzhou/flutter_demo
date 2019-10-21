import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/layout/demo_align.dart';
import 'package:flutter_demo/demo/layout/demo_row.dart';
import 'package:flutter_demo/utils/navigator_util.dart';

class DemoLayout extends StatelessWidget {
  static String title = '布局演示';

  @override
  Widget build(BuildContext context) {
    Widget child = ListView(
      children: <Widget>[
        _buildItem(context, 'Row Demo', DemoRow()),
        _buildItem(context, 'Align', DemoAlign()),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLayout.title),
      ),
      body: child,
    );
  }

  Widget _buildItem(BuildContext context, String title, Widget page) {
    return ListTile(
      title: Text(title),
      onTap: () {
        NavigatorUtil.pushPage(context, page);
      },
    );
  }
}
