import 'package:flutter/material.dart';

class DemoBottomNavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoBottomNavigationBarState();
}

class _DemoBottomNavigationBarState extends State<DemoBottomNavigationBar> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar'),
      ),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 30.0,
          child: Center(
            child: Text('current index : $_currentIndex'),
          ),
        )
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    Widget navigationBar = BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(title: Text('Home'), icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            title: Text('Message'), icon: Icon(Icons.message)),
        BottomNavigationBarItem(title: Text('Me'), icon: Icon(Icons.person)),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      currentIndex: _currentIndex,
    );
    return navigationBar;
  }
}
