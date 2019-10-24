import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/log_util.dart';
import 'package:flutter_demo/widgets/tabs.dart';
import 'home/home_page.dart';
import 'roster/roster_page.dart';
import 'package:flutter_demo/demo/demo_page.dart';
import 'discovery/discovery_page.dart';
import 'mine/mine_page.dart';

/// 主页
class HBMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HBMainPageState();
}

final GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey<ScaffoldState>();

class _HBMainPageState extends State<HBMainPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  final List tabDatas = [
    {
      'text': HBHomePage.title,
      'normal': new Icon(
        HBHomePage.iconData,
        size: 22.0,
      ),
    },
    {
      'text': HBRosterPage.title,
      'normal': new Icon(HBRosterPage.iconData, size: 22.0),
    },
    {
      'text': HBDemoPage.title,
      'normal': new Icon(HBDemoPage.iconData, size: 22.0),
    },
    {
      'text': HBDiscoveryPage.title,
      'normal': new Icon(HBDiscoveryPage.iconData, size: 22.0),
    },
    {
      'text': HBMinePage.title,
      'normal': new Icon(HBMinePage.iconData, size: 22.0),
    },
  ];

  List _tabs;

  @override
  void initState() {
    super.initState();

    _tabs = tabDatas
        .map((data) => ZBVertTab(text: data['text'], icon: data['normal']))
        .toList();

    controller =
        TabController(vsync: this, initialIndex: 0, length: tabDatas.length);

    controller.addListener(() {
      Log.d('###tab index change###');

      if (!controller.indexIsChanging && this.mounted) {
        print(tabDatas[controller.index]['text']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomBar = TabBar(
      controller: controller,
      indicatorWeight: 1,
      indicatorColor: Colors.transparent,
      tabs: _tabs,
      labelStyle: TextStyle(fontSize: 10.0),
      unselectedLabelStyle: TextStyle(fontSize: 10.0),
    );

    NotchedShape notchedShape; 
    // notchedShape = CircularNotchedRectangle();
    bottomBar = BottomAppBar(
      child: bottomBar,
      shape: notchedShape,
    );

    return new Scaffold(
      key: mainScaffoldKey,
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          HBHomePage(),
          HBRosterPage(),
          HBDemoPage(),
          HBDiscoveryPage(),
          HBMinePage(),
        ],
      ),
      bottomNavigationBar: bottomBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Log.d('floating action button');
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
