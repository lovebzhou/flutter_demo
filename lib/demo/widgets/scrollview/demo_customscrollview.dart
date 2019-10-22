import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoCustomScrollView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoCustomScrollViewState();
}

class _DemoCustomScrollViewState extends State<DemoCustomScrollView>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  ScrollController _scrollController2;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController2 = ScrollController();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController2.dispose();

    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('AppBar Title'),
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget body = CustomScrollView(
      semanticChildCount: 5,
      controller: _scrollController,
      physics: Platform.isIOS
          ? AlwaysScrollableScrollPhysics()
          : BouncingScrollPhysics(),
      slivers: <Widget>[
        _buildRefreshControl(context),
        _buildSliverAppBar(context),
        _buildSliverTabBarView(context),
        _buildSliverGrid(context),
        _buildSliverList(context),
      ],
    );

    // TODO: remove horizontal indicator
    body = CupertinoScrollbar(
      controller: _scrollController,
      child: body,
    );

    body = SafeArea(child: body);

    return body;
  }

  Widget _buildRefreshControl(BuildContext context) {
    return CupertinoSliverRefreshControl(
      builder: (
        BuildContext context,
        RefreshIndicatorMode refreshState,
        double pulledExtent,
        double refreshTriggerPullDistance,
        double refreshIndicatorExtent,
      ) {
        return Center(
          child: Text('下拉刷新'),
        );
      },
      onRefresh: () async {},
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      // floating: true, // APPBar是否跟随下拉立即显示
      // snap: true,
      title: Text('SliverAppBar Title'),
      // centerTitle: true,
      automaticallyImplyLeading: false,
      titleSpacing: 16.0,
      backgroundColor: Colors.orange,
      expandedHeight: 250.0,
      flexibleSpace: _buildFlexibleBar(context),
      bottom: _buildBottomBar(context),
    );
  }

  Widget _buildFlexibleBar(BuildContext context) {
    Widget background = Image.asset(
      'assets/images/7.jpg',
      fit: BoxFit.cover,
    );
    return FlexibleSpaceBar(
      // title: Text('Demo'),
      background: background,
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    Widget bottomBar = TabBar(
      indicatorColor: Colors.red,
      indicatorSize: TabBarIndicatorSize.label,
      controller: _tabController,
      tabs: <Widget>[
        Tab(
          child: Text('Tab1'),
        ),
        Tab(
          child: Row(children:[Text('Tab2'), Icon(Icons.expand_more)]),
        ),
      ],
    );

    /// 设置bottomBar高度
    bottomBar = Container(
      height: 56.0, // NavigationBar Height 56.0
      width: 200.0,
      child: bottomBar,
      // color: Colors.black12,
    );
    bottomBar = Align(
      alignment: Alignment.centerLeft,
      child: bottomBar,
    );
    bottomBar = Container(
      child: bottomBar,
      color: Colors.black12,
    );

    /// AppBar高度不计算bottomBar高度
    bottomBar = PreferredSize(
      child: bottomBar,
      preferredSize: Size(160, 0),
    );

    return bottomBar;
  }

  Widget _buildSliverTabBarView(BuildContext context) {
    Widget tabBarView = TabBarView(
      controller: _tabController,
      children: <Widget>[
        ListView.builder(
          controller: _scrollController2,
          itemExtent: 50.0,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.red[100 * (index % 9 + 1)],
              child: Text('List Item $index'),
            );
          },
          itemCount: 60,
        ),
        GridView.builder(
          controller: _scrollController2,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 100,
              alignment: Alignment.center,
              color: Colors.brown[100 * (index % 9 + 1)],
              child: Text('Grid Item $index'),
            );
          },
          itemCount: 20,
        ),
      ],
    );

    // tabBarView = CupertinoScrollbar(
    //   child: tabBarView,
    // );

    tabBarView = SliverToBoxAdapter(
      child: Container(
        height: 200,
        child: tabBarView,
      ),
    );

    return tabBarView;
  }

  Widget _buildSliverGrid(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            height: 100,
            alignment: Alignment.center,
            color: Colors.teal[100 * (index % 9 + 1)],
            child: Text('Grid Item $index'),
          );
        },
        childCount: 20,
      ),
    );
  }

  Widget _buildSliverList(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9 + 1)],
            child: Text('List Item $index'),
          );
        },
        childCount: 60,
      ),
    );
  }
}
