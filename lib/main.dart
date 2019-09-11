import 'package:flutter/material.dart';

import 'global.dart';
import 'core/welcome_page.dart';
import 'core/user/login_page.dart';
import 'core/main_page.dart';

void main() => runApp(AppPage());

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with WidgetsBindingObserver {
  Widget home = HBWelcomePage();

  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(this);
    
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addObserver(this);

    eventBus.on<UserAuthEvent>().listen((e) {
      setState(() {
        home = e.isLogined ? HBMainPage() : HBLoginPage();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: HBTheme.mainThemeData,
      home: home,
    );
  }

  /// 系统窗口相关改变回调，例如旋转
  void didChangeMetrics() {
    print('didChangeMetrics');
  }

  /// 文字系数变化
  void didChangeTextScaleFactor() {
    print('didChangeTextScaleFactor');
  }

  //本地化语言变化
  void didChangeLocales(List<Locale> locale) {
    print('didChangeLocales');
  }

  //生命周期变化
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('didChangeAppLifecycleState');
  }

  //低内存回调
  void didHaveMemoryPressure() {
    print('didHaveMemoryPressure');
    PaintingBinding.instance.imageCache.clear();
  }
}
