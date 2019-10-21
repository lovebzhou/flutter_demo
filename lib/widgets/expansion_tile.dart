import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 200);

/// 类似ExpansionTile
/// 
/// - 内部用Row替代了ListTile
/// - 增加了标题，图片折叠、展开时的颜色属性
/// - training不为null时，可旋转
class ZBExpansionTile extends StatefulWidget {
  const ZBExpansionTile({
    Key key,
    this.leading,
    @required this.title,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.padding,
    this.headerColor,
    this.expandedHeaderColor,
    this.iconColor,
    this.expandedIconColor,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final Widget leading;

  final Widget title;

  final ValueChanged<bool> onExpansionChanged;

  final List<Widget> children;

  final Widget trailing;

  final bool initiallyExpanded;

  final EdgeInsets padding;

  final Color headerColor;
  final Color expandedHeaderColor;

  final Color iconColor;
  final Color expandedIconColor;

  @override
  _ZBExpansionTileState createState() => _ZBExpansionTileState();
}

class _ZBExpansionTileState extends State<ZBExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<Color> _headerColor;
  Animation<Color> _iconColor;

  bool _isExpanded = false;

  Widget get leading => widget.leading;
  Widget get title => widget.title;
  Widget get trailing => widget.trailing;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildTile(context),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context) {
    List<Widget> children = [];

    IconThemeData iconThemeData;
    if (leading != null || trailing != null)
      iconThemeData = IconThemeData(color: _iconColor.value);

    if (leading != null) {
      children.add(IconTheme.merge(
        data: iconThemeData,
        child: leading,
      ));
    }

    if (title != null) {
      final TextStyle titleStyle = TextStyle(color: _headerColor.value);
      final Widget titleText = AnimatedDefaultTextStyle(
        style: titleStyle,
        duration: kThemeChangeDuration,
        child: title,
      );
      children.add(titleText);
    }

    if (trailing != null) {
      children.add(RotationTransition(
        turns: _iconTurns,
        child: IconTheme.merge(
          data: iconThemeData,
          child: trailing,
        ),
      ));
    }

    return InkWell(
      child: Container(
        child: Row(
          children: children,
        ),
        padding: widget.padding,
      ),
      onTap: _handleTap,
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);

    _headerColorTween
      ..begin = widget.headerColor ?? theme.textTheme.subhead.color
      ..end = widget.expandedHeaderColor ??  widget.headerColor ?? theme.accentColor;

    _iconColorTween
      ..begin =
          widget.iconColor ?? widget.headerColor ?? theme.unselectedWidgetColor
      ..end = widget.expandedIconColor ??
          widget.expandedHeaderColor ?? widget.headerColor ??
          theme.accentColor;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}
