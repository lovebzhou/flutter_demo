import 'package:flutter/material.dart';

/// Row布局演示
class DemoRow extends StatefulWidget {
  static const String title = '布局演示';
  static const IconData iconData = Icons.cake;
  @override
  State<StatefulWidget> createState() => _DemoRowState();
}

class _DemoRowState extends State<DemoRow> {
  @override
  Widget build(BuildContext context) {
    final row1 = Row(
      children: <Widget>[
        Expanded(
          child: Text('Deliver features faster', textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain, //otherwise the logo will be tiny
            child: const FlutterLogo(),
          ),
        ),
      ],
    );

    final row2 = Row(
      children: <Widget>[
        Expanded(
          child: Text('Deliver features faster', textAlign: TextAlign.center),
        ),
        Expanded(
          child: const Text('Craft beautiful UIs', textAlign: TextAlign.center),
        ),
        Expanded(
          child: FlutterLogo(),
        ),
      ],
    );

    Widget row3 = Row(
      children: <Widget>[
        const FlutterLogo(),
        const Text(
            'Flutter\'s hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android.'),
        const Icon(Icons.sentiment_very_satisfied),
      ],
    );

    Widget row4 = Row(
      children: <Widget>[
        const FlutterLogo(),
        Expanded(
          child: Text(
              'Flutter\'s hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android.'),
        ),
        const Icon(Icons.sentiment_very_satisfied),
      ],
    );

    Widget row5 =  Row(
         children: <Widget>[
           Expanded(
             flex: 2,
             child: Container(
               color: Colors.red,
               height: 100,
             ),
           ),
           Container(
             color: Colors.blue,
             height: 100,
             width: 50,
           ),
           Expanded(
             flex: 1,
             child: Container(
               color: Colors.red,
               height: 100,
             ),
           ),
         ],
       );
    final lineSpace = Divider(height: 20.0,);
    return Scaffold(
      appBar: AppBar(
        title: Text('演示'),
      ),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          row1,
          lineSpace,
          row2,
          lineSpace,
          row3,
          lineSpace,
          row4,
          lineSpace,
          row5,
        ],
      ),
    );
  }
}
