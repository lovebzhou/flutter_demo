import 'package:flutter/material.dart';

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
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (c, i) {
        return Card(
          child: Center(
            child: Text('Grid Item $i'),
          ),
        );
      },
      itemCount: 100,
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
