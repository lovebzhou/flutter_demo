import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

class DemoTab extends StatefulWidget {
  static String title = 'Tab演示';
  @override
  State<StatefulWidget> createState() => _DemoTabState();
}

class _DemoTabState extends State<DemoTab> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _tabDatas = [
    {'name': 'tab1'},
    {'name': 'tab2'},
    {'name': 'tab3'},
    {'name': 'tab4'},
    {'name': 'tab5'},
    {'name': 'tab6'},
    {'name': 'tab7'},
  ];

  List<Widget> _tabs;
  List<Widget> _tabViews;

  TabController _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabDatas.length, vsync: this);
    _tabController.animation.addListener(() {
      Log.d(
          'animation.value = ${_tabController.animation.value}, index = ${_tabController.index}, prevIndex = ${_tabController.previousIndex}');
    });

    _tabs = [];
    _tabViews = [];
    _tabDatas.forEach((data) {
      Tab tab = Tab(
        child: Container(
          child: Text(data['name']),
        ),
      );
      _tabs.add(tab);

      Widget child = Center(
        child: Text(data['name']),
      );
      _tabViews.add(child);
    });
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
    Widget body = Column(
      children: <Widget>[
        _buildTabBar(context),
        _buildTabBarView(context),
        _buildFooter(context),
      ],
    );

    body = SafeArea(child: body);

    return body;
  }

  Widget _buildTabBar(BuildContext context) {
    Widget tabBar = TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: _tabs,
    );
    return tabBar;
  }

  Widget _buildTabBarView(BuildContext context) {
    Widget tabBarView = Expanded(
      child: TabBarView(
        controller: _tabController,
        children: _tabViews,
      ),
    );
    return tabBarView;
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: Text('重置'),
              onPressed: () {
                Log.d('重置');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                ),
              ),
              child: Text('确定'),
              onPressed: () {
                Log.d('确定');
              },
            ),
          ),
        ],
      ),
    );
  }
}
