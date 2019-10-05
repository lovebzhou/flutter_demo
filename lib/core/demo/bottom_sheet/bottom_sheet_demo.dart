import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

class BottomSheetDemo extends StatelessWidget {
  static String title = 'BottomSheet演示';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BottomSheetDemo.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('showModalBottomSheet'),
            onTap: () {
              _showModalBottomSheet(context);
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
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    Widget route = _makeRoute(context);
    showModalBottomSheet(
      context: context,
      builder: (context) => route,
    );
  }

  void _showBottomSheet(BuildContext context) {
    Widget route = _makeRoute(context);
    route = Scaffold(
      body: route,
    );
    PersistentBottomSheetController controller = showBottomSheet(
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
          width: double.infinity,
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
      child: route,
      height: 300,
    );

    route = SafeArea(child: route);

    return route;
  }
}
