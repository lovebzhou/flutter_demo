import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/widgets/demo_card.dart';
import 'package:flutter_demo/demo/widgets/demo_tab.dart';
import 'package:flutter_demo/demo/widgets/demo_wrap.dart';
import 'package:flutter_demo/utils/navigator_util.dart';

class DemoWidgets extends StatelessWidget {
  static String title = '标准Widget演示';

  @override
  Widget build(BuildContext context) {
    Widget child = ListView(
      children: <Widget>[
        _buildItem(context, DemoCard.title, DemoCard()),
        _buildItem(context, DemoWrap.title, DemoWrap()),
        _buildItem(context, DemoTab.title, DemoTab()),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoWidgets.title),
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
