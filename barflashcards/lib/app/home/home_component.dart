import 'dart:async';

import 'package:barflashcards/app/settings/app_settings.dart';
import 'package:barflashcards/config/application.dart';
import 'package:barflashcards/config/routes.dart';
import 'package:barflashcards/database/dbhelper.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeComponent extends StatefulWidget {
  @override
  State createState() => new _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
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

    setState(() {
      final f = getColorSetting();
      f.then((color) {
        _color = color;
        debugPrint("getting color! --> $_color");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var menuWidgets = <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: 35.0),
        child: Image(
            image: AssetImage("assets/images/barflashcard_logo.png"),
            width: 200.0),
      ),
      menuButton(context, "Cocktails", "cocktails", TransitionType.native),
      menuButton(context, "Beers", "beers", TransitionType.inFromRight),
      menuButton(context, "Wine", "wines", TransitionType.inFromLeft),
      menuButton(context, "Non-Alcoholic", "non-alcoholic",
          TransitionType.inFromBottom),
      menuButton(context, "Settings", "settings", TransitionType.fadeIn),
      menuButton(context, "Login", "login", TransitionType.native)
    ];

    setState(() {
      final f = getColorSetting();
      f.then((color) {
        _color = color;
        debugPrint("getting color! --> $_color");
      });
    });
    debugPrint("returning HomeComponent! --> $_color");
    return Material(
      color: _color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: menuWidgets,
      ),
    );
  }

  // helpers
  Widget menuButton(BuildContext context, String title, String destination,
      TransitionType transitionType) {
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
            tappedMenuButton(context, transitionType, destination);
          },
        ),
      ),
    );
  }

  // actions
  void tappedMenuButton(BuildContext context, TransitionType transitionType,
      [String destination = ""]) {
    String message = "";
    String hexCode = "#FFFFFF";

    String route = "/$destination?message=$message&color_hex=$hexCode";

    var customTransition = (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return ScaleTransition(
        scale: animation,
        child: RotationTransition(
          turns: animation,
          child: child,
        ),
      );
    };

    Routes.navigateTo(
        context: context, route: route, transition: TransitionType.native);
  }
}

Future<Color> getColorSetting() async {
  return AppSettings.get().getColorSettings();
}
