import 'package:flutter/material.dart';

class DemoWrap extends StatelessWidget {
  static const String title = 'Wrap演示';

  Widget _buildWrap1(BuildContext context) {
    return ChipTheme(
      data: ChipThemeData.fromDefaults(
        // brightness: Brightness.light,
        primaryColor: Colors.blue,
        labelStyle: TextStyle(
          fontSize: 14.0,
        ),
        secondaryColor: Colors.blueGrey,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12.0, left: 12.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: <Widget>[
            Chip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('AH')),
              label: Text('Hamilton'),
            ),
            Chip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('ML')),
              label: Text('Lafayette Addf'),
            ),
            Chip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('HM')),
              label: Text('Mulligan Hello World'),
            ),
            Chip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('JL')),
              label: Text('Laurens'),
            ),
            Chip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('AH')),
              label: Text('Hamilton'),
            ),
            Chip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('ML')),
              label: Text('Lafayette'),
            ),
            Chip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('HM')),
              label: Text('Mulligan'),
            ),
            Chip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('JL')),
              label: Text('Laurens ABC'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body = DefaultTextStyle(
      style: TextStyle(fontSize: 12.0),
      child: ListView(
        children: <Widget>[
          _buildWrap1(context),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Theme(
        data: ThemeData(
          primaryTextTheme: TextTheme(
            subhead: TextStyle(fontSize: 12.0),
          ),
        ),
        child: body,
      ),
    );
  }
}
