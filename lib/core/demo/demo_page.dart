import 'package:flutter/material.dart';
import 'animations/animation_demo.dart';
import 'layout/layout_demo.dart';

class Page {
  final Widget widget;
  final String title;

  Page(this.widget, this.title);
}

/// 演示
class HBDemoPage extends StatefulWidget {
  static const String title = '演示';
  static const IconData iconData = Icons.cake;
  @override
  State<StatefulWidget> createState() => _HBDemoPageState();
}

class _HBDemoPageState extends State<HBDemoPage> {
  final _pages = [
    Page(HBAnimationPage(), HBAnimationPage.title),
    Page(HBLayoutPage(), HBLayoutPage.title),
    Page(HBAnimationPage(), HBAnimationPage.title),
    Page(HBLayoutPage(), HBLayoutPage.title),
  ];

  @override
  Widget build(BuildContext context) {
    final dividerHeight = 1.0 / MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
        title: Text('演示'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          return Divider(
            indent: 15.0,
            height: dividerHeight,
          );
        },
        itemBuilder: (context, index) {
          final page = _pages[index];
          Widget item = ListTile(
            title: Text(page.title),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => page.widget));
            },
          );
          // item = SizedBox(height: 44.0, child: item,);
          return item;
        },
        itemCount: _pages.length,
      ),
    );
  }
}
