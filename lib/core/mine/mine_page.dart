import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';
import 'package:share/share.dart';

/// 我的
class HBMinePage extends StatefulWidget {
  static const String title = '我的';
  static const IconData iconData = Icons.person;
  @override
  State<StatefulWidget> createState() => _HBMinePageState();
}

class _HBMinePageState extends State<HBMinePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      FlatButton(
        child: Text(
          '退出',
        ),
        onPressed: () {
          eventBus.fire(UserAuthEvent(isLogined: false));
        },
      ),
      RaisedButton(
        child: Text('分享'),
        onPressed: () {
          Share.share('This is a demo share text');
        },
      ),
    ];

    Widget body = ListView(
      children: children,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(HBMinePage.title),
      ),
      body: body,
    );
  }
}
