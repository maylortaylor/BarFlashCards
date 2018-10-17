import 'dart:async';

import 'package:barflashcards/app/cards/drink_screen_component.dart';
import 'package:barflashcards/models/drink.dart';
import 'package:barflashcards/models/drinkCategories.dart';
import 'package:barflashcards/database/dbhelper.dart';
import 'package:barflashcards/services/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CocktailsComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CocktailsComponentState();
}

class _CocktailsComponentState extends State<CocktailsComponent> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Drink> cocktails;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> drinksSub;

  @override
  void initState() {
    super.initState();

    cocktails = new List();

    drinksSub?.cancel();
    drinksSub = db.getCocktailList().listen((QuerySnapshot snapshot) {
      final List<Drink> drinks = snapshot.documents
          .map((documentSnapshot) => Drink.fromObject(documentSnapshot.data))
          .toList();

      setState(() {
        this.cocktails = drinks;
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
          title: Text("Cocktails"),
        ),
        key: scaffoldKey,
        body: Center(
          child: ListView.builder(
              itemCount: cocktails.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${cocktails[position].name}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${cocktails[position].description}',
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
                          _navigateToDrinkScreen(context, cocktails[position]),
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
