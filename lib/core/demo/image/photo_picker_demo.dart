import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';

class DemoPhotoPicker extends StatefulWidget {
  static const String title = 'PhotoPicker Demo';

  @override
  _DemoPhotoPickerState createState() => new _DemoPhotoPickerState();
}

class _DemoPhotoPickerState extends State<DemoPhotoPicker>
    with LoadingDelegate {
  List<AssetEntity> assets = [];

  @override
  void dispose() {
    print('#dispose#${runtimeType.toString()}');
    
    assets.clear();
    PhotoManager.releaseCache();

    super.dispose();
  }

  @override
  Widget buildBigImageLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    return Center(
      child: Container(
        width: 50.0,
        height: 50.0,
        child: CupertinoActivityIndicator(
          radius: 25.0,
        ),
      ),
    );
  }

  @override
  Widget buildPreviewLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    return Center(
      child: Container(
        width: 50.0,
        height: 50.0,
        child: CupertinoActivityIndicator(
          radius: 25.0,
        ),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(assets.length, (index) {
        AssetEntity asset = assets[index];
        return AssetImageWidget(
          assetEntity: asset,
          width: 300,
          height: 300,
          boxFit: BoxFit.cover,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            child: Text('照片'),
            onPressed: () {
              _pickAsset(PickType.onlyImage);
            },
          ),
          RaisedButton(
            child: Text('视频'),
            onPressed: () {
              _pickAsset(PickType.onlyVideo);
            },
          ),
          RaisedButton(
            child: Text('全部'),
            onPressed: () {
              _pickAsset(PickType.all);
            },
          ),
        ],
      ),
      Expanded(
        child: buildGridView(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoPhotoPicker.title),
      ),
      body: Column(
        children: children,
      ),
    );
  }

  void _pickAsset(PickType type, {List<AssetPathEntity> pathList}) async {
    List<AssetEntity> imgList = await PhotoPicker.pickAsset(
      // BuildContext required
      context: context,

      /// The following are optional parameters.
      themeColor: Colors.green,
      // the title color and bottom color

      textColor: Colors.white,
      // text color
      padding: 1.0,
      // item padding
      dividerColor: Colors.grey,
      // divider color
      disableColor: Colors.grey.shade300,
      // the check box disable color
      itemRadio: 0.88,
      // the content item radio
      maxSelected: 8,
      // max picker image count
      // provider: I18nProvider.english,
      provider: I18nProvider.chinese,
      // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
      rowCount: 3,
      // item row count

      thumbSize: 150,
      // preview thumb size , default is 64
      sortDelegate: SortDelegate.common,
      // default is common ,or you make custom delegate to sort your gallery
      checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
        activeColor: Colors.white,
        unselectedColor: Colors.white,
        checkColor: Colors.green,
      ),
      // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox

      loadingDelegate: this,
      // if you want to build custom loading widget,extends LoadingDelegate, [see example/lib/main.dart]

      badgeDelegate: const DurationBadgeDelegate(),
      // badgeDelegate to show badge widget

      pickType: type,

      photoPathList: pathList,
    );

    if (!mounted) return;

    if (imgList.isEmpty) return;

    setState(() {
      assets.addAll(imgList);
    });
  }
}

class AssetImageWidget extends StatelessWidget {
  final AssetEntity assetEntity;
  final double width;
  final double height;
  final BoxFit boxFit;

  const AssetImageWidget({
    Key key,
    @required this.assetEntity,
    this.width,
    this.height,
    this.boxFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (assetEntity == null) {
      return _buildContainer();
    }
    return FutureBuilder<Size>(
      builder: (c, s) {
        if (!s.hasData) {
          return Container();
        }
        var size = s.data;
        return FutureBuilder<Uint8List>(
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return _buildContainer(
                child: Image.memory(
                  snapshot.data,
                  width: width,
                  height: height,
                  fit: boxFit,
                ),
              );
            } else {
              return _buildContainer();
            }
          },
          future: assetEntity.thumbDataWithSize(
            size.width.toInt(),
            size.height.toInt(),
          ),
        );
      },
      future: assetEntity.size,
    );
  }

  Widget _buildContainer({Widget child}) {
    child ??= Container();
    return Container(
      width: width,
      height: height,
      child: child,
    );
  }
}
