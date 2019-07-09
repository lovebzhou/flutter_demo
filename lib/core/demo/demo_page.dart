import 'package:flutter/material.dart';
import 'animations/animation_demo.dart';

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
    Page(HBAnimationPage(), HBAnimationPage.title),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('演示'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            indent: 15.0,
          );
        },
        itemBuilder: (context, index) {
          final page = _pages[index];
          return ListTile(
            title: Text(page.title),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => page.widget));
            },
          );
        },
        itemCount: _pages.length,
      ),
    );
  }
}
