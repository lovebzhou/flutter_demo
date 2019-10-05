import 'package:flutter/material.dart';

class PopupMenu {
  static PopupMenu _instance;
  factory PopupMenu() {
    if (_instance == null) {
      _instance = PopupMenu._();
    }
    return _instance;
  }

  PopupMenu._();

  _PopupMenu widget;
  OverlayEntry overlayEntry;

  showMenu(
      {BuildContext context,
      List menus,
      Size size,
      EdgeInsets edge,
      void Function(Map menu) onTap}) async {
    OverlayState overlayState = Overlay.of(context);

    // 使用context时Context有可能还没有准备好
    widget = _PopupMenu(
      size: size,
      edge: edge,
      menus: menus,
      onTap: onTap,
    );
    overlayEntry = OverlayEntry(builder: (context) {
      return _background(widget);
    });
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(milliseconds: 20));
    widget.show(true);
  }

  Widget _background(Widget child) {
    return GestureDetector(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.white.withOpacity(0.0),
        child: Stack(
          children: <Widget>[
            child,
          ],
        ),
      ),
      onTap: () {
        dismiss();
      },
    );
  }

  void dismiss() {
    widget.show(false);
    overlayEntry.remove();
    _instance = null;
  }
}

// ignore: must_be_immutable
class _PopupMenu extends StatefulWidget {
  final Size size;
  final EdgeInsets edge;
  final List menus;
  final void Function(Map menu) onTap;
  final _PopupMenuState state = _PopupMenuState();

  _PopupMenu({this.size, this.edge, this.menus, this.onTap});

  void show(bool isShow) {
    state.show = isShow;
  }

  @override
  State<StatefulWidget> createState() => state;
}

class _PopupMenuState extends State<_PopupMenu> {
  bool _show = false;
  set show(bool show) {
    setState(() {
      _show = show;
    });
  }

  get show => _show;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.edge.top ?? null,
      bottom: widget.edge.bottom ?? null,
      left: widget.edge.left ?? null,
      right: widget.edge.right ?? null,
      child: Container(
        padding: EdgeInsets.only(bottom: 4, left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, -1),
                blurRadius: 6.0,
              )
            ]),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: menuWidgets(),
        ),
      ),
    );
  }

  List<Widget> menuWidgets() {
    List<Widget> widgets = [];
    for (var menu in widget.menus) {
      Widget menuWidget = GestureDetector(
        child: Container(
          color: Colors.white,
          height: 38,
          width: widget.size.width,
          alignment: Alignment.centerLeft,
          child: Text(
            menu["title"],
            style: TextStyle(
              fontSize: 14,
              color: (menu["selected"] ?? false) ? Colors.red : Colors.grey,
              fontWeight: (menu["selected"] ?? false)
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ),
        onTap: () => widget.onTap(menu),
      );
      widgets.add(menuWidget);
    }
    return widgets;
  }
}
