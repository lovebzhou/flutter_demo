import 'package:flutter/material.dart';

class DemoAlign extends StatelessWidget {
  static String title = 'Algin布局演示';

  @override
  Widget build(BuildContext context) {
    Widget body = ListView(
      children: <Widget>[
        Align(
          child: Container(
            child: _buildItem(context, _buildContent(context, 'Text')),
          ),
        ),
        ClipRect(
          child: Align(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: _buildItem(context, _buildContent(context, 'Text')),
            ),
            heightFactor: 0.5,
          ),
        ),
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
        Container(
          color: Colors.white30,
          height: 80.0,
          width: 100.0,
          child: ClipRect(
            child: Align(
              child: Container(
                color: Colors.purple,
                height: 60.0,
                width: 60.0,
              ),
              heightFactor: 0.2,
            ),
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
        _buildItem(
          context,
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildContent(context, 'bottomLeft'),
          ),
        ),
        _buildItem(
          context,
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildContent(context, 'bottomCenter'),
          ),
        ),
        _buildItem(
          context,
          Align(
            alignment: Alignment.bottomRight,
            child: _buildContent(context, 'bottomRight'),
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
