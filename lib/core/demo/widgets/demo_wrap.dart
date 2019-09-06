import 'package:flutter/material.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}

class CastFilter extends StatefulWidget {
  @override
  State createState() => CastFilterState();
}

class CastFilterState extends State<CastFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Aaron Burr', 'AB'),
    const ActorFilterEntry('Alexander Hamilton', 'AH'),
    const ActorFilterEntry('Eliza Hamilton', 'EH'),
    const ActorFilterEntry('James Madison', 'JM'),
  ];
  List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets sync* {
    for (ActorFilterEntry actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          selected: _filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(actor.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: actorWidgets.toList(),
        ),
        Text('Look for: ${_filters.join(', ')}'),
      ],
    );
  }
}

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
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue, width: 0.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              onDeleted: () {},
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue.shade900,
                child: Text('ML'),
              ),
              label: Text('Lafayette Addf'),
              shape: ContinuousRectangleBorder(
                side: BorderSide(color: Colors.green, width: 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            InputChip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('HM')),
              label: Text('Input Chip(not selected)'),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                print('On Pressed');
              },
            ),
            InputChip(
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('JL')),
              label: Text('Laurens'),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue, width: 0.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              selected: true,
            ),
            ChoiceChip(
              selected: false,
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('AH')),
              label: Text('ChoiceChip(false)'),
            ),
            ChoiceChip(
              selected: true,
              avatar: CircleAvatar(
                  backgroundColor: Colors.blue.shade900, child: Text('AH')),
              label: Text('ChoiceChip(true)'),
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
          Divider(),
          ListTile(
            title: Text('FilterChip'),
          ),
          CastFilter(),
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
