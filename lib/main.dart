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

class _AppPageState extends State<AppPage> {
  Widget home = HBWelcomePage();

  @override
  void initState() {
    super.initState();

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
}
