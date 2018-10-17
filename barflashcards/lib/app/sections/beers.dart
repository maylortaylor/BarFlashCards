import 'dart:async';

import 'package:barflashcards/app/cards/drink_screen_component.dart';
import 'package:barflashcards/models/drink.dart';
import 'package:barflashcards/services/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BeersComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BeersComponentState();
}

class _BeersComponentState extends State<BeersComponent> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Drink> beers;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> drinksSub;

  @override
  void initState() {
    super.initState();

    beers = new List();

    drinksSub?.cancel();
    drinksSub = db.getBeerList().listen((QuerySnapshot snapshot) {
      final List<Drink> drinks = snapshot.documents
          .map((documentSnapshot) => Drink.fromObject(documentSnapshot.data))
          .toList();

      setState(() {
        this.beers = drinks;
      });
    });
  }

  @override
  void dispose() {
    drinksSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Beers"),
        ),
        key: scaffoldKey,
        body: Center(
          child: ListView.builder(
              itemCount: beers.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${beers[position].name}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${beers[position].description}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10.0)),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 15.0,
                            child: Text(
                              '${position + 1}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () =>
                          _navigateToDrinkScreen(context, beers[position]),
                    ),
                  ],
                );
              }),
        ));
  }

  void _navigateToDrinkScreen(BuildContext context, Drink drink) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DrinkScreenComponent(drink)),
    );
  }
}
