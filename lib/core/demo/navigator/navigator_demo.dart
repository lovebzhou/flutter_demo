import 'package:flutter/material.dart';

class NavigatorDemo extends StatelessWidget {
  static const String title = 'Navigator演示';
  @override
  Widget build(BuildContext context) {
    Widget body;

    body = ListView(
      // itemExtent: 44,
      children: <Widget>[
        RaisedButton(
          child: Text('Fade Push'),
          onPressed: () {
            _DemoRoute.fadePush(context);
          },
        ),
        RaisedButton(
          child: Text('Rotate Push'),
          onPressed: () {
            _DemoRoute.rotatePush(context);
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(NavigatorDemo.title),
      ),
      backgroundColor: Colors.grey,
      body: body,
    );
  }
}

class _DemoRoute extends StatelessWidget {
  static void rotatePush(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return _DemoRoute();
        },
        // barrierColor: Colors.black26,
        transitionsBuilder:
            (___, Animation<double> animation, ____, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: RotationTransition(
              turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  static void fadePush(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return _DemoRoute();
        },
        // barrierColor: Colors.black26,
        transitionsBuilder:
            (___, Animation<double> animation, ____, Widget child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      color: Colors.white,
      width: 200,
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('2'),
          RaisedButton(
            child: Text('close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );

    content = Center(
      child: content,
    );

    content = Container(
      child: content,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
    );

    content = GestureDetector(
      child: content,
      onTap: () {
        Navigator.of(context).pop();
      },
    );

    return content;
  }
}
