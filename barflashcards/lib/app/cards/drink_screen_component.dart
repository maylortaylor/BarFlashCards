import 'package:barflashcards/models/drink.dart';
import 'package:flutter/material.dart';

class DrinkScreenComponent extends StatefulWidget {
  final Drink drink;
  DrinkScreenComponent(this.drink);

  @override
  State<StatefulWidget> createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreenComponent> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: widget.drink.name,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            backgroundColor: Colors.blue,
            body: Center(
              child: Card(
                  child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(widget.drink.name,
                          textAlign: TextAlign.center,
                          textScaleFactor: 10.0,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor)))),
            ),
            bottomNavigationBar: BottomAppBar(
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () => Navigator.pushNamed(context, '/'),
                  ),
                  IconButton(
                    icon: Icon(Icons.category),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            )));
  }
}
