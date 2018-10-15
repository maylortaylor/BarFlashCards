import 'package:barflashcards/models/drink.dart';
import 'package:barflashcards/models/drinkCategories.dart';
import 'package:barflashcards/database/dbhelper.dart';
import 'package:flutter/material.dart';

class WinesComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WinesComponentState();
}

class _WinesComponentState extends State<WinesComponent> {
  BuildContext _ctx;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  DbHelper helper = DbHelper();
  List<Drink> beers;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    if (beers == null) {
      beers = List<Drink>();
      getData();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Wines"),
        ),
        key: scaffoldKey,
        body: Container(child: Center(child: winesListItems())),
        floatingActionButton: FloatingActionButton(
            onPressed: null,
            tooltip: "Add new Wine",
            child: new Icon(Icons.add)));
  }

  ListView winesListItems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(this.beers[position].id.toString())),
                  title: new Text(this.beers[position].name),
                  subtitle: new Text(this.beers[position].description == null
                      ? ""
                      : this.beers[position].description),
                  onTap: () {
                    debugPrint("TAPPED: " + this.beers[position].id.toString());
                  }));
        });
  }

  void getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      final getBeersFuture = helper.getDrinksByCategory(DrinkCategory.Beer);
      getBeersFuture.then((result) {
        debugPrint("GET BEERS FUTURE: $result");

        List<Drink> beerList = List<Drink>();
        count = result.length;

        for (int i = 0; i < count; i++) {
          beerList.add(Drink.fromObject(result[i]));
          debugPrint(beerList[i].name);
        }

        setState(() {
          beers = beerList;
          count = count;
        });

        debugPrint("Items " + count.toString());
      });
    });
  }
}
