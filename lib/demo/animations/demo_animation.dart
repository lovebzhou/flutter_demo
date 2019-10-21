import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/navigator_util.dart';
import 'demo_fancy_bar.dart';
import 'demo_size.dart';
import 'demo_spinner.dart';

class DemoAnimation extends StatelessWidget {
  static String title = '动画演示';

  @override
  Widget build(BuildContext context) {
    Widget child = ListView(
      children: <Widget>[
        _buildItem(context, 'Size', DemoSize()),
        _buildItem(context, 'Spinner', DemoSpinner()),
        _buildItem(context, 'FancyTabBar演示', DemoFancyBar()),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoAnimation.title),
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
