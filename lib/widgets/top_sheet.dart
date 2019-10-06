import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Duration _topSheetDuration = Duration(milliseconds: 200);
const double _minFlingVelocity = 700.0;
const double _closeProgressThreshold = 0.5;

class TopSheet extends StatefulWidget {
  /// Creates a bottom sheet.
  ///
  /// Typically, bottom sheets are created implicitly by
  /// [ScaffoldState.showTopSheet], for persistent bottom sheets, or by
  /// [showModalTopSheet], for modal bottom sheets.
  const TopSheet({
    Key key,
    this.animationController,
    this.enableDrag = true,
    this.backgroundColor,
    this.elevation,
    this.shape,
    @required this.onClosing,
    @required this.builder,
  }) : assert(enableDrag != null),
       assert(onClosing != null),
       assert(builder != null),
       assert(elevation == null || elevation >= 0.0),
       super(key: key);

  /// The animation controller that controls the bottom sheet's entrance and
  /// exit animations.
  ///
  /// The TopSheet widget will manipulate the position of this animation, it
  /// is not just a passive observer.
  final AnimationController animationController;

  /// Called when the bottom sheet begins to close.
  ///
  /// A bottom sheet might be prevented from closing (e.g., by user
  /// interaction) even after this callback is called. For this reason, this
  /// callback might be call multiple times for a given bottom sheet.
  final VoidCallback onClosing;

  /// A builder for the contents of the sheet.
  ///
  /// The bottom sheet will wrap the widget produced by this builder in a
  /// [Material] widget.
  final WidgetBuilder builder;

  /// If true, the bottom sheet can be dragged up and down and dismissed by
  /// swiping downards.
  ///
  /// Default is true.
  final bool enableDrag;

  /// The bottom sheet's background color.
  ///
  /// Defines the bottom sheet's [Material.color].
  ///
  /// Defaults to null and falls back to [Material]'s default.
  final Color backgroundColor;

  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material.
  ///
  /// Defaults to 0. The value is non-negative.
  final double elevation;

  /// The shape of the bottom sheet.
  ///
  /// Defines the bottom sheet's [Material.shape].
  ///
  /// Defaults to null and falls back to [Material]'s default.
  final ShapeBorder shape;

  @override
  _TopSheetState createState() => _TopSheetState();

  /// Creates an [AnimationController] suitable for a
  /// [TopSheet.animationController].
  ///
  /// This API available as a convenience for a Material compliant bottom sheet
  /// animation. If alternative animation durations are required, a different
  /// animation controller could be provided.
  static AnimationController createAnimationController(TickerProvider vsync) {
    return AnimationController(
      duration: _topSheetDuration,
      debugLabel: 'TopSheet',
      vsync: vsync,
    );
  }
}

class _TopSheetState extends State<TopSheet> {

  final GlobalKey _childKey = GlobalKey(debugLabel: 'TopSheet child');

  double get _childHeight {
    final RenderBox renderBox = _childKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  bool get _dismissUnderway => widget.animationController.status == AnimationStatus.reverse;

  void _handleDragUpdate(DragUpdateDetails details) {
    assert(widget.enableDrag);
    if (_dismissUnderway)
      return;
    widget.animationController.value += details.primaryDelta / (_childHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    assert(widget.enableDrag);
    if (_dismissUnderway)
      return;
    if (details.velocity.pixelsPerSecond.dy > _minFlingVelocity) {
      final double flingVelocity = -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (widget.animationController.value > 0.0) {
        widget.animationController.fling(velocity: flingVelocity);
      }
      if (flingVelocity < 0.0) {
        widget.onClosing();
      }
    } else if (widget.animationController.value < _closeProgressThreshold) {
      if (widget.animationController.value > 0.0)
        widget.animationController.fling(velocity: -1.0);
      widget.onClosing();
    } else {
      widget.animationController.forward();
   }
  }

  bool extentChanged(DraggableScrollableNotification notification) {
    if (notification.extent == notification.minExtent) {
      widget.onClosing();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final BottomSheetThemeData topSheetTheme = Theme.of(context).bottomSheetTheme;
    final Color color = widget.backgroundColor ?? topSheetTheme.backgroundColor;
    final double elevation = widget.elevation ?? topSheetTheme.elevation ?? 0;
    final ShapeBorder shape = widget.shape ?? topSheetTheme.shape;

    final Widget topSheet = Material(
      key: _childKey,
      color: color,
      elevation: elevation,
      shape: shape,
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: extentChanged,
        child: widget.builder(context),
      ),
    );
    return !widget.enableDrag ? topSheet : GestureDetector(
      onVerticalDragUpdate: _handleDragUpdate,
      onVerticalDragEnd: _handleDragEnd,
      child: topSheet,
      excludeFromSemantics: true,
    );
  }
}

class _ModalTopSheetLayout extends SingleChildLayoutDelegate {
  _ModalTopSheetLayout(this.progress, this.isScrollControlled);

  final double progress;
  final bool isScrollControlled;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: isScrollControlled
        ? constraints.maxHeight
        : constraints.maxHeight * 9.0 / 16.0,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, childSize.height * (progress - 1.0));
  }

