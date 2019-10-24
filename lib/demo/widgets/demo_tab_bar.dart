import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

class DemoTabBar extends StatefulWidget {
  static String title = 'Tab演示';
  @override
  State<StatefulWidget> createState() => _DemoTabBarState();
}

class _DemoTabBarState extends State<DemoTabBar>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _tabDatas = [
    {'name': 'tab1'},
    {'name': 'tab2'},
    {'name': 'tab3'},
    {'name': 'tab4'},
    // {'name': 'tab5'},
    // {'name': 'tab6'},
    // {'name': 'tab7'},
  ];

  List<Widget> _tabs;
  List<Widget> _tabViews;

  TabController _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabDatas.length, vsync: this);
    _tabController.animation.addListener(() {
      // Log.d('value = ${_tabController.animation.value}, index = ${_tabController.index}, prevIndex = ${_tabController.previousIndex}');
    });
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Log.d('indexIsChanging: ${_tabController.index}, ${_tabController.previousIndex}');
      }
    });

    _tabs = [];
    _tabViews = [];

    _tabDatas.forEach((data) {
      Widget tab = ZBTab(
        index: _tabs.length,
        child: Text(data['name']),
        tabController: _tabController,
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

const Duration _kDuration = Duration(milliseconds: 200);

class ZBTab extends StatefulWidget {
  final Widget child;
  final int index;
  final TabController tabController;
  final IconData iconData;

  const ZBTab({
    Key key,
    @required this.child,
    @required this.index,
    @required this.tabController,
    this.iconData,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZBTabState();
}

class _ZBTabState extends State<ZBTab> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _iconColorTween = ColorTween();

  AnimationController _controller;
  Animation<Color> _iconColor;
  Animation<double> _iconTurns;

  TabController get _tabController => widget.tabController;
  int get _index => widget.index;

  // bool _isSelected => ;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: _kDuration, vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _controller.value = (_index == _tabController.index) ? 1.0 : 0.0;

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == _index) {
          _controller.forward();
        }
        if (_tabController.previousIndex == _index) {
          _controller.reverse();
        }
      }
    });

    widget.tabController.animation.addListener(() {
      if (_tabController.indexIsChanging) return;

      double value0 = _tabController.animation.value;
      double value1 = (value0 - _index);
      double value2 = value1.abs();
      if (value2 > 1.0) return;
      if (value0.floor() == _index) {
        if (value1 > 0.0) {
          _controller.value = 1.0 - value2;
        } else if (value1 < 0.0) {
          _controller.value = value2;
        } else {
          _controller.value = 1.0;
        }
      } else {
        _controller.value = 1.0 - value2;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _iconColorTween
      ..begin = Colors.grey
      ..end = Colors.white;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _builderChild,
      child: widget.child,
    );
  }

  Widget _builderChild(BuildContext context, Widget child) {
    Widget tab = Row(
      children: <Widget>[
        child,
        RotationTransition(
          turns: _iconTurns,
          child: Icon(
            widget.iconData ?? Icons.expand_more,
            color: _iconColor.value,
          ),
        ),
      ],
    );
    tab = Tab(
      child: tab,
    );
    return tab;
  }
}
