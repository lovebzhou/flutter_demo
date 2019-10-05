import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 提示、命令对话框，类似iOS的UIAlertController，支持Alert、ActionSheet样式。
///
/// final alertDialog = JPAlertDialog(title: '确认删除该图片？');
/// alertDialog.addAction(title: '取消');
///
/// // = 直接通过onPressed处理命令
/// alertDialog.addAction(
///   title: '删除',
///   action: 'delete', // 可选
///   isDestructiveAction: true,
///   onPressed: () {
///     bloc.removeImage(photo);
///     Navigator.pop(context);
///   },
/// );
///
/// // Alert样式显示
/// alertDialog.showAlert(context: context);
///
/// // 底部取消按钮
/// alertDialog.addCancelAction('取消');
/// // ActionSheet样式显示
/// alertDialog.showActionSheet(context: context);
///
/// // = 通过返回值处理命令
/// alertDialog.showAlert(context: context).then((result) {
///   if (result == 'delete') {
///
///   }
/// });
///
class JPAlertDialog {
  /// 标题
  String title;

  /// 内容
  String content;

  /// 命令按钮
  List<_JPAlertAction> _actions = [];

  _JPAlertAction _cancel;

  JPAlertDialog({this.title, this.content});

  /// 显示Alert对话框
  Future<T> showAlert<T>({BuildContext context}) {
    // if (kDebugMode) {
    //   return Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //     return CupertinoAlertDialog(
    //       title: title != null
    //           ? Text(
    //               title,
    //             )
    //           : null,
    //       content: content != null ? Text(content) : null,
    //       actions: _buildAlertActions(context),
    //     );
    //   },));
    // }

    return showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: title != null
              ? Text(
                  title,
                )
              : null,
          content: content != null ? Text(content) : null,
          actions: _buildAlertActions(context),
        );
      },
    );
  }

  /// 显示ActionSheet
  Future<T> showActionSheet<T>({BuildContext context}) async {
    CupertinoActionSheetAction cancelButton;
    if (_cancel != null) {
      cancelButton = CupertinoActionSheetAction(
        child: Text(_cancel.title),
        onPressed: _cancel.onPressed ??
            () {
              _onPressd(context, _cancel);
            },
      );
    }

    // if (kDebugMode) {
    //   return Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //     return CupertinoActionSheet(
    //       title: title != null ? Text(title) : null,
    //       message: content != null ? Text(content) : null,
    //       actions: _buildActionSheetActions(context),
    //       cancelButton: cancelButton,
    //     );
    //   }));
    // }

    return showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return CupertinoActionSheet(
          title: title != null ? Text(title) : null,
          message: content != null ? Text(content) : null,
          actions: _buildActionSheetActions(context),
          cancelButton: cancelButton,
        );
      },
    );
  }

  /// 添加命令
  void addAction(
      {@required String title,
      String action,
      VoidCallback onPressed,
      bool isDefaultAction,
      bool isDestructiveAction}) {
    assert(title != null);

    final alertAction = _JPAlertAction(
        title: title,
        action: action,
        onPressed: onPressed,
        isDefaultAction: isDefaultAction,
        isDestructiveAction: isDestructiveAction);

    _actions.add(alertAction);
  }

  /// 添加取消按钮，仅ActionSheet使用
  void addCancelAction(
      {@required String title,
      String action,
      VoidCallback onPressed,
      bool isDefaultAction,
      bool isDestructiveAction}) {
    assert(title != null);

    _cancel = _JPAlertAction(
        title: title,
        onPressed: onPressed,
        isDefaultAction: isDefaultAction,
        isDestructiveAction: isDestructiveAction);
  }

  List<Widget> _buildAlertActions(BuildContext context) {
    final actions = _actions.map((_JPAlertAction action) {
      return CupertinoDialogAction(
        onPressed: action.onPressed ??
            () {
              _onPressd(context, action);
            },
        isDestructiveAction: action.isDestructiveAction ?? false,
        isDefaultAction: action.isDefaultAction ?? false,
        child: Text(action.title),
      );
    }).toList();

    return actions;
  }

  List<Widget> _buildActionSheetActions(BuildContext context) {
    final actions = _actions.map((_JPAlertAction action) {
      return CupertinoActionSheetAction(
        onPressed: action.onPressed ??
            () {
              _onPressd(context, action);
            },
        isDestructiveAction: action.isDestructiveAction ?? false,
        isDefaultAction: action.isDefaultAction ?? false,
        child: Text(action.title),
      );
    }).toList();

    return actions;
  }

  void _onPressd(BuildContext context, _JPAlertAction action) {
    Navigator.pop(context, action.action ?? action.title);
  }
}

/// 警告对话框命令按钮数据结构
class _JPAlertAction {
  final String title;

  final String action;

  final VoidCallback onPressed;

  final bool isDefaultAction;

  final bool isDestructiveAction;

  _JPAlertAction(
      {@required this.title,
      this.action,
      this.onPressed,
      this.isDefaultAction,
      this.isDestructiveAction});
}
