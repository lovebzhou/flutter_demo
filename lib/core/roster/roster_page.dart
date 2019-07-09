import 'package:flutter/material.dart';

/// 通讯录
class HBRosterPage extends StatefulWidget {
  static const String title = '通讯录';
  static const IconData iconData = Icons.phone;

  @override
  State<StatefulWidget> createState() => _HBRosterPageState();
}

class _HBRosterPageState extends State<HBRosterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HBRosterPage.title),
      ),
      body: Center(
        child: Text(HBRosterPage.title),
      ),
    );
  }
}
