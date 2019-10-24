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
    Brightness brightness = Brightness.light;
    final bool isDark = brightness == Brightness.dark;

    ThemeData mainTheme = ThemeData(
      brightness: brightness,
      // primarySwatch: Colors.grey,
      primaryColor: Colors.blue,
      accentColor: Colors.yellow,

      // buttonColor: Colors.blue,

      // primaryColorBrightness: Brightness.dark,
      // accentColorBrightness: Brightness.dark,
      /// 删除水波纹
      splashColor: Colors.transparent,

      /// 删除点击高亮
      highlightColor: Colors.transparent,

      bottomAppBarTheme: BottomAppBarTheme(elevation: 2.0, color: Colors.grey[200]),
      tabBarTheme: TabBarTheme(
        // labelColor: Colors.grey[700],
        labelStyle: TextStyle(color: Colors.grey[700]),
        unselectedLabelStyle: TextStyle(color: Colors.grey[500]),
        unselectedLabelColor: Colors.grey[500],

      ),
    );

    return MaterialApp(
      theme: mainTheme,
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
