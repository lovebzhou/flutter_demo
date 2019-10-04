import 'package:dropdown/dropdown.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(HBHomePage.title),
              RaisedButton(
                child: Text("Dropdown Show"),
                onPressed: () {
                  Dropdown.show("Hello world!", Colors.green, Colors.black);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
