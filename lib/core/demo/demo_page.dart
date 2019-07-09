import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

/// 我的
class HBDemoPage extends StatefulWidget {
  static const String title = '演示';
  static const IconData iconData = Icons.cake;
  @override
  State<StatefulWidget> createState() => _HBDemoPageState();
}

class _HBDemoPageState extends State<HBDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HBDemoPage.title),
      ),
      body: Center(
        child: Text(HBDemoPage.title),
      ),
    );
  }
}
