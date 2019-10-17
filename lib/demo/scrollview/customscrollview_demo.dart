import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomScrollViewDemoState();
}

class _CustomScrollViewDemoState extends State<CustomScrollViewDemo>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
    TabBar tabBar = TabBar(
      controller: _tabController,
      tabs: <Widget>[
        Tab(
          child: Text('Tab1'),
        ),
        Tab(
          child: Text('Tab2'),
        ),
      ],
    );

    Widget body = CustomScrollView(
      semanticChildCount: 5,
      controller: _scrollController,
      physics: Platform.isIOS
          ? AlwaysScrollableScrollPhysics()
          : BouncingScrollPhysics(),
      slivers: <Widget>[
        _buildRefreshControl(context),
        SliverAppBar(
          pinned: true,
          // floating: true,
          // snap: true,
          title: Text('SliverAppBar Title'),
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Demo'),
            background: SizedBox.expand(
              child: Container(
                color: Colors.yellow,
                child: Center(
                  child: Text('backgroud'),
                ),
              ),
            ),
          ),
          bottom: tabBar,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListView.builder(
                  // controller: _scrollController,
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
                  // controller: _scrollController,
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
            ),
          ),
        ),
        SliverGrid(
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
        ),
        SliverFixedExtentList(
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
        ),
      ],
    );

    body = Scrollbar(
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
}
