import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

import 'customscrollview_demo.dart';

class ScrollViewDemo extends StatelessWidget {
  static String title = 'ScrollView Demo';
  @override
  Widget build(BuildContext context) {
    Widget body = ListView(
      children: <Widget>[
        ListTile(
          title: Text('CustomScrollView'),
          onTap: () {
            NavigatorUtil.pushPage(context, CustomScrollViewDemo());
          },
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(title: Text(ScrollViewDemo.title),),
      body: body,
    );
  }
}
