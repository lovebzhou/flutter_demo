import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/fancy_tab_bar.dart';

class DemoFancyBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget child = ListView(
      children: <Widget>[],
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('FancyTabBar演示'),
          bottom: PreferredSize(
            child: FancyTabBar(),
            preferredSize: Size(double.infinity, 80.0),
          ),
        ),
        body: child,
        bottomNavigationBar: FancyTabBar(),
      ),
    );
  }
}
