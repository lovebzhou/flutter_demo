import 'package:flutter/material.dart';

/// 发现
class HBDiscoveryPage extends StatefulWidget {
  static const String title = '发现';
  static const IconData iconData = Icons.search;

  @override
  State<StatefulWidget> createState() => _HBDiscoveryPageState();
}

class _HBDiscoveryPageState extends State<HBDiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现'),
      ),
      body: Center(
        child: Text('发现'),
      ),
    );
  }
}
