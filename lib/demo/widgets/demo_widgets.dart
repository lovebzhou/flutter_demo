import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/widgets/demo_card.dart';
import 'package:flutter_demo/demo/widgets/demo_grid.dart';
import 'package:flutter_demo/demo/widgets/demo_list_view_expansion.dart';
import 'package:flutter_demo/demo/widgets/demo_tab.dart';
import 'package:flutter_demo/demo/widgets/demo_wrap.dart';
import 'package:flutter_demo/demo/widgets/scrollview/scrollview_demo.dart';
import 'package:flutter_demo/utils/navigator_util.dart';

import 'demo_bottom_navigation_bar.dart';
import 'demo_list_view.dart';

class DemoWidgets extends StatelessWidget {
  static String title = '标准Widget演示';

  @override
  Widget build(BuildContext context) {
    Widget child = ListView(
      children: <Widget>[
        _buildItem(context, DemoCard.title, DemoCard()),
        _buildItem(context, DemoWrap.title, DemoWrap()),
        _buildItem(context, DemoTab.title, DemoTab()),
        _buildItem(context, 'Demo ListView', DemoListView()),
        _buildItem(context, 'Demo ListView Expansion', DemoListViewExpansion()),
        _buildItem(context, 'Demo ScrollView', DemoScrollView()),
        _buildItem(context, 'Demo Grid', DemoGridPage()),
        _buildItem(context, 'Bottom Navigation Bar', DemoBottomNavigationBar())
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
