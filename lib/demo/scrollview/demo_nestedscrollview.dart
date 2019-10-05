import 'package:flutter/material.dart';

class DemoNestedScrollView extends StatefulWidget {
  static const String title = 'NestedScrollView演示';
  _DemoNestedScrollViewState createState() => _DemoNestedScrollViewState();
}

class _DemoNestedScrollViewState extends State<DemoNestedScrollView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(DemoNestedScrollView.title),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              expandedHeight: 300.0,
              backgroundColor: Colors.blue[200],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/6.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.red[400],
                tabs: <Widget>[
                  Tab(
                    text: "Home",
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    text: "Help",
                    icon: Icon(Icons.help),
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            PageOne(),
            PageTwo(),
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.control_point),
        onPressed: () {
          _tabController.animateTo(1,
              curve: Curves.bounceInOut, duration: Duration(milliseconds: 10));
          _scrollViewController
              .jumpTo(_scrollViewController.position.maxScrollExtent);
        },
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.green : Colors.grey,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}
