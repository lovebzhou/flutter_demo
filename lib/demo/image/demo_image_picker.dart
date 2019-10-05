import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DemoImagePicker extends StatefulWidget {
  static const String title = 'ImagePicker Demo';
  @override
  _DemoImagePickerState createState() => _DemoImagePickerState();
}

class _DemoImagePickerState extends State<DemoImagePicker> {
  File _file;

  @override
  void dispose() {
    print('#dispose#${runtimeType.toString()}');
    _file?.delete();
    super.dispose();
  }

  Future getImage(ImageSource source) async {
    var file = await ImagePicker.pickImage(source: source);
    _file?.delete();
    setState(() {
      _file = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoImagePicker.title),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: _file == null
                  ? Text('No image selected.')
                  : Image.file(_file),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  child: Text('Camera'),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                ),
                RaisedButton(
                  child: Text('Gallery'),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                ),
                RaisedButton(
                  child: Text('Video'),
                  onPressed: () {
                    ImagePicker.pickVideo(source: ImageSource.gallery)
                        .then((File file) {
                      if (file == null) return;
                      print(file.path);
                    });
                  },
                ),
                RaisedButton(
                  child: Text('Video2'),
                  onPressed: () {
                    ImagePicker.pickVideo(source: ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
