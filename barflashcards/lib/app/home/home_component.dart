import 'dart:async';

import '../../config/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeComponent extends StatefulWidget {
  @override
  State createState() => new HomeComponentState();
}

class HomeComponentState extends State<HomeComponent> {
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
          TransitionType.inFromBottom)
    ];

    return Material(
      color: Colors.deepPurple,
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

    print("Routing --> $route");
    Application.router.navigateTo(
      context,
      route,
      transition: TransitionType.custom,
      transitionBuilder: customTransition,
      transitionDuration: const Duration(milliseconds: 600),
    );
  }
}
