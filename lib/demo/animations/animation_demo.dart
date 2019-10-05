import 'dart:math' as math;
import 'package:flutter/material.dart';

class HBAnimationPage extends StatelessWidget {
  static const String title = '动画';
  @override
  Widget build(BuildContext context) {
    Widget body = ListView(
      children: <Widget>[
        ListTile(
          title: Text('Transform'),
          onTap: () {
            _push(context, (context) => _SizeAnimationDemo());
          },
        ),
         ListTile(
          title: Text('Spin'),
          onTap: () {
            _push(context, (context) => _Spinner());
          },
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(HBAnimationPage.title),
      ),
      body: body,
    );
  }

  void _push(BuildContext context, WidgetBuilder builder) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return builder(context);
        },
        // barrierColor: Colors.black26,
        transitionsBuilder:
            (___, Animation<double> animation, ____, Widget child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}

class _SizeAnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SizeAnimationDemoState();
}

class _SizeAnimationDemoState extends State<_SizeAnimationDemo>
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
        "assets/images/4.jpg",
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

class _Spinner extends StatefulWidget {
  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<_Spinner> with SingleTickerProviderStateMixin {
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
    return AnimatedBuilder(
      animation: _controller,
      child: Container(width: 200.0, height: 200.0, color: Colors.green),
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }
}
