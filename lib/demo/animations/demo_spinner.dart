import 'dart:math' as math;

import 'package:flutter/material.dart';

class DemoSpinner extends StatefulWidget {
  @override
  _DemoSpinnerState createState() => _DemoSpinnerState();
}

class _DemoSpinnerState extends State<DemoSpinner>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }
  ///
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///
  @override
  Widget build(BuildContext context) {
    Widget animate = AnimatedBuilder(
      animation: _controller,
      child: Container(width: 200.0, height: 200.0, color: Colors.green),
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
 
    Widget body = Center(child: animate,);

    return Scaffold(
        appBar: AppBar(
          title: Text('Transform.rotate'),
        ),
        body: body);
  }
}
