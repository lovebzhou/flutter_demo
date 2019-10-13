import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/dialog/dialog_demo.dart';
import 'package:flutter_demo/demo/dropdown/demo_dropdown_menu.dart';
import 'package:flutter_demo/demo/file/file_picker_demo.dart';
import 'package:flutter_demo/demo/image/demo_crop_image.dart';
import 'package:flutter_demo/demo/image/demo_image_picker.dart';
import 'package:flutter_demo/demo/image/demo_multi_image_picker.dart';
import 'package:flutter_demo/demo/image/demo_image.dart';
import 'package:flutter_demo/demo/image/photo_picker_demo.dart';
import 'package:flutter_demo/demo/log/demo_alice.dart';
import 'package:flutter_demo/demo/navigator/navigator_demo.dart';
import 'package:flutter_demo/demo/scrollview/demo_nestedscrollview.dart';
import 'package:flutter_demo/demo/scrollview/scrollview_demo.dart';
import 'package:flutter_demo/demo/widgets/demo_widgets.dart';
import 'animations/animation_demo.dart';
import 'layout/layout_demo.dart';
import 'focus_demo/focus_demo.dart';

class Page {
  final Widget widget;
  final String title;

  Page(this.widget, this.title);
}

/// 演示
class HBDemoPage extends StatefulWidget {
  static const String title = '演示';
  static const IconData iconData = Icons.cake;
  @override
  State<StatefulWidget> createState() => _HBDemoPageState();
}

class _HBDemoPageState extends State<HBDemoPage> {
  final _pages = [
    Page(ScrollViewDemo(), ScrollViewDemo.title),
    Page(DialogDemo(), DialogDemo.title),
    Page(DemoWidgets(), DemoWidgets.title),
    Page(NavigatorDemo(), NavigatorDemo.title),
    Page(DropdownMenuDemo(), DropdownMenuDemo.title),
    Page(DemoNestedScrollView(), DemoNestedScrollView.title),
    Page(DemoImagePicker(), DemoImagePicker.title),
    Page(FilePickerDemo(), FilePickerDemo.title),
    Page(DemoPhotoPicker(), DemoPhotoPicker.title),
    Page(DemoMultiImagePicker(), DemoMultiImagePicker.title),
    Page(HBAnimationPage(), HBAnimationPage.title),
    Page(HBLayoutPage(), HBLayoutPage.title),
    Page(DemoAlicePage(), DemoAlicePage.title),
    Page(HBFocusPage(), HBFocusPage.title),
    Page(DemoImage(), DemoImage.title),
    Page(DemoCropImage(), DemoCropImage.title),
  ];

  @override
  Widget build(BuildContext context) {
    final dividerHeight = 1.0 / MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
        title: Text('演示'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          return Divider(
            indent: 15.0,
            height: dividerHeight,
          );
        },
        itemBuilder: (context, index) {
          final page = _pages[index];
          Widget item = ListTile(
            title: Text(page.title),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => page.widget));
            },
          );
          // item = SizedBox(height: 44.0, child: item,);
          return item;
        },
        itemCount: _pages.length,
      ),
    );
  }
}
