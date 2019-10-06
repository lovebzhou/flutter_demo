import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

class DemoTab extends StatefulWidget {
  static String title = 'Tab演示';
  @override
  State<StatefulWidget> createState() => _DemoTabState();
}

class _DemoTabState extends State<DemoTab> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> tabDatas = [
    {'name': 'tab1'},
    {'name': 'tab2'},
    {'name': 'tab3'},
    {'name': 'tab4'},
    {'name': 'tab5'},
    {'name': 'tab6'},
    {'name': 'tab7'},
  ];

  TabController _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabDatas.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab Demo'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> tabs = [];
    List<Widget> children = [];
    tabDatas.forEach((data) {
      Tab tab = Tab(
        child: Container(
          child: Text(data['name']),
        ),
      );
      tabs.add(tab);

      Widget child = Center(
        child: Text(data['name']),
      );
      children.add(child);
    });

    Widget tabBar = TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: tabs,
    );

    Widget tabBarView = Expanded(
      child: TabBarView(
        controller: _tabController,
        children: children,
      ),
    );

    return Column(
      children: <Widget>[
        tabBar,
        tabBarView,
        _buildFooter(context),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            child: Text('重置'),
            onPressed: () {
              Log.d('重置');
            },
          ),
          RaisedButton(
            child: Text('确定'),
            onPressed: () {
              Log.d('确定');
            },
          )
        ],
      ),
    );
  }
}
