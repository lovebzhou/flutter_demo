import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/widgets/demo_nestedscrollview.dart';
import 'package:flutter_demo/demo/widgets/scrollview/demo_customscrollview.dart';
import 'package:flutter_demo/global.dart';


class DemoScrollView extends StatelessWidget {
  static String title = 'ScrollView Demo';
  @override
  Widget build(BuildContext context) {
    Widget body = ListView(
      children: <Widget>[
        ListTile(
          title: Text('Demo CustomScrollView'),
          onTap: () {
            NavigatorUtil.pushPage(context, DemoCustomScrollView());
          },
        ),
        ListTile(
          title: Text('Demo NestedScrollView'),
          onTap: () {
            NavigatorUtil.pushPage(context, DemoNestedScrollView());
          },
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(title: Text(DemoScrollView.title),),
      body: body,
    );
  }
}
