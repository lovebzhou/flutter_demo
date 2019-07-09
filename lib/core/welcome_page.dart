import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

/// 欢迎页
class HBWelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HBWelcomePageState();
}

class _HBWelcomePageState extends State<HBWelcomePage> {
  @override
  void initState() {
    super.initState();

    /// 演示授权状态初始化逻辑
    Future.delayed(Duration(seconds: 3), () {
      eventBus.fire(UserAuthEvent(isLogined: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}
