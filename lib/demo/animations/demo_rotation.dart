import 'package:flutter/material.dart';

const Duration _kDuration = Duration(milliseconds: 200);

class DemoRotation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoRotationState();
}

class _DemoRotationState extends State<DemoRotation>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _iconColorTween = ColorTween();

  AnimationController _controller;
  Animation<Color> _iconColor;
  Animation<double> _iconTurns;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kDuration, vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
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
      ..end = Colors.black;

    super.didChangeDependencies();
  }

  void _handleTap() {
      setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          // setState(() {
          //   // Rebuild without widget.children.
          // });
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Rotation'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildDemo1(context),
      ],
    );
  }

  Widget _buildDemo1(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _builderBuildChild,
      child: _buildChild(context),
    );
  }

  Widget _builderBuildChild(BuildContext context, Widget child) {
    return InkWell(
      child:
          RotationTransition(turns: _iconTurns, child: Icon(Icons.expand_more)),
      onTap: _handleTap,
    );
  }

  Widget _buildChild(BuildContext context) {
    return Text('child');
  }
}
