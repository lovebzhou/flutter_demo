import 'package:flutter/material.dart';

import 'package:flutter_demo/global.dart';

class DemoGridPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoGridPageState();
}

class _DemoGridPageState extends State<DemoGridPage> {
  @override
  Widget build(BuildContext context) {
    Widget body = GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 3.0,
      ),
      itemBuilder: (c, i) {
        if (i < 20) {
          return RaisedButton(
            child: Text('button $i'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
            onPressed: () {
              Log.d('button $i onclick');
            },
          );
        } else {
          return Card(
            child: Center(
              child: Text('Card $i'),
            ),
          );
        }
      },
      itemCount: 60,
    );

    body = Container(
      child: body,
      padding: EdgeInsets.all(12.0),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Demo'),
      ),
      body: body,
    );
  }
}
