import 'package:flutter/material.dart';

class DemoMyGrid extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _DemoMyGrid();
}

class _DemoMyGrid extends State<DemoMyGrid> {
  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: Text('Demo My Grid'),);

    return Scaffold(appBar: AppBar(title: Text('Demo My Grid'),), body: body,);
  }
}

