import 'package:flutter/material.dart';

class DemoImage extends StatelessWidget {
  static const String title = '图片演示';
  @override
  Widget build(BuildContext context) {
    Widget body = Image.asset('assets/image/6.jpg');
    body = Stack(
      children: <Widget>[
        Positioned(
          child: body,
        ),
        // Positioned(
        //   child: OverlapSquare(),
        // ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }
}

class OverlapSquare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: OverflowBox(
          maxHeight: 250,
          maxWidth: 250,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
