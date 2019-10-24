import 'package:flutter/material.dart';

class DemoStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
      appBar: AppBar(
        title: Text('Container Demo'),
      ),
      body: _buildBody(context),
      backgroundColor: Colors.white,
    );
    return body;
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildDemo1(context),
      ],
    );
  }

  Widget _buildDemo1(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100.0,
          color: Colors.yellow,
        ),
        Positioned(
          top: 10.0,
          left: 10.0,
          child: Container(
            color: Colors.blue,
            height: 50,
            width: 100,
          ),
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: Container(
            color: Colors.red,
            height: 50,
            width: 100,
          ),
        ),
         Positioned(
          child: Container(
            color: Colors.green,
            height: 50,
            width: 100,
          ),
        ),
      ],
    );
  }
}
