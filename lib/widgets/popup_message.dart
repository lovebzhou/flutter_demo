import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

/// Popup弹层
/// JPPopup.showMessage(context: context, message: "Test Message.");
class PopupMessage {
  static showMessage({BuildContext context, String message}) async {
    if (message == null) {
      Log.w('JPPopup.showMessage:message == null');
      return;
    }

    OverlayState overlayState = Overlay.of(context);
    if (overlayState == null) {
      Log.w("JPPopup overlayState should not be null");
      return;
    }

    // 使用context时Context有可能还没有准备好
    _PopupWidget widget = _PopupWidget(_createPopupChild(message: message));
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return widget;
    });
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(milliseconds: 20));
    widget.show(true);

    /// dismiss
    await Future.delayed(Duration(seconds: 3), () async {
      widget.show(false);
      await Future.delayed(Duration(milliseconds: 350));
      overlayEntry?.remove();
    });
  }


  static Widget _createPopupChild({String message}) {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.black.withOpacity(0),
            child: Container(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                maxLines: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.9),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: constraints.biggest.width - 40,
              height: 20,
            ),
          ),
          alignment: Alignment.topCenter,
        ),
      );
    });
  }
}

// ignore: must_be_immutable
class _PopupWidget extends StatefulWidget {
  final _PopupWidgetState state = _PopupWidgetState();
  final Widget child;
  
  show(bool isShow) {
    state.show(isShow);
  }

  _PopupWidget(this.child);

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _PopupWidgetState extends State<_PopupWidget> {
  bool isShow = false;
  show(bool isShow) {
    if (mounted) {
      setState(() {
        this.isShow = isShow;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 250),
        opacity: (isShow ? 1.0 : 0),
        child: widget.child,
      ),
      duration: Duration(milliseconds: 350),
      curve: Curves.ease,
      margin: (isShow ? EdgeInsets.only(top: 50) : EdgeInsets.only(top:0)),
    );
  }
}