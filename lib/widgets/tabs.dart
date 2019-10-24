import 'package:flutter/material.dart';

const Duration _kDuration = Duration(milliseconds: 200);

class ZBVertTab extends StatelessWidget {
  final String text;
  final Widget child;
  final Widget icon;

  const ZBVertTab({Key key, this.text, this.icon, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget label;
    if (icon == null) {
      label = _buildLabelText();
    } else if (text == null && child == null) {
      label = icon;
    } else {
      label = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: icon,
            margin: const EdgeInsets.only(bottom: 6.0),
          ),
          _buildLabelText(),
        ],
      );
    }
    label = SizedBox(child: label, height: 56,);
    return label;
  }

  Widget _buildLabelText() {
    return child ?? Text(text, softWrap: false, overflow: TextOverflow.fade);
  }
}

///
class ZBHorzTab extends StatefulWidget {
  final Widget child;
  final int index;
  final TabController tabController;
  final IconData iconData;

  const ZBHorzTab({
    Key key,
    @required this.child,
    @required this.index,
    @required this.tabController,
    this.iconData,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZBHorzTabState();
}

class _ZBHorzTabState extends State<ZBHorzTab>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _iconColorTween = ColorTween();

  AnimationController _controller;
  Animation<Color> _iconColor;
  Animation<double> _iconTurns;

  TabController get _tabController => widget.tabController;
  int get _index => widget.index;

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
    Color endColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    _iconColorTween
      ..begin = Colors.grey
      ..end = endColor;

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
    // tab = Container(
    //   height: 40.0,
    //   child: Center(child: tab),
    // );
    tab = Container(
      child: tab,
      padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
    );
    return tab;
  }
}
