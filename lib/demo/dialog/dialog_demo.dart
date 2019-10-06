import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';
import 'package:flutter_demo/widgets/top_sheet.dart';

class DialogDemo extends StatelessWidget {
  static String title = 'Dialog Demos';
  final String roundBorderStyle = 'ClipRRect';
  @override
  Widget build(BuildContext context) {
    Widget route;

    route = ListView(
      children: <Widget>[
        ListTile(
          title: Text('Alert Dialog'),
          onTap: () {
            _showAlertDialog(context);
          },
        ),
        ListTile(
          title: Text('Alert Action Sheet'),
          onTap: () {
            _showAlertDialog(context, showActionSheet: true);
          },
        ),

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
              title: Text('showBottomSheet'),
              onTap: () {
                _showBottomSheet(context);
              },
            );
          },
        ),

        Builder(
          builder: (context) {
            return ListTile(
              title: Text('showModalTopSheet'),
              onTap: () {
                _showModalTopSheet(context);
              },
            );
          },
        ),

        Builder(
          builder: (context) {
            return ListTile(
              title: Text('showGeneralDialog'),
              onTap: () {
                _showGeneralDialog(context);
              },
            );
          },
        ),
      ],
    );

    route = Scaffold(
      appBar: AppBar(
        title: Text(DialogDemo.title),
      ),
      body: route,
    );

    route = Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: Container(color: Colors.white, child: route),
    );

    return route;
  }

  void _showAlertDialog(BuildContext context, {bool showActionSheet}) {
    JPAlertDialog alertDialog =
        JPAlertDialog(title: 'title', content: 'this is a demo content');
    alertDialog.addAction(title: '查看数据', action: 'view');
    alertDialog.addAction(title: '编辑数据', action: 'edit');
    alertDialog.addAction(
        title: '删除数据',
        action: 'delete',
        isDestructiveAction: true,
        onPressed: () {
          Navigator.of(context).pop();
          Log.d('删除数据');
        });

    alertDialog.addCancelAction(title: '取消');

    if (showActionSheet != null && showActionSheet) {
      alertDialog.showActionSheet(context: context);
    } else {
      alertDialog.showAlert(context: context);
    }
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
        // color: Colors.white,
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
      backgroundColor: Colors.black26,
      builder: (context) => route,
    );

    // Future.delayed(Duration(seconds: 3), () {
    //   controller.close();
    // });
  }

  void _showModalTopSheet(BuildContext context) {
    Widget route = _makeRoute(context);

    BorderRadius borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(10.0),
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
        // color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.3),
            offset: Offset(0, 3),
            blurRadius: 10.0,
          )
        ],
        borderRadius: borderRadius,
      ),
      child: route,
    );

    showModalTopSheet(context: context, builder: (context) => route);
  }

  void _showGeneralDialog(BuildContext context) {
    Widget route = _makeRoute(context);

    route = Container(
      child: route,
      width: 300,
      height: 300,
    );

    route = Material(
      color: Colors.transparent,
      child: Center(
        child: route,
      ),
    );

    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black45,
      transitionDuration: Duration(microseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) => route,
    );
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
        _buildSection(context, title: 'Header'),
        Expanded(
          child: route,
        ),
        _buildSection(context, title: 'Footer', commitTitle: '关闭',
            commitCallback: () {
          Navigator.of(context).pop();
        }),
      ],
    );

    route = Container(
      color: Colors.white,
      child: route,
      height: 300,
    );

    route = SafeArea(child: route);

    return route;
  }

  Widget _buildSection(BuildContext context,
      {String title, String commitTitle, VoidCallback commitCallback}) {
    List<Widget> children = [
      Text(title ?? 'no title'),
    ];

    if (commitCallback != null) {
      children.add(Expanded(child: Container()));
      children.add(FlatButton(
        child: Text(commitTitle ?? 'Done'),
        onPressed: commitCallback,
      ));
    }

    return Container(
      color: Colors.blue,
      height: 44.0,
      padding: EdgeInsets.only(left: 15.0),
      child: Row(
        children: children,
      ),
    );
  }
}
