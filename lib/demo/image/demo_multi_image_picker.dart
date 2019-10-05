import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class DemoMultiImagePicker extends StatefulWidget {
  static const String title = 'MultiImagePicker Demo';
  @override
  _DemoMultiImagePickerState createState() => new _DemoMultiImagePickerState();
}

class _DemoMultiImagePickerState extends State<DemoMultiImagePicker> {
  List<Asset> _assets = List<Asset>();
  @override
  void dispose() {
    print('#dispose#${runtimeType.toString()}');

    _assets = null;

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(_assets.length, (index) {
        Asset asset = _assets[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> assets = List<Asset>();

    try {
      assets = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: false,
        // selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          // takePhotoIcon: "chat",
          // selectionFillColor: '#C91B3A',
          // selectionCharacter: '#FFFFFF',
          // selectionStrokeColor: '#C91B3A',
          // backgroundColor: '#4A4A4A',
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#4A4A4A",
          statusBarColor: '#4A4A4A',
          selectCircleStrokeColor: "#FFFFFF",
          actionBarTitle: "选择照片",
          allViewTitle: "全部照片",
          useDetailsView: true,
        ),
      );
    } on Exception catch (e) {
      print('${e.toString()}');
    }

    if (!mounted) return;

    if (assets.isEmpty) return;

    setState(() {
      _assets.addAll(assets);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      Expanded(
        child: buildGridView(),
      )
    ];

    children.add(
      RaisedButton(
        child: Text("Pick images"),
        onPressed: loadAssets,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        title: const Text(DemoMultiImagePicker.title),
      ),
      body: Column(
        children: children,
      ),
    );
  }
}
