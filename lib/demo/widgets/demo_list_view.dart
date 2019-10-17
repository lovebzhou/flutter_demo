import 'dart:math';

import 'package:flutter/material.dart';

/// 演示ListView及各种Row的MainAxisAlignment
class DemoListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoListViewState();
}

class _DemoListViewState extends State<DemoListView> {
  final int itemCount = 60;
  final int crossAxisCount = 3;

  final bool isSingle = false;

  List<bool> _selections;

  @override
  void initState() {
    super.initState();

    _selections = List.filled(itemCount, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo ListView'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget body = ListView.builder(
      itemCount: itemCount ~/ crossAxisCount,
      itemBuilder: (context, i) {
        List<Widget> children = [];

        final t = i * crossAxisCount;
        final n = min(crossAxisCount + t, itemCount);
        for (int j = t; j < n; ++j) {
          final color = _selections[j] ? Colors.blue : Colors.grey;
          Widget item = RaisedButton(
            child: Text('$j'),
            color: color,
            onPressed: () {
              _onItemPressed(context, j);
            },
          );
          // item = Expanded(child: item,);
          children.add(item);
        }

        String mainAxisAlignmentString;
        MainAxisAlignment mainAxisAlignment;
        switch (i % 6) {
          case 0:
            mainAxisAlignment = MainAxisAlignment.center;
            mainAxisAlignmentString = 'center';
            break;
          case 1:
            mainAxisAlignment = MainAxisAlignment.spaceAround;
            mainAxisAlignmentString = 'spaceAround';
            break;
          case 2:
            mainAxisAlignment = MainAxisAlignment.spaceBetween;
            mainAxisAlignmentString = 'spaceBetween';
            break;
          case 3:
            mainAxisAlignment = MainAxisAlignment.spaceEvenly;
            mainAxisAlignmentString = 'spaceEvenly';
            break;
          case 4:
            mainAxisAlignment = MainAxisAlignment.end;
            mainAxisAlignmentString = 'end';
            break;
          default:
            mainAxisAlignment = MainAxisAlignment.start;
            mainAxisAlignmentString = 'start';
        }

        Widget item = Row(
          mainAxisAlignment: mainAxisAlignment,
          children: children,
        );

        item = Column(
          children: <Widget>[Text(mainAxisAlignmentString), item],
        );

        return item;
      },
    );

    return body;
  }

  void _onItemPressed(BuildContext context, int index) {
    if (isSingle) {
    } else {
      setState(() {
        _selections[index] = !_selections[index];
      });
    }
  }
}
