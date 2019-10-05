import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    controller = new TabController(
        vsync: this, initialIndex: 0, length: tabDatas.length);
    controller.addListener(() {
      if (controller.indexIsChanging && this.mounted) {
        print(tabDatas[controller.index]['text']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

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
      bottomNavigationBar: Material(
        color: const Color(0xFFF0EEEF),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEEF),
              border: Border(
                top: BorderSide(
                    color: Theme.of(context).dividerColor, width: 1.0 / mq.devicePixelRatio),
              ),
            ),
            child: TabBar(
              controller: controller,
              indicatorWeight: 1,
              tabs: tabDatas
                  .map((data) =>
                      new Tab(text: data['text'], icon: data['normal']))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
