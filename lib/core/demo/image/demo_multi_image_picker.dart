import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class DemoMultiImagePicker extends StatefulWidget {
  static const String title = 'MultiImagePicker Demo';
  @override
  _DemoMultiImagePickerState createState() => new _DemoMultiImagePickerState();
}

class _DemoMultiImagePickerState extends State<DemoMultiImagePicker> {
  List<Asset> images = List<Asset>();
  String _error = '';
  @override
  void dispose() {
    print('#dispose#${runtimeType.toString()}');
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = '';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: false,
        // selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#4A4A4A",
          statusBarColor: '#4A4A4A',
          selectCircleStrokeColor: "#FFFFFF",
          actionBarTitle: "选择照片",
          allViewTitle: "全部照片",
          useDetailsView: true,
        ),
      );

      for (var r in resultList) {
        var t = await r.filePath;
        print(t);
      }
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (resultList.isEmpty) return;

    setState(() {
      images.addAll(resultList);
      _error = error;
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

    if (_error.isNotEmpty) {
      children.add(Center(child: Text('Error: $_error')));
    }

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
