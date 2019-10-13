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
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Demo'),
          ),
          bottom: tabBar,
        ),
        SliverToBoxAdapter(child: 
        Container(
            height: 200,
            child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView.builder(
                itemCount: 10,
                itemBuilder: (c, i) {
                  return Text('Item $i');
                },
              ),
              ListView.builder(
                itemCount: 10,
                itemBuilder: (c, i) {
                  return Text('Item $i');
                },
              )
            ],
          ),),
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
        // controller: _scrollController,
        child: body);

    body = SafeArea(child: body);

    return Scaffold(body: body);
  }
}
