import 'package:barflashcards/app/settings/app_settings.dart';
import 'package:barflashcards/app/settings/color_settings.dart';
import 'package:barflashcards/database/dbhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class SettingsComponent extends StatefulWidget {
  @override
  State createState() => new _StateComponentState();
}

class _StateComponentState extends State<SettingsComponent> {
  DbHelper db;
  Color _color;

  @override
  void dispose() {
    db.closeDb();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    db = DbHelper();
    db.initializeDb();
    _color = Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    var settingsMenuWidgets = <Widget>[
      menuButton(context, "Dark", ColorSetting.Dark),
      menuButton(context, "Light", ColorSetting.Light),
      menuButton(context, "Hot", ColorSetting.Hot),
      menuButton(context, "Cool", ColorSetting.Cool),
    ];

    return Material(
      color: Colors.deepPurple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: settingsMenuWidgets,
      ),
    );
  }

  // helpers
  Widget menuButton(BuildContext context, String title, ColorSetting color) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 42.0),
        child: RaisedButton(
          highlightColor: const Color(0x11FFFFFF),
          splashColor: const Color(0x22FFFFFF),
          child: Text(
            title,
            style: TextStyle(
              color: const Color(0xAA001133),
            ),
          ),
          onPressed: () {
            setColorSetting(context, color);
          },
        ),
      ),
    );
  }

  // actions
  void setColorSetting(BuildContext context, ColorSetting color) {
    debugPrint('--- setting color ---> $color');
    final f = AppSettings.get().setColorSetting(color);
    setState(() {
      f.then((newColor) {
        _color = newColor;
      });
    });
  }
}
