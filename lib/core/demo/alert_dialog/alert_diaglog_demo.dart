import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

class AlertDialogDemo extends StatelessWidget {
  static String title = 'AlertDialog窗口演示';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AlertDialogDemo.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(title: Text('AlertDialog'), onTap:() {
            _showAlertDialog(context);
          } ,),
          ListTile(title: Text('AlertActionSheet'), onTap:() {
            _showAlertDialog(context, showActionSheet: true);
          } ,),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context, {bool showActionSheet}) {
    JPAlertDialog alertDialog = JPAlertDialog(title: 'title', content: 'this is a demo content');
    alertDialog.addAction(title: '查看数据', action: 'view');
    alertDialog.addAction(title: '编辑数据', action: 'edit');
    alertDialog.addAction(title: '删除数据', action: 'delete', isDestructiveAction: true, onPressed: () {
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
}
