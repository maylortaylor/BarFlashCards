import 'package:flutter/material.dart';

class FlashCardComponent extends StatelessWidget {
  FlashCardComponent(
      {String cocktail = "",
      Color color = const Color(0xFFFFFFFF),
      String result})
      : this.cocktail = cocktail,
        this.color = color,
        this.result = result;

  final String cocktail;
  final Color color;
  final String result;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: cocktail,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: color,
        body: Center(
          child: Card(
              child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(cocktail,
                      textAlign: TextAlign.center,
                      textScaleFactor: 10.0,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor)))),
        ),
      ),
    );
  }
}
