import 'package:flutter/material.dart';

class HBAnimationPage extends StatefulWidget {
  static const String title = '动画';

  @override
  State<StatefulWidget> createState() => _HBAnimationPageState();
}

class _HBAnimationPageState extends State<HBAnimationPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    animation = new Tween(begin: 100.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      // if (status == AnimationStatus.completed) {
      //   controller.reverse();
      // } else if (status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final animationImage = AnimatedBuilder(
      animation: animation,
      child: Image.asset(
        "assets/image/4.jpg",
        fit: BoxFit.cover,
      ),
      builder: (BuildContext ctx, Widget child) {
        return Container(
          color: Colors.blue.shade100,
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
    );

    Widget actionButtons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          textColor: Colors.white,
          child: Text("forward"),
          onPressed: () {
            controller.forward();
          },
        ),
        RaisedButton(
          child: Text('reverse'),
          onPressed: () {
            controller.reverse();
          },
        ),
      ],
    );

    actionButtons = Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: actionButtons,
    );

    final children = [
      animationImage,
      actionButtons,
      Container(
        height: 100.0,
        color: Colors.blue.shade100,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: ListView(padding: EdgeInsets.zero, children: children),
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}
