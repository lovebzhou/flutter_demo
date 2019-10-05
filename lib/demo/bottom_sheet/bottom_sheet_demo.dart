import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

class BottomSheetDemo extends StatelessWidget {
  static String title = 'BottomSheet演示';
  final String roundBorderStyle = 'ClipRRect';
  @override
  Widget build(BuildContext context) {
    Widget route;

    
    route = ListView(
      children: <Widget>[
        ListTile(
          title: Text('showModalBottomSheet'),
          onTap: () {
            _showModalBottomSheet(context);
          },
        ),

        /// for canvasColor: Colors.transparent
        Builder(
          builder: (context) {
            return ListTile(
              title: Text('showModalBottomSheet(Round Top)'),
              onTap: () {
                _showModalBottomSheet2(context);
              },
            );
          },
        ),
        Builder(
          builder: (context) {
            return ListTile(
              title: Text('_showBottomSheet'),
              onTap: () {
                _showBottomSheet(context);
              },
            );
          },
        ),
      ],
    );

    route = Scaffold(
      appBar: AppBar(
        title: Text(BottomSheetDemo.title),
      ),
      body: route,
    );

    route = Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: Container(color: Colors.white, child: route),
    );

    return route;
  }

  void _showModalBottomSheet(BuildContext context) {
    Widget route = _makeRoute(context);

    BorderRadius borderRadius;
    borderRadius = BorderRadius.only(
      topLeft: Radius.circular(10.0),
      topRight: Radius.circular(10.0),
    );

    ShapeBorder shapeBorder;
    // shapeBorder = RoundedRectangleBorder(
    //   side: BorderSide(width: 1),
    //   borderRadius: borderRadius,
    // );

    if (roundBorderStyle == 'ClipRRect') {
      route = ClipRRect(
        borderRadius: borderRadius,
        child: route,
      );
    }

    showModalBottomSheet(
      shape: shapeBorder,
      elevation: 5,
      context: context,
      builder: (context) => route,
    );
  }

  void _showModalBottomSheet2(BuildContext context) {
    Widget route = _makeRoute(context);

    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(10.0),
      topRight: Radius.circular(10.0),
    );

    EdgeInsets padding;

    if (roundBorderStyle == 'ClipRRect') {
      route = ClipRRect(
        borderRadius: borderRadius,
        child: route,
      );
    }

    // 圆角
    route = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.3),
            offset: Offset(0, -3),
            blurRadius: 10.0,
          )
        ],
        borderRadius: borderRadius,
      ),
      child: route,
    );

    showModalBottomSheet(context: context, builder: (context) => route);
  }

  void _showBottomSheet(BuildContext context) {
    Widget route = _makeRoute(context);
    route = Scaffold(
      body: route,
    );
    showBottomSheet(
      context: context,
      builder: (context) => route,
    );

    // Future.delayed(Duration(seconds: 3), () {
    //   controller.close();
    // });
  }

  Widget _makeRoute(BuildContext context) {
    Widget route = ListView.builder(
      itemCount: 10,
      itemBuilder: (_, i) {
        return ListTile(
          title: Text('item $i'),
          onTap: () {
            Log.d('Item $i');
          },
        );
      },
    );

    route = Column(
      children: <Widget>[
        Container(
          // width: double.infinity,
          height: 44.0,
          padding: EdgeInsets.only(left: 15.0),
          color: Colors.blue,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Title'),
          ),
        ),
        Expanded(
          child: route,
        ),
      ],
    );

    route = Container(
      // color: Colors.white,
      child: route,
      height: 300,
    );

    route = SafeArea(child: route);

    return route;
  }
}
