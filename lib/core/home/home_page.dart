import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

/// 首页
class HBHomePage extends StatefulWidget {
  static const String title = '首页';
  static const IconData iconData = Icons.home;

  @override
  State<StatefulWidget> createState() => _HBHomePageState();
}

class _HBHomePageState extends State<HBHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HBHomePage.title),
      ),
      body: WillPopScope(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(HBHomePage.title),
                RaisedButton(
                  child: Text("Popup Message"),
                  onPressed: () {
                    PopupMessage.showMessage(
                        context: context,
                        message: "大发范德萨发发大水范德萨范德萨范德萨范德萨范德萨范德萨范德萨范德萨范德萨");
                  },
                ),
                RaisedButton(
                  child: Text('Popup Menu'),
                  onPressed: () {
                    List<Map> menuItems = [
                      {'title': 'item1'},
                      {
                        'title': 'item2',
                      }
                    ];
                    Size screenSize = MediaQuery.of(context).size;
                    Size menuSize = Size(100, 170);
                    double left = screenSize.width - menuSize.width - 20;
                    double top = 100;
                    PopupMenu().showMenu(
                      context: context,
                      menus: menuItems,
                      edge: EdgeInsets.only(
                          left: left,
                          right: 20,
                          top: top,
                          bottom: screenSize.height - top - menuSize.height),
                      size: menuSize,
                      onTap: (item) {
                        Log.d('item:${item["title"]}');
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Log.d('$runtimeType onWillPop');
          PopupMenu().dismiss();
          return false;
        },
      ),
    );
  }
}