  @override
  bool shouldRelayout(_ModalTopSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _ModalTopSheet<T> extends StatefulWidget {
  const _ModalTopSheet({
    Key key,
    this.route,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.isScrollControlled = false,
  }) : assert(isScrollControlled != null),
       super(key: key);

  final _ModalTopSheetRoute<T> route;
  final bool isScrollControlled;
  final Color backgroundColor;
  final double elevation;
  final ShapeBorder shape;

  @override
  _ModalTopSheetState<T> createState() => _ModalTopSheetState<T>();
}

class _ModalTopSheetState<T> extends State<_ModalTopSheet<T>> {
  String _getRouteLabel(MaterialLocalizations localizations) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return '';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return localizations.dialogLabel;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final String routeLabel = _getRouteLabel(localizations);

    return AnimatedBuilder(
      animation: widget.route.animation,
      builder: (BuildContext context, Widget child) {
        // Disable the initial animation when accessible navigation is on so
        // that the semantics are added to the tree at the correct time.
        final double animationValue = mediaQuery.accessibleNavigation ? 1.0 : widget.route.animation.value;
        return Semantics(
          scopesRoute: true,
          namesRoute: true,
          label: routeLabel,
          explicitChildNodes: true,
          child: ClipRect(
            child: CustomSingleChildLayout(
              delegate: _ModalTopSheetLayout(animationValue, widget.isScrollControlled),
              child: TopSheet(
                animationController: widget.route._animationController,
                onClosing: () {
                  if (widget.route.isCurrent) {
                    Navigator.pop(context);
                  }
                },
                builder: widget.route.builder,
                backgroundColor: widget.backgroundColor,
                elevation: widget.elevation,
                shape: widget.shape,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ModalTopSheetRoute<T> extends PopupRoute<T> {
  _ModalTopSheetRoute({
    this.builder,
    this.theme,
    this.barrierLabel,
    this.backgroundColor,
    this.elevation,
    this.shape,
    @required this.isScrollControlled,
    RouteSettings settings,
  }) : assert(isScrollControlled != null),
       super(settings: settings);

  final WidgetBuilder builder;
  final ThemeData theme;
  final bool isScrollControlled;
  final Color backgroundColor;
  final double elevation;
  final ShapeBorder shape;

  @override
  Duration get transitionDuration => _topSheetDuration;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController _animationController;


  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = TopSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // By definition, the bottom sheet is aligned to the bottom of the page
    // and isn't exposed to the top padding of the MediaQuery.
    Widget topSheet = MediaQuery.removePadding(
      context: context,
      // removeTop: true,
      removeBottom: true,
      child: _ModalTopSheet<T>(
        route: this,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        isScrollControlled: isScrollControlled
      ),
    );
    if (theme != null)
      topSheet = Theme(data: theme, child: topSheet);
    return topSheet;
  }
}

Future<T> showModalTopSheet<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  Color backgroundColor,
  double elevation,
  ShapeBorder shape,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
}) {
  assert(context != null);
  assert(builder != null);
  assert(isScrollControlled != null);
  assert(useRootNavigator != null);
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  return Navigator.of(context, rootNavigator: useRootNavigator).push(_ModalTopSheetRoute<T>(
    builder: builder,
    theme: Theme.of(context, shadowThemeOnly: true),
    isScrollControlled: isScrollControlled,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    backgroundColor: backgroundColor,
    elevation: elevation,
    shape: shape,
  ));
}