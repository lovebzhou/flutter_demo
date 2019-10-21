import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/log_util.dart';
import 'package:flutter_demo/widgets/expansion_tile.dart';
import 'package:flutter_demo/widgets/grid_tile.dart';

/// 演示ListView及各种Row的MainAxisAlignment
class DemoListViewExpansion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoListViewExpansionState();
}

class _DemoListViewExpansionState extends State<DemoListViewExpansion> {
  @override
  void initState() {
    super.initState();
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
    Widget body = ListView(children: <Widget>[
      ExpansionTile(
        // leading: Icon(Icons.folder),
        title: Text('2019'),
        children: <Widget>[
          _buildGridView(context),
        ],
      ),
      ZBExpansionTile(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        title: Text("2020"),
        trailing: Icon(Icons.expand_more),
        headerColor: Colors.grey,
        expandedHeaderColor: Colors.white,
        children: <Widget>[
          _buildGridTile(context),
        ],
      ),
      ZBExpansionTile(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        title: Text("2021"),
        trailing: Icon(Icons.expand_more),
        headerColor: Colors.grey,
        expandedHeaderColor: Colors.white,
        children: <Widget>[
          _buildGridView(context),
        ],
      ),
    ]);

    body = Theme(
        child: body,
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent));

    return body;
  }

  Widget _buildGridView(BuildContext context) {
    Widget child = GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 3.0,
      ),
      itemBuilder: (c, i) {
        return RaisedButton(
          child: Text('button $i'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          onPressed: () {
            Log.d('button $i onclick');
          },
        );
      },
      itemCount: 20,
    );

    // child = IntrinsicHeight(
    //   child: child,
    // );
    child = Container(
      child: child,
      height: 200.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    );
    return child;
  }

  Widget _buildGridTile(BuildContext context) {
    Widget child = ZBGridTile(
      itemCount: 13,
      crossAxisCount: 3,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      childAspectRatio: 3.0,
      itemBuilder: (context, i) {
        return RaisedButton(
          child: Text('button $i'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          onPressed: () {
            Log.d('button $i onclick');
          },
        );
      },
    );

    child = Container(
      child: child,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    );
    return child;
  }
}
