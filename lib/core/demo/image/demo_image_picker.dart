import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DemoImagePicker extends StatefulWidget {
  static const String title = 'ImagePicker Demo';
  @override
  _DemoImagePickerState createState() => _DemoImagePickerState();
}

class _DemoImagePickerState extends State<DemoImagePicker> {
  File _image;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
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
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
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
                    ImagePicker.pickVideo(source: ImageSource.gallery).then((File file) {
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
