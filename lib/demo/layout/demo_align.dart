import 'package:flutter/material.dart';

class DemoAlign extends StatelessWidget {
  static String title = 'Algin布局演示';

  @override
  Widget build(BuildContext context) {
    Widget body = ListView(
      children: <Widget>[
        _buildItem(
          context,
          Column(
            children: <Widget>[
              Container(
                child: Text('Title'),
                padding: EdgeInsets.all(4.0),
              ),
              ClipRect(
                child: Align(
                  // alignment: Alignment.topLeft,
                  child: _buildContent(context, 'topLeft'),
                  // widthFactor: 3.0,
                  heightFactor: 0.2,
                ),
              ),
            ],
          ),
        ),
        _buildItem(
          context,
          Align(
            alignment: Alignment.topCenter,
            child: _buildContent(context, 'topCenter'),
          ),
        ),
        _buildItem(
          context,
          Align(
            alignment: Alignment.topRight,
            child: _buildContent(context, 'topRight'),
          ),
        ),
        _buildItem(
          context,
          Align(
            alignment: Alignment.centerLeft,
            child: _buildContent(context, 'centerLeft'),
          ),
        ),
        _buildItem(
          context,
          Align(
            alignment: Alignment.center,
            child: _buildContent(context, 'center'),
          ),
        ),
        _buildItem(
          context,
          Align(
            alignment: Alignment.centerRight,
            child: _buildContent(context, 'centerRight'),
          ),
        ),
      ],
    );

    body = Container(
      child: body,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    );

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(DemoAlign.title),
      ),
      // backgroundColor: Colors.grey[200],
      body: body,
    );
  }

  Widget _buildContent(BuildContext context, String content) {
    return Container(
      height: 40.0,
      padding: EdgeInsets.all(8.0),
      child: Text(content),
      color: Colors.blue[300],
    );
  }

  Widget _buildItem(BuildContext context, Widget child) {
    Color color = (Theme.of(context).brightness == Brightness.dark)
        ? Colors.white10
        : Colors.black12;
    List<Widget> children = [
      Expanded(
        child: child,
      )
    ];

    Widget body = Column(children: children);
    body = Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: body,
    );
    return body;
  }
}
