import 'package:flutter/material.dart';

/// 首页
class HBHomePage extends StatefulWidget {
  static const String title = '首页';
  static const IconData iconData = Icons.home;

  @override
  State<StatefulWidget> createState() => _HBHomePageState();
}

class _HBHomePageState extends State<HBHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HBHomePage.title),
      ),
      body: Center(
        child: Text(HBHomePage.title),
      ),
    );
  }
}
