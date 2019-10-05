import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Focus演示
class HBFocusPage extends StatefulWidget {
  static const String title = 'Focus演示';
  static const IconData iconData = Icons.cake;
  @override
  State<StatefulWidget> createState() => _HBFocusPageState();
}

class _HBFocusPageState extends State<HBFocusPage> {
  Color _color = Colors.yellow;

  bool _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      print('Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.keyR) {
        print('Changing color to red.');
        setState(() {
          _color = Colors.red;
        });
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.keyG) {
        print('Changing color to green.');
        setState(() {
          _color = Colors.green;
        });
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.keyB) {
        print('Changing color to blue.');
        setState(() {
          _color = Colors.blue;
        });
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(HBFocusPage.title),),
      body: FocusScope(
        debugLabel: 'Scope',
        autofocus: true,
        child: DefaultTextStyle(
          style: textTheme.display1,
          child: Focus(
            onKey: _handleKeyPress,
            debugLabel: 'Button',
            child: Builder(
              builder: (BuildContext context) {
                final FocusNode focusNode = Focus.of(context);
                final bool hasFocus = focusNode.hasFocus;
                return GestureDetector(
                  onTap: () {
                    if (hasFocus) {
                      focusNode.unfocus();
                    } else {
                      focusNode.requestFocus();
                    }
                  },
                  child: Center(
                    child: Container(
                      width: 400,
                      height: 100,
                      alignment: Alignment.center,
                      color: hasFocus ? _color : Colors.white,
                      child: Text(hasFocus
                          ? "I'm in color! Press R,G,B!"
                          : 'Press to focus'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
