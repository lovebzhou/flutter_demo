import 'package:flutter/material.dart';

class Page {
  final Widget widget;
  final String title;

  Page(this.widget, this.title);
}

/// 布局演示
class HBLayoutPage extends StatefulWidget {
  static const String title = '布局演示';
  static const IconData iconData = Icons.cake;
  @override
  State<StatefulWidget> createState() => _HBLayoutPageState();
}

class _HBLayoutPageState extends State<HBLayoutPage> {
  @override
  Widget build(BuildContext context) {
    final row1 = Row(
      children: <Widget>[
        Expanded(
          child: Text('Deliver features faster', textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain, //otherwise the logo will be tiny
            child: const FlutterLogo(),
          ),
        ),
      ],
    );

    final row2 = Row(
      children: <Widget>[
        Expanded(
          child: Text('Deliver features faster', textAlign: TextAlign.center),
        ),
        Expanded(
          child: const Text('Craft beautiful UIs', textAlign: TextAlign.center),
        ),
        Expanded(
          child: FlutterLogo(),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('演示'),
      ),
      body: ListView(
        children: <Widget>[
          row1,
          row2,
        ],
      ),
    );
  }
}
